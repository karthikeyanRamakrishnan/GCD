GCD
===

Gettting & Cleaning Data

#### Read all data sets individually using read.table function

test_x<-read.table("UCI HAR Dataset/test/x_test.txt")
test_y<-read.table("UCI HAR Dataset/test/y_test.txt")
test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
train_x<-read.table("UCI HAR Dataset/train/X_train.txt")
train_y<-read.table("UCI HAR Dataset/train/y_train.txt")
feature<-read.table("UCI HAR Dataset/features.txt")


####Merging of test & train data sets using rbind function

test_train_x<-rbind(test_x,train_x)
test_train_subject<-rbind(test_subject,train_subject)
test_train_y<-rbind(test_y,train_y)

####creating a data subset using grep function for the list of variable which are mean & standard deviation.

x<-grep("std|mean",feature$V2)

y<-test_train_x[,x]
f<-feature[x,]

####Naming of dataset
names(y)<-f[,2]

####Adding subject to our data set
z<-cbind(test_train_subject,test_train_y,y)
colnames(z)[1]<-"subject"

####adding activity to our data set

act<-read.table("UCI HAR Dataset/activity_labels.txt")
w<-merge(z,act,all=TRUE)
w$V1<-NULL
colnames(w)[81]<-"activity"

#### Renaming the column variables
lower<-tolower(names(w))
fine<-gsub("-","",lower)
newcolname<-gsub("\\(\\)","",fine)
names(w)<-newcolname

####creating a final tidy data set using melt function with ID variable as activity,subject. dcast fucntion to take mean of of each variable for each activity and each subject. 

library(reshape2)
meltw<-melt(w,id=c("activity","subject"))
v<-dcast(meltw,activity+subject ~ variable,mean)

####gettin tidy data set in text file

write.table(v,file="C:/Users/Sai/Documents/R/tidy.txt")
