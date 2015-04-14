library(data.table)
library(plyr)

activityCodes <- read.table("~/Documents/R/UCI HAR Dataset/activity_labels.txt")
#Required features
features <- read.table("~/Documents/R/UCI HAR Dataset/features.txt")
reqMeasurementsCodes <- features[grepl("mean", features$V2) | grepl("Mean", features$V2) | grepl("std", features$V2),]

#Loading training set
trainX <- read.table("~/Documents/R/UCI HAR Dataset/train/X_train.txt")
trainActivity <- read.table("~/Documents/R/UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("~/Documents/R/UCI HAR Dataset/train/subject_train.txt")

#Loading test set
testX <- read.table("~/Documents/R/UCI HAR Dataset/test/X_test.txt")
testActivity <- read.table("~/Documents/R/UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("~/Documents/R/UCI HAR Dataset/test/subject_test.txt")

#Extracting required measurements
#For training set
reqMeasurementsTrain <- trainX[, reqMeasurementsCodes$V1]
trainDF <- cbind(trainSubjects, rep(1, nrow(trainSubjects)), trainActivity, reqMeasurementsTrain)
names(trainDF) <- c("SubjectID", "Group", "Activity", as.character(reqMeasurementsCodes$V2))


#For test set
reqMeasurementsTest <- testX[, reqMeasurementsCodes$V1]
testDF <- cbind(testSubjects, rep(2, nrow(testSubjects)), testActivity, reqMeasurementsTest)
names(testDF) <- c("SubjectID", "Group", "Activity", as.character(reqMeasurementsCodes$V2))
df <- rbind(trainDF, testDF)

final <- ddply(df, c("SubjectID", "Activity"), colMeans)

#replace labels with activity & group names
for (i in 1:nrow(final))
{
  actVector[i] <- as.character(activityCodes[actVector[i],2])
  
  if (groupVector[i] == 1)
  {
    groupVector[i] <- "Training"
  }
  else
  {
    groupVector[i] <- "Test"
  }
}
final$Activity <- actVector
final$Group <- groupVector
write.table(final, file = "tidyAccel.txt", row.names = F)
str(final)