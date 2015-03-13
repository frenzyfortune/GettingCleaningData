#Read the training files
train.features <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/X_train.txt"),quote="",sep="",stringsAsFactors=FALSE)
train.labels <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/y_train.txt"),sep="",stringsAsFactors=FALSE)
train.subject <- read.table(paste0(getwd(),"/UCI HAR Dataset/train/subject_train.txt"),sep="",stringsAsFactors=FALSE)

# Read the test files
test.features <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/X_test.txt"),quote="",sep="",stringsAsFactors=FALSE)
test.labels <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/y_test.txt"),sep="",stringsAsFactors=FALSE)
test.subject <- read.table(paste0(getwd(),"/UCI HAR Dataset/test/subject_test.txt"),sep="",stringsAsFactors=FALSE)

# Merge the labels, subject IDs and features for the training and test sets
data.labels <- factor(rbind(train.labels,test.labels)[,1])
levels(data.labels)<-c("walking","walkingUpstairs",
                       "walkingDownstairs","sitting","standing","laying")
data.subject <- factor(rbind(train.subject,test.subject)[,1])
data.features <- rbind(train.features,test.features)

# Read the features file and extract the mean and standard deviation features
features <- read.table(paste0(getwd(),"/UCI HAR Dataset/features.txt"))
selectedFeatures <- c(grep("mean()",features[,2]),grep("std()",features[,2]))
selectedData <- data.features[,selectedFeatures]
names(selectedData) <- features[selectedFeatures,2]
data<-cbind(data.subject,data.labels,selectedData)
names(data)[1:2] <- c("SubjectID","Activity")

# Create a new dataset with the means of the features for each subject and activity
interFac <- interaction(data.labels,data.subject)
newData <- summarise_each(group_by(cbind(interFac,data),interFac),funs(mean))
newData <- select(newData,-(interFac))
newData$Activity<-factor(newData$Activity)
levels(newData$Activity)<-c("walking","walkingUpstairs",
                            "walkingDownstairs","sitting","standing","laying")

# Write the final dataset to file
write.table(newData,paste0(getwd(),"/final_dataset.txt"),row.names=FALSE,quote=FALSE,sep=",")