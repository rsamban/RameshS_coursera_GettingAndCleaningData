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





 

