runAnalysis <- function() {
    # load features names
    ft <- read.csv("features.txt", sep="", header=FALSE)
    # rename the columns
    names(ft) <- c("seqNo", "featureName")
    
    # load activity labels
    al <- read.csv("activity_labels.txt", sep="", header=FALSE)
    # rename columns
    names(al) <- c("activityTypeCode", "activityType")
    
    # Load measured feature values for "test" subjects 
    x_tst <- read.csv("./test/X_test.txt", sep="", header=FALSE)
    y_tst <- read.csv("./test/y_test.txt", sep="", header=FALSE)
    s_tst <- read.csv("./test/subject_test.txt", sep="", header=FALSE)
    
    # Load measured features values for "train" subjects
    x_trn <- read.csv("./train/X_train.txt", sep="", header=FALSE)
    y_trn <- read.csv("./train/y_train.txt", sep="", header=FALSE)
    s_trn <- read.csv("./train/subject_train.txt", sep="", header=FALSE)
    
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
