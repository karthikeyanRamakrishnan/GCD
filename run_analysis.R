test_x<-read.table("UCI HAR Dataset/test/x_test.txt")
test_y<-read.table("UCI HAR Dataset/test/y_test.txt")
test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
train_x<-read.table("UCI HAR Dataset/train/X_train.txt")
train_y<-read.table("UCI HAR Dataset/train/y_train.txt")
feature<-read.table("UCI HAR Dataset/features.txt")
x<-grep("std|mean",feature$V2)
act<-read.table("UCI HAR Dataset/activity_labels.txt")
test_train_x<-rbind(test_x,train_x)
test_train_subject<-rbind(test_subject,train_subject)
test_train_y<-rbind(test_y,train_y)
y<-test_train_x[,x]
f<-feature[x,]
names(y)<-f[,2]
z<-cbind(test_train_subject,test_train_y,y)
colnames(z)[1]<-"subject"
w<-merge(z,act,all=TRUE)
w$V1<-NULL
colnames(w)[81]<-"activity"
lower<-tolower(names(w))
fine<-gsub("-","",lower)
newcolname<-gsub("\\(\\)","",fine)
names(w)<-newcolname
library(reshape2)
meltw<-melt(w,id=c("activity","subject"))
v<-dcast(meltw,activity+subject ~ variable,mean)
write.table(v,file="C:/Users/Sai/Documents/R/tidy.txt")

