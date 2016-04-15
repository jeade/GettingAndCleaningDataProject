# GettingAndCleaningDataProject
Project for Coursera Getting and Cleaning Data

1. Pre-requisites

- You have installed these packages:  dplyr, tidyr, svDialogs
- You have already downloaded and extracted the UCI HAR dataset to your computer, eg:

JE:UCI HAR Dataset je$ ls -l
total 64
-rwxr-xr-x  1 je  staff   4453 Dec 10  2012 README.txt
-rwxr-xr-x  1 je  staff     80 Oct 10  2012 activity_labels.txt
-rwxr-xr-x  1 je  staff  15785 Oct 11  2012 features.txt
-rwxr-xr-x  1 je  staff   2809 Oct 15  2012 features_info.txt
drwxr-xr-x@ 7 je  staff    238 Apr 13 20:38 test
drwxr-xr-x@ 7 je  staff    238 Apr 13 20:42 train
JE:UCI HAR Dataset je$ ls -l test
total 51712
drwxr-xr-x@ 11 je  staff       374 Nov 29  2012 Inertial Signals
-rwxr-xr-x@  1 je  staff  26458166 Nov 29  2012 X_test.txt
-rwxr-xr-x   1 je  staff      7934 Nov 29  2012 subject_test.txt
-rwxr-xr-x@  1 je  staff      5894 Nov 29  2012 y_test.txt
JE:UCI HAR Dataset je$ ls -l train
total 128992
drwxr-xr-x@ 11 je  staff       374 Nov 29  2012 Inertial Signals
-rwxr-xr-x@  1 je  staff  66006256 Nov 29  2012 X_train.txt
-rwxr-xr-x@  1 je  staff     20152 Nov 29  2012 subject_train.txt
-rwxr-xr-x@  1 je  staff     14704 Nov 29  2012 y_train.txt
JE:UCI HAR Dataset je$ 

2. Running the run_analysis.R script

From the R console:

> source("run_analysis.R")
> tidyData <- justDoIt()

(Browse to the "UCI HAR" folder and press "Choose")

[1] "../Data_Cleaning/Project/UCI HAR Dataset/test"
Joining by: "V1"
[1] "../Data_Cleaning/Project/UCI HAR Dataset/train"
Joining by: "V1"
> head(tidyData)
Source: local data frame [6 x 4]
Groups: subject, activity [1]

  subject activity           measure        avg
    (int)   (fctr)             (chr)      (dbl)
1       1   LAYING fBodyAcc-mean()-X -0.9390991
2       1   LAYING fBodyAcc-mean()-Y -0.8670652
3       1   LAYING fBodyAcc-mean()-Z -0.8826669
4       1   LAYING  fBodyAcc-std()-X -0.9244374
5       1   LAYING  fBodyAcc-std()-Y -0.8336256
6       1   LAYING  fBodyAcc-std()-Z -0.8128916
> 


3. How the run_analysis.R script works:

justDoIT() -- the main function, controls the program flow and returns the tidy data set
readData() -- function that reads test and train data sets, with correct labels (activity and measurement)
tidyData() -- function that accepts the merged test and train dataset, and returns a tidy data set with averages per subject/activity/measurement
loadLibrary() -- function that loads required packages


