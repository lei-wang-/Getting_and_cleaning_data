This is the CodeBook.md

"train" variable is the training data
"subjectTrain" lay out the subject number for each training measurement
"activityTrain" lay out the activity number for each training measurement
"test", "subjectTrain", "activityTrain" variables does the same thing for test data

rbind() function is used to merge the traning data set and test data set.
join() function in "plyr" library is used to select corresponding activity names for each measurement.

regular expression "*(mean|std)\\(\\)*" is used to select the features relevant to 
mean and std for each measurement.

data.table() is used to get the mean value of selected features for each activity and subject pair
