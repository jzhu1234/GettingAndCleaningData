# Code Book for Course Project

## Overview
Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Process

The R code "run_analysis.R" runs the following steps to create two independent tidy data sets.

1. Merge the training and test sets to create one data set.

2. Reads `features.txt` and uses only the measurements on the mean and standard
   deviation for each measurement. 

3. Reads `activity_labels.txt` and applies human readable activity names to
   name the activities in the data set.

4. Labels the data set with descriptive names. (Names are converted to lower
   case; underscores and brackets are removed.)

5. Merges the features with activity labels and subject IDs. The result is
   saved as `tidyData.txt`.

6. The average of each measurement for each activity and each subject is merged
   to a second data set. The result is saved as `tidyData2.txt`.

## Variables

- trainfiles - list of train data sets (X_train.txt, y_train.txt, and subject_train.txt)
- testfiles - list of test data sets (X_test.txt, y_test.txt, and subject_test.txt)
- features - table contents of `features.txt`, which is then filtered for the std() and mean() columns
- activity - table contents of `activity_labels.txt`. 
- merged.data - tidy data set according to project description.
- sublen - vector containing subjects
- actlen - number of rows in activitiy
- colength - number of columns in merged.data
- tidy.data - second tidy data set with the average of each measurement for every combination of subject and activity

## Output

### tidyData.txt
10299x68 data frame.

- The first column contains activity names.
- The second column contains subject IDs (1-30).
- The rest of the columns are measurements for mean and std.

#### tidyData2.txt
180x68 data frame.

- The first column contains activity names
- The second column contains subject IDs (1-30).
- The rest of the columns are the averages for each of the 66 measurements.
