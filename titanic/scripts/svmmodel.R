library(e1071)
library(rpart)
library(ggplot2)

train <- read.csv("..//data//cleantrain.csv",colClasses=c("integer","factor","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))
test <- read.csv("..//data//cleantest.csv",colClasses=c("integer","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))	

cvparam = 10
n=dim(train)[1]
k=trunc(n/cvparam)

errormatrix = data.frame()
#names(errormatrix)=c("Gamma","Cost","Eval")

for (g in 1:1000){
  errorval =0
  for (i in 1:10) {
    lower <- k*(i-1)+1
    upper <- k*(i)
    cvtrain <- train[-(lower:upper),]
    cvvalidate <- train[lower:upper,]
    cvsvmmodel <- svm(Survived ~ Gender + Pclass + AgeCategory + Fare + FamilySize + Age + Parch + SibSp + Location , data=cvtrain, type="C-classification", kernel="radial",gamma=g/1000)
    cvprediction <- predict(cvsvmmodel,newdata=cvvalidate, type="class")
    wrongpredictions <- cvprediction!=cvvalidate$Survived
    errorval <- errorval + length(cvvalidate$Survived[wrongpredictions])/length(cvvalidate$Survived)
  }
  errorval <- errorval/cvparam
  errormatrix <- rbind(errormatrix,c(g/1000,errorval))
  print(g)
}

names(errormatrix)=c("Gamma","Eval")
ggplot(errormatrix,aes(x=Gamma,y=Eval))+geom_point()
g = errormatrix$Gamma[errormatrix$Eval==min(errormatrix$Eval)][1]

svmmodel <- svm(Survived ~ Gender + Pclass + AgeCategory + Fare + FamilySize + Age + Parch + SibSp + Location , data=train, type="C-classification", kernel="radial", gamma=g)
prediction <- predict(svmmodel,newdata=test, type="class")

solution <- data.frame(PassengerId=test$PassengerId, Survived=prediction)

write.csv(solution,"..//output//svmwithgammacrossvalidation.csv",row.names=FALSE)
