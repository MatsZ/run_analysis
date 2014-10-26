#-------------------------------------------------------------------------------
# run_analysis.R
#
# Import the data files, provided the data directory is in the working directory.
# Calculate averages and store in separate file.
# For more information please see README.md.
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#
#   Read in all data in data set:
#

    # Set all (-1) or fewer rows for testing:
readRows <- -1

    # subject_xxx.txt:
subject_total <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt", nrows = readRows), 
                       read.table("UCI HAR Dataset/test/subject_test.txt", nrows = readRows))
    # y_xxx.txt:
y_total <- rbind(read.table("UCI HAR Dataset/train/y_train.txt", nrows = readRows), 
                 read.table("UCI HAR Dataset/test/y_test.txt", nrows = readRows))
    # X_xxx.txt:
X_total <- rbind(read.table("UCI HAR Dataset/train/X_train.txt", nrows = readRows), 
                 read.table("UCI HAR Dataset/test/X_test.txt", nrows = readRows))

    # Inertial Signals/body_acc_x_xxx.txt:
body_acc_x_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", nrows = readRows), 
                          read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", nrows = readRows))
    # Inertial Signals/body_acc_y_xxx.txt:
body_acc_y_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", nrows = readRows), 
                          read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", nrows = readRows))
    # Inertial Signals/body_acc_z_xxx.txt:
body_acc_z_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", nrows = readRows), 
                          read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", nrows = readRows))

    # Inertial Signals/body_gyro_x_xxx.txt:
body_gyro_x_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", nrows = readRows), 
                           read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", nrows = readRows))
    # Inertial Signals/body_gyro_y_xxx.txt:
body_gyro_y_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", nrows = readRows), 
                           read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", nrows = readRows))
    # Inertial Signals/body_gyro_z_xxx.txt:
body_gyro_z_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", nrows = readRows), 
                           read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", nrows = readRows))

    # Inertial Signals/total_acc_x_xxx.txt:
total_acc_x_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", nrows = readRows), 
                           read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", nrows = readRows))
    # Inertial Signals/total_acc_y_xxx.txt:
total_acc_y_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", nrows = readRows), 
                           read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", nrows = readRows))
    # Inertial Signals/total_acc_z_xxx.txt:
total_acc_z_total <- rbind(read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", nrows = readRows), 
                           read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", nrows = readRows))

#-------------------------------------------------------------------------------
#
#   Extract only the mean and standard deviation values:
#
#       The mean and standard deviation features in the measurement data set are
#       found in the following columns:
#           1 - 6, 41 - 46, 81 - 86, 121 - 126, 161 - 166, 201 - 202, 214 - 215, 
#           227 - 228, 240 - 241, 253 - 254, 266 - 271, 345 - 350, 424 - 429,
#           503 - 504, 516 - 517, 529 - 530, 542 - 543
#

    # Import the feature labels:
features <- read.table("UCI HAR Dataset/features.txt")

    # Find the Mean and Std features:
includedFeatures <- sort(c(grep("mean\\(", features[,2]), grep("std\\(", features[,2])))

    # Use this vector to get the proper columns in the measurements:
meanAndStd <- X_total[, includedFeatures]

#-------------------------------------------------------------------------------
#
#   Use proper activity labels:
#
#       1 WALKING
#       2 WALKING_UPSTAIRS
#       3 WALKING_DOWNSTAIRS
#       4 SITTING
#       5 STANDING
#       6 LAYING

activity <- y_total
activity[activity == 1] <- "WALKING"
activity[activity == 2] <- "WALKING_UPSTAIRS"
activity[activity == 3] <- "WALKING_DOWNSTAIRS"
activity[activity == 4] <- "SITTING"
activity[activity == 5] <- "STANDING"
activity[activity == 6] <- "LAYING"

#-------------------------------------------------------------------------------
#
#   Merge all measurement data with subject, activities and feature values in
#   one table - the inertial signals are excluded since these can be seen as
#   background data used to create the feature values:
#

totalData <- cbind(subject_total, activity, meanAndStd)
header <- c("Subject", "Activity", as.character(t(features[includedFeatures,2])))
colnames(totalData) <- header

#-------------------------------------------------------------------------------
#
#   Build a new data set with the average of each variable for each activity 
#   and each subject.
#

    # Create new empty data frame:
averageData <- totalData[0,]

    # Set up the dimensions for the loops:
subjects <- dim(unique(subject_total))[1]
features <- length(includedFeatures)

    # Loop over all subjects and all features:
for (subject in 1:subjects) {
        # Calculate start row - six activities per subject:
    startRow <- (subject - 1) * 6 + 1
        # Fill out subject and activities:
    averageData[startRow:(startRow + 5), 1] <- subject
    averageData[startRow, 2] <- "WALKING"
    averageData[startRow + 1, 2] <- "WALKING_UPSTAIRS"
    averageData[startRow + 2, 2] <- "WALKING_DOWNSTAIRS"
    averageData[startRow + 3, 2] <- "SITTING"
    averageData[startRow + 4, 2] <- "STANDING"
    averageData[startRow + 5, 2] <- "LAYING"
        # Loop over features, calculate mean value and fill out proper column and row:
    for (feature in 1:features) {
        averageData[startRow, feature + 2] <- mean(as.numeric(totalData[(totalData$Subject == subject) & 
                                                            (totalData$Activity == "WALKING"), feature + 2]))
        averageData[startRow + 1, feature + 2] <- mean(as.numeric(totalData[(totalData$Subject == subject) & 
                                                            (totalData$Activity == "WALKING_UPSTAIRS"), feature + 2]))
        averageData[startRow + 2, feature + 2] <- mean(as.numeric(totalData[(totalData$Subject == subject) & 
                                                            (totalData$Activity == "WALKING_DOWNSTAIRS"), feature + 2]))
        averageData[startRow + 3, feature + 2] <- mean(as.numeric(totalData[(totalData$Subject == subject) & 
                                                            (totalData$Activity == "SITTING"), feature + 2]))
        averageData[startRow + 4, feature + 2] <- mean(as.numeric(totalData[(totalData$Subject == subject) & 
                                                            (totalData$Activity == "STANDING"), feature + 2]))
        averageData[startRow + 5, feature + 2] <- mean(as.numeric(totalData[(totalData$Subject == subject) & 
                                                            (totalData$Activity == "LAYING"), feature + 2]))
    }
}

    # Store the tidy data set in the file tidyData.txt:
write.table(averageData, "tidyData.txt", row.names=FALSE)






# EOF