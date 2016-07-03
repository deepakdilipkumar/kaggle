library(e1071)
library(rpart)

train <- read.csv("..//data//cleantrain.csv",colClasses=c("integer","factor","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))
test <- read.csv("..//data//cleantest.csv",colClasses=c("integer","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))	

svmmodel <- svm(Survived ~ Gender + Pclass + Age + Location + Fare + FamilySize, data=train)
prediction <- predict(svmmodel,newdata=test, type="class")

solution <- data.frame(PassengerId=test$PassengerId, Survived=prediction)

write.csv(solution,"..//output//svmwithfamilysize.csv",row.names=FALSE)