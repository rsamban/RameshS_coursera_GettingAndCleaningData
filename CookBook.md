# CodeBook for tidy data set
## Data Source
	Please refer to [README.md](https://github.com/rsamban/RameshS_coursera_GettingAndCleaningData/blob/master/README.md)
## Tidy Data And explanation
### Output file name
	[Answers.txt](https://github.com/rsamban/RameshS_coursera_GettingAndCleaningData/blob/master/Answer.txt)
### Calcuated Feature set values
	The feature set is average of values for each subject and for each activity. Following are the column names and their explanation
	1. subjectType - Specifies whether the subject is test or training subject
	2. subject - subject number
	3. activityType - activity type that subject performed.
	4. next 78 columns - mean or standard deviation of signal measurements from accelerometer or gyroscope for each subject and activity. Following are the general observations on column names/values
		* If the column name contains "mean()", values specified is average mean value.
		* If the column name contains "std()", values specified is average standard deviation value.
		* If the column name begins with "t", it is time domain value.
		* If the column name begins with "f", it is time domain value.
		* If the column name contains "Acc", the value is calculated from Accelerometer signal
		* If the column name contains "Gyro", the value is calculated from Gyroscope signal
		* The last portion of the column name specifies if the measurement is along X, Y or X axis.
	5. e.g: The column name "tBodyAcc-mean()-Z" 
		t - this is time domain measurement
		Acc - signal value from Accelerometer is used.
		mean() - specifies that value is mean of signal values from Accelerometer for given subject and for given activity
		Z - specifies that value output from Z axis of Accelerometer.