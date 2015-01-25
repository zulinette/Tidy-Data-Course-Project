#Data Source
The dataset use in this project "Human Activity Recognition Using Smartphones Data Set" was taken from the UCI Machine Learning Repository. The dataset link is http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .

#Variables
- activityData: activity ID and name (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
- featuresData: includes all the taken features measurement.
- xTrainData and yTrainData: Training set and activity ID
- xTestData and yTestData: Test set and activity ID
- subjectTrainData and: subject train and test ID

- trainDF and testDF: contains the merge train and test data by column binding. 
- mergeTrainTestData: contains the merge of trainDF andtestDF by row binding. 
- columns: a vector that contains the columns names for measurements on the mean and standard deviation for each measurement. 
- finalDF: data frame that contains the measurements on the mean and standard deviation for each measurement and the columns for "Subject_ID", "Activity_ID". 
- tidyData: independent data frame with the average of each variable for each activity and each subject.

#Data
- featuresData$V2: was use to name features columns in xTrainData and yTrainData.
- finalDF$Activity_Name: column created to give a descriptive name to each observation.
- Abbreviated features names were expanded to provide descriptive variable names to the data set.
