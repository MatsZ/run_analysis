README.md for run_analysis.R:

The script assumes the data directory "UCI HAR Dataset" with all the input data is in the working directory. The script reads in the data and merges the two sessions from training and testing; first the subjects, then the activities, and then the result files. The Inertial files are read but not really used, since their contents have been used to produce the results in the X-train/test.txt files.

Then the mean and the standard deviation tables are extracted from the result tables, and only these tables are used. The tables for the included features are found using a combination of two grep statements, and hereby forming a vector for the inclusion.

The Activities are mapped according to the file "activity_labels.txt" in the data set, setting the proper label in a single column table.

Then the subjects, the activities and the results for the 66 features can be merged together in one table. The column names are added to enable easier reading and handling of the data.

From this table a simplified data set holding only the average values for every subject, every activity and every feature can be built. First an empty data frame are created with the same format as the total data frame, then proper dimensions are set for the loops over the subjects and the included features. When this is done the starting row for each subject is calculated, and the activities can be filled out for the current subject. After that all features are looped over, where the average value is calculated and written in the proper place in the new table.

Finally the resulting tidy data set is written to the resulting "tidyData.txt" text file, excluding the row names as directed.



