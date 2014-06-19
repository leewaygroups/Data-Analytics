Author: Prince Onyenike

#Getting and Cleaning Data Project:


#Description:
Information describing the variables, the data and transformations/work performed to clean up the data
 
#Source Data:
Find full data description for this project at:(http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Find source data at: (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 
we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly 
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal,
which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body 
acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter 
with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from
the time and frequency domain.

#Attribute Information:
For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.


###############Section 1. Merge the training and the test sets to create one data set.#############
Firstly clear workspace of any pre-existing objects
Reason: To release held memory resources

Set working directory to location where the source files were unziped to

##Variables description:
import 'features.txt' into var features
import 'activity_labels.txt' into var activityType
import 'subject_train.txt' into var subjectTrain
import 'x_train.txt' into var xTrain 
import 'y_train.txt' into var yTrain 
import 'subject_test.txt' into var subjectTest 
imports x_test.txt  into var xTest
imports y_test.txt into var yTest

Assign column names and merge only Train data set into TrainData.
Assign column names and merge only Test data set into TestData.
Merge TrainData and TestData into one set 



#######Section 2. Extract only the measurements on the mean and standard deviation for each measurement#######.
Create a logcal vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others.
Subset this data to keep only the necessary columns.

## Section 3. Use descriptive activity names to name the activities in the data set
Merge data subset with the activityType table to inlude the descriptive activity names

## Section 4. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
Creates a data set - "TidyData" with the average(mean) of each veriable for each combination of activity and subject
Merging the tidyData with activityType to include descriptive acitvity names