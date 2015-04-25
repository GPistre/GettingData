library(dplyr)

#Setting working directory, change if necessary
setwd("~/GitHub/GettingData")


activityCodes <- read.table("activity_labels.txt")[[2]]
#Required features
features <- read.table("features.txt")
reqMeasurementsCodes <- features[grepl("mean", features$V2) | grepl("Mean", features$V2) | grepl("std", features$V2),]

#Loading training set
trainX <- read.table("./train/X_train.txt")
trainActivity <- read.table("./train/y_train.txt")
trainSubjects <- read.table("./train/subject_train.txt")

#Loading test set
testX <- read.table("./test/X_test.txt")
testActivity <- read.table("./test/y_test.txt")
testSubjects <- read.table("./test/subject_test.txt")

#Extracting required measurements
#For training set
reqMeasurementsTrain <- trainX[, reqMeasurementsCodes$V1]
trainDF <- cbind(trainSubjects, rep(1, nrow(trainSubjects)), trainActivity, reqMeasurementsTrain)
names(trainDF) <- c("subjectID", "group", "activity", as.character(reqMeasurementsCodes$V2))


#For test set
reqMeasurementsTest <- testX[, reqMeasurementsCodes$V1]
testDF <- cbind(testSubjects, rep(2, nrow(testSubjects)), testActivity, reqMeasurementsTest)
names(testDF) <- c("subjectID", "group", "activity", as.character(reqMeasurementsCodes$V2))

#Merging sets
df <- rbind(trainDF, testDF)

#Calculating means by subject / activity
final <- ddply(df, c("subjectID", "activity"), colMeans)

#replace labels with activity & group names
final$activity <- factor(x = final$activity, labels = tolower(activityCodes))
final$group <- factor(x = final$group, labels = c("training", "testing"))

#remove special characters in variable names
names(final) <- sapply(names(final), function(x){ gsub(pattern = "\\-|\\(|\\)|\\,", x = x, replacement = "") })

#saving file
write.table(final, file = "tidyAccel.txt", row.names = F)