## Load Packages
library(data.table)
library(dplyr)

#Store Old Working Directory
old <- getwd()
setwd("UCI HAR Dataset/")
## Open and read necessary files
setwd("test/")
temp = list.files(pattern="*.txt")
testfiles = lapply(temp, read.table) #Reads in the files alphabetically
setwd("../train")
temp = list.files(pattern="*.txt")
trainfiles = lapply(temp, read.table)


## Merge the training and test sets
temp <- rbind(trainfiles[[1]],testfiles[[1]])
merged.data = temp
temp <- rbind(trainfiles[[3]],testfiles[[3]])
merged.data <- cbind(merged.data,temp)
names(merged.data) = c("subject","activityNames")
temp <- rbind(trainfiles[[2]],testfiles[[2]])
merged.data <- cbind(merged.data,temp)
setwd("..")

## Extract mean and std
features <- read.table("features.txt",stringsAsFactors = FALSE)
names(features) <- c("featureNum","featureName")
features <- features[grepl("(mean|std)\\(\\)", features$featureName),]
#Parse and rename the columns
merged.data <- select(merged.data,1,2,features$featureNum+2)

## Name the activities in the data set
activity <- read.table("activity_labels.txt")
names(activity) <- c("num","activity_Names")
# Merge the activity num columns of the dataset, then remove the leftover column
merged.data <- merge(activity,merged.data, by.x = "num", by.y  = "activityNames")
merged.data <- select(merged.data,-num)
names(merged.data) <- c("activityNames","subject",features$featureName)

## Create a separate tidy data set
sublen <- length(unique(merged.data$subject))
actlen <- nrow(activity)
tidy.data <- merged.data[1:(actlen*sublen),]
colength <- length(names(merged.data))
row <- 1

for (i in 1:sublen){
  for(j in 1:actlen){
    tidy.data[row,1] <- activity[j,2]
    tidy.data[row,2] <- i
    tmp <- filter(merged.data,subject == i, activityNames == activity[j,2])
    tidy.data[row,3:colength] <- colMeans(tmp[,3:colength])
    row <- row + 1
  }
}

setwd(old)

write.table(merged.data,"mergeddata.txt")
write.table(tidy.data,"tidydata.txt")





