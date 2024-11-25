
run_analysis <- function() {

     if (!("reshape2" %in% rownames(installed.packages())) ) {
        stop ("Please install required package: reshape2!\n")
     } 

     library(reshape2)

     traindata <- read.table("./train/X_train.txt")
     testdata  <- read.table("./test/X_test.txt")
     joindata  <- rbind(traindata, testdata) 

     dim(traindata) ##  (7352, 561)
     dim(testdata)  ##  (2947, 561)
     dim(joindata)  ## (10299, 561)

     trainlabel <- read.table("./train/y_train.txt")
     testlabel  <- read.table("./test/y_test.txt")
     joinlabel  <- rbind(trainlabel, testlabel)

     dim(trainlabel) ## (7352, 1)
     dim(testlabel)  ## (2947, 1)
     dim(joinlabel)  ##(10299, 1)

     trainsubject <- read.table("./train/subject_train.txt")
     testsubject  <- read.table("./test/subject_test.txt")
     joinsubject  <- rbind(trainsubject, testsubject)

     dim(trainsubject) ##  (7352, 1)
     dim(testsubject)  ##  (2947, 1)
     dim(joinsubject)  ## (10299, 1)


     features <- read.table("features.txt") ##read/load the file
     dim(features) ## (561, 2)

     meanstdindex <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

     length(meanstdindex) ## 66 variables
     joindatanew <- joindata[, meanstdindex] 

     dim(joindatanew)  ##(10299,66)

     colnames(joindatanew) <- features[meanstdindex, 2] 
     colnames(joindatanew) <- gsub("\\(|\\)", "", colnames(joindatanew)) 
     colnames(joindatanew) <- gsub("-", ".", colnames(joindatanew))
     colnames(joindatanew) <- tolower(colnames(joindatanew))
    activity <- read.table("activity_labels.txt")

     activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
     activitylabel <- activity[joinlabel[, 1], 2]
     joinlabel[, 1] <- activitylabel 
    colnames(joinlabel) <- "activity"

    colnames(joinsubject) <- "subject"

     cleandata <- cbind(joinsubject, joinlabel, joindatanew)
    dim(cleandata) ## (10299    68)
