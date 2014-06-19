Author: Prince Onyenike

Acknowledgement:
--------------------------------------------------------------
Many thanks to fellow students in the Discussion Forum.
Though they're too numerous to mention, their help was great.
Without you guys getting here would have been a nightmare.

William Bowers thank you.
--------------------------------------------------------------

Johns Hopkins Getting and Cleaning Data course project on Coursera.

Introduction:
The purpose of this project is to demonstrate how to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis.
For source data and its exhaustive description see links provided in CODEBOOK.md


Function Names:
1) logger() : This is just a utility function. Its purpose is to update the user on the success of 
the various execution stages in the main function - "run_analysis()"

2) run_analysis(): This function achives the below outlined project steps
 
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set 4. Appropriately labels the data set with descriptive activity names. 
  5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

See comments in run_Analysis.R; where each script segment realising an outline above is given a corresponding header comment as tittle.
For a description of the variables see CODEBOOK.md 
