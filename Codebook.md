##Source data


The data was collected from a Samsung Galaxy II phone worn on the waist of 30 volunteers.  Volunteers were asked to 

- Walk
- Walk upstairs
- Walk downstairs
- Sitting
- Standing
- Laying

Feature data was collected from the 30 subject using the devices accelerometer and gyroscope. 

For details on the specific methods of feature collection refer to the README.txt included in the data download (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

## Objectives and manipulation

To create a script called run_analysis.R that does the following.
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data was merged from the following files

- README.txt, refer here for data collection details
- features_info.txt, an explanation of the of the features observed.
- features.txt, a list of the features
- activity_labels.txt, a cross-reference for the activities as recorded in the data readings

- train/X_train.txt, each row represents a collection of observed features for a given subject and activity
- train/y_train.txt, the list of activities observed
- train/subject_train.txt, the list of volunteers

- test/X_test.txt, same as above, each row represents a collection of observed features for a given subject and activity
- test/y_test.txt, same as above, the list of activities observed
- test/subject_test.txt, same as above, the list of volunteers

These files provide additional detail that was not relevant to the objectives laid out above
- train/Intertial Signals/...
- test/Intertial Signals/...


Understanding that common number of rows between X_train, y_train and subject_train and the likewise among the "test" counterparts one large dataframe was created. Appending the test data to the train data.
The data was then filtered to include only those observations that pertained to mean and standard deviation calculations. To further that cleanliness of the data the feature names were modified slightly as follows:

- Accel = Accleromter
- Gyro = Gyroscope
- Magn = Magnitude
- Freq = Frequency
- std = Standard Deviation

Once the activity and subject were integrated into the data frame (joining by the "activity_labels" cross-reference) we were able represent the data in the so-called tidy set, allowing further exploration of features by subject and activity.


