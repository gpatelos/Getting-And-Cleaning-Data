# R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


library("dplyr")
library("data.table")
library("reshape2")


# 1. load the data test data set
xtest<-read.table("test/X_test.txt", header = FALSE)
ytest<-read.table("test/y_test.txt", header = FALSE)
subjtest<-read.table("test/subject_test.txt", header = FALSE)

#load the training data set
xtrain<-read.table("train/X_train.txt", header = FALSE)
ytrain<-read.table("train/y_train.txt", header = FALSE)
subjtrain<-read.table("train/subject_train.txt", header = FALSE)

#import the feature titles and activity labels which describe the data
featureNames <- read.table("features.txt", header = FALSE)
activityLabels <- read.table("activity_labels.txt", header = FALSE, stringsAsFactors = FALSE)

#merge the tables
subject <-rbind(subjtest, subjtrain)
activity <- rbind(ytest, ytrain)
features <- rbind(xtest, xtrain)

#name the columns
colnames(features) <- t(featureNames[2])
colnames(activity) <- "ActivityID"
colnames(subject) <- "Subject"

#put it all together
data <- cbind(subject, activity, features)


# 2. remove unneccessary feature columns by filtering for Mean and Standard Deviation lables
columnselect <- grep(".Mean.*|.*Std.", names(data), ignore.case = TRUE)
columndesired <- c(1,2,columnselect)

trimData <- data[,columndesired]

# 3. Use descriptive activity names to name the activities in the data set
colnames(activityLabels) <- c("ActivityID","Activity")
trimData2 <- join(trimData, activityLabels,by="ActivityID")

# 4. Cleaning up the names a bit. Note I kept some abbreviated as follows
# Accel = Accleromter
# Gyro = Gyroscope
# Magn = Magnitude
# Freq = Frequency
# std = Standard Deviation

names(trimData2)<-gsub("^t", "Time", names(trimData2))
names(trimData2)<-gsub("^f", "Freq", names(trimData2))
names(trimData2)<-gsub("Acc", "Accel", names(trimData2))
names(trimData2)<-gsub("Gyro", "Gyro", names(trimData2))
names(trimData2)<-gsub("Mag", "Magn", names(trimData2))
names(trimData2)<-gsub("BodyBody", "Body", names(trimData2))

# 5. creates a second, independent tidy data set with the average of each variable for each activity and each subject.

trimData2$Activity <- as.factor(trimData2$Activity)
trimData2$Subject <- as.factor(trimData2$Subject)

colnames(trimData2)[89] <- "Activity"

tidy = aggregate(trimData2, by=list(Activity = trimData2$Activity, Subject=trimData2$Subject), mean)

tidy<-tidy[order(tidy$Subject,tidy$Activity),]
write.table(tidy, file = "tidydata.txt",row.name=FALSE)

