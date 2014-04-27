# train data is the training data
# subjectTrain lay out the subject number for each measurement
# activityTrain lay out the activity number for each measurement
# test, subjectTrain, activityTrain data does the same thing
# my working directory is "./data/....."
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
activityTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
activityTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")


#merge the training data and test data
library("plyr")
activity <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
mergedData <- rbind(train, test)
mergedSubject <- rbind(subjectTrain, subjectTest)
mergedActivity <- rbind(activityTrain, activityTest)
mergedActivityName <- join(mergedActivity, activity, by="V1")


#select only the feature about the mean and standard deviation for each measurement
#and append two columns "subject" and "activity".
feature <- read.table("./data/UCI HAR Dataset/features.txt")
featureSelect <- grep("*(mean|std)\\(\\)*" , as.character(feature[ , 2]))
featureName <- as.character(feature[ featureSelect, 2])
merged <- mergedData[ , featureSelect]
data01 <- cbind(mergedSubject, mergedActivityName[,2], merged)
names(data01) <- c("subject", "activity", featureName)


#convert data.frame to data.table to use special utility to 
#get the mean value of features for each activity and subject pair
library("data.table")
data02 <- data.table(data01)
keys <- setdiff(names(data02), c("subject","activity"))
tidydata <- data02[, lapply(.SD, mean), by=c("subject","activity"), .SDcols=keys]
