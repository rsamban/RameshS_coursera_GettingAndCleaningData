# run_analyis.R
This files contains R script that loads the data for activity measurements for 30 volunteers and writes(into file Answer.txt) the average of each of the variables mentioned in the code book for each activity and for each subject.

This code expects that Samsung data is the working directory in the following hierarchy

  * UCI HAR Dataset/features.txt
  * UCI HAR Dataset/activity_labels.txt
  * UCI HAR Dataset/test/X_test.txt
  * UCI HAR Dataset/test/subject_test.txt
  * UCI HAR Dataset/test/y_test.txt
  * UCI HAR Dataset/train/X_train.txt
  * UCI HAR Dataset/train/subject_train.txt
  * UCI HAR Dataset/train/y_train.txt

run_analysis.R file contains a single function runAnalysis() and must be sourced to call the function. To run the anaysis and save the result,

1. source(run_analysis.R)
2. runAnalysis() - save the result "Answers.txt" file in current working directory.
3. result <- runAnalysis();View(result) - save the result "Answers.txt" file in current working directory and view the result in R Data Viewer

## Source code run_analysis.R

```
library(data.table)
library(dplyr)
runAnalysis <- function() {
    # 1. load features names and rename the columns
    ft <- read.csv("./UCI HAR Dataset/features.txt", sep="", header=FALSE)
    names(ft) <- c("seqNo", "featureName")
    
    # load activity labels and rename columns
    al <- read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
    names(al) <- c("activityTypeCode", "activityType")
    
    # Load measured feature values for "test" subjects 
    x_tst <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
    y_tst <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
    s_tst <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)
    
    # Load measured features values for "train" subjects
    x_trn <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
    y_trn <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
    s_trn <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
    
    # Add subject, subjectType and activity type to measured features (for both test and train measurements)
    tst <- cbind(s_tst,subjectType="Test",y_tst,x_tst)
    trn <- cbind(s_trn,subjectType="Train",y_trn,x_trn)
    
    #combine test and training data
    combinedDataSet <- rbind(tst, trn)
    
    # rename column names for combined data set.
    combinedDataSetColumnNames <- c("subject", "subjectType", "activityType", as.character(ft$featureName) )
    names(combinedDataSet) <- combinedDataSetColumnNames
    
    # get the column names and indices of "mean" and "standar deviation" measurement
    meanAndStdDeviationIndices <- c(1, 2, 3, grep("mean", combinedDataSetColumnNames), grep("std", combinedDataSetColumnNames) )
    meanAndStdDeviationNames <- combinedDataSetColumnNames[meanAndStdDeviationIndices]
    
    # get the filtered data set (filter by column) that has 
    # only mean and standard deviations of feature measurements
    meanAndStd <- combinedDataSet[,meanAndStdDeviationIndices]
    
    # change the activity type code to activity label (mapping is defined in activity_labels.txt file)
    meanAndStd$activityType <- al$activityType[match(meanAndStd$activityType,al$activityTypeCode)]
    
    # use group_by (group by subjectType, subject, activityType in that order) to create group by clause
    groupByClause <- meanAndStd %>% group_by(subjectType, subject, activityType)
    
    # use summarise_each function to find average value of mean and standard deviation 
    # measurement for each subject and activity type
    avgMeanAndStd <- groupByClause %>% summarise_each(funs(mean))
    write.table(avgMeanAndStd, file="Answer.txt", row.names=FALSE)
    avgMeanAndStd
}
```





 

