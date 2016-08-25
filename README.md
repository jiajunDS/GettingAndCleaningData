# gettingAndCleaningData


Getting and Cleaning Data Project Assignment Aug 2016

Data used for project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Objective of project is to create one R script called run_analysis.R that does following: 

1. Merges training and test sets to create one data set.
2. Extracts only measurements on mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name activities in data set
4. Appropriately labels data set with descriptive variable names. 
5. From data set in step 4, creates a second, independent tidy data set with average of each variable for each activity and each subject.

##########################################################################################################################################################

Included R script (run_analysis.R) performs following:
  1. Merge training and test sets to create one data set. 
Both X_train.txt and X_test.txt training datasets are merged, achieving resulting data frame of 10299 x 561 ("Number of Instances: 10299" and "Number of Attributes: 561").
Merged subject_train.txt and subject_test.txt, archiving resulting data frame of 10299 x 1 with subject IDs, and y_train.txt with y_test.txt, achieving resulting data frame of 10299 x 1 with activity IDs.

  2. Extracts only measurements on mean and standard deviation for each measurement.
Extracting measurements on mean and standard deviation from features.txt, resulting in data frame of 10299 x 66 since 66 out of 561 attributes are measurements on mean and standard deviation. Note that resulting measurements are floating numbers ranging between (-1, 1).

  3. Uses descriptive activity names to name activities in data set
Reading from activity_labels.txt and applying descriptive activity names to activities within data set consisting of following:
    1. walking
    2. walkingupstairs
    3. walkingdownstairs
    4. sitting
    5. standing
    6. laying

  4. Appropriately labels data set with descriptive variable names. 
Attributes and activity names are uniformly converted to a common denorminator: all lower cased letters, with underscoring and parenthesis removed. Merging of data frame containing features and activity labels and subject IDs, and storing output in as part4-combinedDataset.txt. Subject IDs and activity names make up first 2 columns, and remaining 66 columns refer to measurement readings. Note that Subject IDs are integers in range bewteen 1 to 30. Attribute names are:
    1. tbodyacc-mean-x
    2. tbodyacc-mean-y
    3. tbodyacc-mean-z
    4. tbodyacc-std-x
    5. tbodyacc-std-y
    6. tbodyacc-std-z
    7. tgravityacc-mean-x
    8. tgravityacc-mean-y

  5. From data set in step 4, creates a second, independent tidy data set with average of each variable for each activity and each subject.
A second independent tidy data set with average of each measurement for each activity and each subject is created, with a data frame of 180 x 68 stored as `part5-independentAverageActivitySubject.txt`
