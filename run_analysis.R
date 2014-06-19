##wd = 'C:/Users/Prince/Documents/RWorkSpace/Getting_Cleaning_Data/data/UCI_HAR_Dataset/'

# Cleanup workspace
rm(list=ls())

logger <- function(...){
        cat("[run_analysis.R]::", ..., "\n");
}

run_analysis <- function(dir){
        
        logger("Getting and Cleaning Data Project");
        logger("Author: PRINCE ONYENIKE");
        logger("---");
        logger("Starting up.");
        logger("Initiating run_analysis. This may take few minutes...");
        
        ### STEP1: MERGES THE TRAINING & TEST SETS TO CREATE OBE DATA SET.####
        
        #set working directory to source data location 
        setwd(dir);
        
        
        # Import inputs from files
        features     = read.table('./features.txt',header=FALSE); 
        activityType = read.table('./activity_labels.txt',header=FALSE); 
        subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
        xTrain       = read.table('./train/x_train.txt',header=FALSE); 
        yTrain       = read.table('./train/y_train.txt',header=FALSE); 
        
        # Assigin column names to the data imported above
        colnames(activityType)  = c('activityId','activityType');
        colnames(subjectTrain)  = "subjectId";
        colnames(xTrain)        = features[,2]; 
        colnames(yTrain)        = "activityId";
        
        # Training data set merger( yTrain, subjectTrain, and xTrain)
        trainData = cbind(yTrain,subjectTrain,xTrain);
        logger("Train Data set merger successful!");
        logger("Train Data files import successful!");
        
        
        # Read in the test data
        subjectTest = read.table('./test/subject_test.txt',header=FALSE); #imports subject_test.txt
        xTest       = read.table('./test/x_test.txt',header=FALSE); #imports x_test.txt
        yTest       = read.table('./test/y_test.txt',header=FALSE); #imports y_test.txt
        
        # Assign column names to the test data imported above
        colnames(subjectTest) = "subjectId";
        colnames(xTest)       = features[,2]; 
        colnames(yTest)       = "activityId";
        
        
        # Test dataSet merger (xTest, yTest and subjectTest)
        testData = cbind(yTest,subjectTest,xTest);
        logger("Test Data set merger successful!");
        
        logger("Test Data files import successful!");
        
        
        # Merge TrainData and testData
        finalData = rbind(trainData,testData);
        
        # Create a vector for the column names from the finalData, which will be used
        # to select the desired mean() & stddev() columns
        colNames  = colnames(finalData); 
        
        logger("Final Test & Training Data merger successful!");
        
        # STEP2. Extract only the measurements on the mean and standard deviation
        #for each measurement. 
        
        # Create a logicalVector containing TRUE for desired columns and FALSE otherwise
        logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | 
                                 grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) 
                         & !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                                 !grepl("-std()..-",colNames));
        
        # Extract from finalData desired desired fields only
        #using logicalVector as criterion
        #Recreate finalData with result.
        finalData = finalData[logicalVector==TRUE];
        logger("finalData recreated with desired result!");
        
        # STEP3. Use descriptive activity names to name the activities in the data set
        
        # Merge the finalData set with the acitivityType table to include descriptive activity names
        finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);
        
        # Updating the colNames vector to include the new column names after merge
        colNames  = colnames(finalData); 
        
        # 4. Appropriately label the data set with descriptive activity names. 
        
        # Cleaning up the variable names
        for (i in 1:length(colNames)){
                colNames[i] = gsub("\\()","",colNames[i]);
                colNames[i] = gsub("-std$","StdDev",colNames[i]);
                colNames[i] = gsub("-mean","Mean",colNames[i]);
                colNames[i] = gsub("^(t)","time",colNames[i]);
                colNames[i] = gsub("^(f)","freq",colNames[i]);
                colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i]);
                colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i]);
                colNames[i] = gsub("[Gg]yro","Gyro",colNames[i]);
                colNames[i] = gsub("AccMag","AccMagnitude",colNames[i]);
                colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i]);
                colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i]);
                colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i]);
        }
        
        # Reassigning the new descriptive column names to the finalData set
        colnames(finalData) = colNames;
        logger("Dataset lebel with descriptive names successful!");
        
        # Reassigning the new descriptive column names to the finalData set
        colnames(finalData) = colNames;
        
        # 5. Create a second, independent tidy data set with the average of 
        #each variable for each activity and each subject. 
        
        # Create a new table, finalDataNoActivityType without the activityType column
        finalDataNoActivityType  = finalData[,names(finalData) != 'activityType'];
        
        # Summarizing the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
        tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId',
                                                                                             'subjectId')],
                                by=list(activityId=finalDataNoActivityType$activityId,
                                        subjectId = finalDataNoActivityType$subjectId),
                                mean);
        
        # Merging the tidyData with activityType to include descriptive acitvity names
        tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);
        logger("Create Tidy data successful!");
        
        # Export the tidyData set 
        write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t');
        logger("Tidy data exported as: tidyData.txt!");
        #logger("location:", dir);
        logger("end successful!");
}