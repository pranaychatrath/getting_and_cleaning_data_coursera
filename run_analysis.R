library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename)
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels + features
act_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
act_labels[,2] <- as.character(act_labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
featuresfinal <- grep(".*mean.*|.*std.*", features[,2])
featuresfinal.names <- features[featuresfinal,2]
featuresfinal.names = gsub('-mean', 'Mean', featuresfinal.names)
featuresfinal.names = gsub('-std', 'Std', featuresfinal.names)
featuresfinal.names <- gsub('[-()]', '', featuresfinal.names)


# Load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresfinal]
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresfinal]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# merge datasets and add informative labels
tot_data <- rbind(train, test)
colnames(tot_data) <- c("subject", "activity", featuresfinal.names)

# turn activities & subjects into factors for melt
tot_data$activity <- factor(tot_data$activity, levels = act_labels[,1], labels = act_labels[,2])
tot_data$subject <- as.factor(tot_data$subject)

tot_data.melted <- melt(tot_data, id = c("subject", "activity"))
tot_data.mean <- dcast(tot_data.melted, subject + activity ~ variable, mean)
#writing data to file after mean
write.table(tot_data.mean, "tidydata.txt", row.names = FALSE, quote = FALSE)