# Getting and cleaning data Coursera-Assignment

This is the course project for the Getting and Cleaning Data Coursera course. The R script, run_analysis.R, does the following:

 
  Downloads the dataset if it does not already exist in the working directory
 
  Loads the activity and feature info
 
  Loads both the training and test datasets, keeping only columns which reflect a mean or standard deviation
 
  Loads the activity and subject data for each dataset, and merges those columns with the dataset
 
  Merges the two datasets(train and test)
 
  Converts the activity and subject columns into factors
 
  Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.

The end result is shown in the file tidydata.txt
