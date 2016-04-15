# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# Out-of-scope: 
# - Assumes that you have already downloaded and unzipped the UCI HAR Dataset and are ready to go
# - Ignores the "Inertial Signals" sub-folders;  the data in these subfolders is not specified as part of the scope for this exercise
#

# The main program - gets the job done:  sets the working directory to UCI HAR extract location,  reads and combines the test and train data,  then creates the tidy
# data set with averages by measure (variable), activity and subject
#
#  Author: Jeremy Eade
justDoIt <- function()
{
  # Leave things as we find them.. capture cwd,  then restore at the end
  cwd <- getwd()
  
  # Required libraries
  loadLibrary()
  
  # Prompt for location of the UCI HAR folder
  hciDir <- dlgDir(default=getwd(), title="Please select the UCI HAR folder")$res
  if (length(hciDir)<1)
  {
    print("No UCI HAR folder selected,  exiting")
    return()
  }
  
  # Read reference data
  setwd(hciDir)
  features <- read.table("features.txt")
  activityLabel <- read.table("activity_labels.txt")
  
  # Read test data
  testDir <- paste(hciDir,"test", sep="/")
  testData <- readData(testDir,features,activityLabel,TRUE)

  # Read train data
  trainDir <- paste(hciDir,"train", sep="/")
  trainData <- readData(trainDir,features,activityLabel,FALSE)  
  
  # Combine the data sets
  allData <- bind_rows(testData,trainData)
  allData <- tbl_df(allData)
  
  # Create tidy data set
  tidyData <- tidyData(allData)
  
  # Restore the working directory
  setwd(cwd)
  
  # Return the tidy data set
  return(tidyData)
}

# Creates a tidy data set with the average of each variable for each activity and each subject.
# Output format:  subject | activity | measure | average
#
tidyData <- function(allData)
{
  # Here we do a gather to transpose the 65 measures from columns to rows,  then use group_by on subject, activity and measure,  then finally
  # calculate the average (mean) value according to the group_by criteria.   All in one line of code!  Isn't R the best?
  allData %>% gather("measure","value",4:69) %>% group_by(subject,activity,measure) %>% summarize(avg=mean(value))   
}

# Read test or train data
# Expected data files:  X_test.txt, Y_test.txt and subject_test.txt
readData <- function(dir,features,activityLabel,isTest)
{
  setwd(dir)
  print(getwd())
  
  # Handle file names - change if in test or train folder
  xFile <- "X_test.txt"
  yFile <- "Y_test.txt"
  sFile <- "subject_test.txt"
  
  if (!isTest)
  {
    xFile <- "X_train.txt"
    yFile <- "Y_train.txt"
    sFile <- "subject_train.txt"
  }

  # Process the measurements from X_xxx.txt data
  X <- read.table(xFile,dec=".",quote="\"")
  
  # Label the measurements read from X_xxx.txt
  names(X) <- features$V2
  X <- tbl_df(X)
  
  # We're only interested in mean and standard deviation measurements
  expr <- "mean\\(|std\\("
  X <- X[,grepl(expr,colnames(X))]
  
  # Process the Y_xxx.txt data
  Y <- read.table(yFile)
  Y <- inner_join(Y,activityLabel)
  
  # Label with activity codes;  I've included the activity code and label
  names(Y) <- c("activitycode","activity")
  Y <- tbl_df(Y)
  
  # Combine the measurements (from X_xxx.txt) with the activity codes (from Y_xxx.txt)
  merged <- bind_cols(Y,X)
  subject <- read.table(sFile)
  
  # Add the subjects
  names(subject) <- c("subject")
  merged <- bind_cols(subject,merged)
  
  # We're done
  return(merged)  
}

# Make sure required libraries are loaded
loadLibrary <- function()
{
  library(dplyr)
  library(tidyr)
  library(svDialogs)
}
