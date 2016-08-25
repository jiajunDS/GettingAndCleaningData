
toDebug <- TRUE
#toDebug <- FALSE

setwd ("C:/Users/admin/Desktop/gettingAndCleaningData/UCI HAR Dataset")
#1. Merges the training and the test sets to create one data set.
trainingData <- read.table("./train/X_train.txt")

if (toDebug == TRUE)
{
    dim(trainingData)
    head(trainingData)
}
trainingLabel <- read.table("./train/y_train.txt")
table(trainingLabel)
trainingSubject <- read.table("./train/subject_train.txt")
testingData <- read.table("./test/X_test.txt")
if (toDebug == TRUE)
{
    dim(testingData)
    testLabel <- read.table("./test/y_test.txt") 
}
testingLabel <- read.table("./test/y_test.txt") 
table(testingLabel) 

testingSubject <- read.table("./test/subject_test.txt")
joinData <- rbind(trainingData, testingData)
if (toDebug == TRUE)
{
    dim(joinData) # 10299 * 561
}
joinLabel <- rbind(trainingLabel, testingLabel)
if (toDebug == TRUE)
{
    dim(joinLabel)
}
joinSubject <- rbind(trainingSubject, testingSubject)
if (toDebug == TRUE)
{
    dim(joinSubject) # 10299 * 1
}
#2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 
featureData <- read.table("./features.txt")
if (toDebug == TRUE)
{
    dim(featureData)
}
meanData <- grep("mean\\(\\)|std\\(\\)", featureData[, 2])
if (toDebug == TRUE)
{
    length(meanData)
}
joinData <- joinData[, meanData]
if (toDebug == TRUE)
{
    dim(joinData)
}
names(joinData) <- gsub("\\(\\)", "", featureData[meanData, 2]) # remove "()"
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capitalize M
names(joinData) <- gsub("std", "Std", names(joinData)) # capitalize S
names(joinData) <- gsub("-", "", names(joinData)) # remove "-" in column names 

#3. Uses descriptive activity names to name the activities in the data set
activityData <- read.table("./activity_labels.txt")
activityData[, 2] <- tolower(gsub("_", "", activityData[, 2]))
substr(activityData[2, 2], 8, 8) <- toupper(substr(activityData[2, 2], 8, 8))
substr(activityData[3, 2], 8, 8) <- toupper(substr(activityData[3, 2], 8, 8))
activityLabel <- activityData[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
if (toDebug == TRUE)
{
    names(joinLabel) <- "activityData"
}
#4. Appropriately labels the data set with descriptive variable names. 
names(joinSubject) <- "subject"
cleanedDataset <- cbind(joinSubject, joinLabel, joinData)
if (toDebug == TRUE)
{
    dim(cleanedDataset)
}
write.table(cleanedDataset, "part4-combinedDataset.txt") # write out the 1st dataset

#5. From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activityData)[1] # 6
columnLen <- dim(cleanedDataset)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
if (toDebug == TRUE)
{
    colnames(result) <- colnames(cleanedDataset)
}
row <- 1
for(i in 1:subjectLen) 
{
    for(j in 1:activityLen) 
    {
        result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
        result[row, 2] <- activityData[j, 2]
        bool1 <- i == cleanedDataset$subject
        bool2 <- activityData[j, 2] == cleanedDataset$activityData
        result[row, 3:columnLen] <- colMeans(cleanedDataset[bool1&bool2, 3:columnLen])
        row <- row + 1
    }
}
if (toDebug == TRUE)
{
    head(result)
}
write.table(result, "part5-independentAverageActivitySubject.txt", row.names=FALSE) # write out the 2nd dataset
