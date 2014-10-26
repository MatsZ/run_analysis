README.md for run_analysis.R:

The script assumes the data directory "UCI HAR Dataset" with all the input data is in the working directory. The script reads in the data and merges the two sessions from training and testing; first the subjects, then the activities, and then the result files. The Inertial files are read but not really used, since their contents have been used to produce the results in the X-train/test.txt files.

Then the mean and the standard deviation tables are extracted from the result tables, and only these tables are used. The tables for the included features are found using a combination of two grep statements, and hereby forming a vector for the inclusion.

The Activities are mapped according to the file "activity_labels.txt" in the data set, setting the proper label in a single column table.

Then the subjects, the activities and the results for the 66 features can be merged together in one table. The column names are added to enable easier reading and handling of the data.

From this table a simplified data set holding only the average values for every subject, every activity and every feature can be built. First an empty data frame are created with the same format as the total data frame, then proper dimensions are set for the loops over the subjects and the included features. When this is done the starting row for each subject is calculated, and the activities can be filled out for the current subject. After that all features are looped over, where the average value is calculated and written in the proper place in the new table.

Finally the resulting tidy data set is written to the resulting "tidyData.txt" text file, excluding the row names as directed.



Code Book:

Row number, column 1

Subject, column 2: The actual performer of the activity, one out of 30 persons

Activity: One of the six activities that were included in the test: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

Then comes 66 different Features, calculated from the motion data recorded by the smartphone each subject carried while performing an activity. The Features start out with "tBodyAcc-mean()-X" and ends with "fBodyBodyGyroJerkMag-std()". All values in these columns are averages over the subject and the activity.

The following variables are included in the tidy data set:

"Subject" "Activity" "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" "tBodyAcc-std()-Y" "tBodyAcc-std()-Z" "tGravityAcc-mean()-X" "tGravityAcc-mean()-Y" "tGravityAcc-mean()-Z" "tGravityAcc-std()-X" "tGravityAcc-std()-Y" "tGravityAcc-std()-Z" "tBodyAccJerk-mean()-X" "tBodyAccJerk-mean()-Y" "tBodyAccJerk-mean()-Z" "tBodyAccJerk-std()-X" "tBodyAccJerk-std()-Y" "tBodyAccJerk-std()-Z" "tBodyGyro-mean()-X" "tBodyGyro-mean()-Y" "tBodyGyro-mean()-Z" "tBodyGyro-std()-X" "tBodyGyro-std()-Y" "tBodyGyro-std()-Z" "tBodyGyroJerk-mean()-X" "tBodyGyroJerk-mean()-Y" "tBodyGyroJerk-mean()-Z" "tBodyGyroJerk-std()-X" "tBodyGyroJerk-std()-Y" "tBodyGyroJerk-std()-Z" "tBodyAccMag-mean()" "tBodyAccMag-std()" "tGravityAccMag-mean()" "tGravityAccMag-std()" "tBodyAccJerkMag-mean()" "tBodyAccJerkMag-std()" "tBodyGyroMag-mean()" "tBodyGyroMag-std()" "tBodyGyroJerkMag-mean()" "tBodyGyroJerkMag-std()" "fBodyAcc-mean()-X" "fBodyAcc-mean()-Y" "fBodyAcc-mean()-Z" "fBodyAcc-std()-X" "fBodyAcc-std()-Y" "fBodyAcc-std()-Z" "fBodyAccJerk-mean()-X" "fBodyAccJerk-mean()-Y" "fBodyAccJerk-mean()-Z" "fBodyAccJerk-std()-X" "fBodyAccJerk-std()-Y" "fBodyAccJerk-std()-Z" "fBodyGyro-mean()-X" "fBodyGyro-mean()-Y" "fBodyGyro-mean()-Z" "fBodyGyro-std()-X" "fBodyGyro-std()-Y" "fBodyGyro-std()-Z" "fBodyAccMag-mean()" "fBodyAccMag-std()" "fBodyBodyAccJerkMag-mean()" "fBodyBodyAccJerkMag-std()" "fBodyBodyGyroMag-mean()" "fBodyBodyGyroMag-std()" "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"
