library(e1071)
library(rpart)
library(ggplot2)

train <- read.csv("..//data//cleantrain.csv",colClasses=c("integer","factor","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))
test <- read.csv("..//data//cleantest.csv",colClasses=c("integer","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))	

cvparam = 10
n=dim(train)[1]
k=trunc(n/cvparam)

grange=100
crange=10
errormatrix = data.frame()
#names(errormatrix)=c("Gamma","Cost","Eval")

for (g in 1:grange){
  for (c in 1:crange){
    errorval =0
    for (i in 1:10) {
      lower <- k*(i-1)+1
      upper <- k*(i)
      cvtrain <- train[-(lower:upper),]
      cvvalidate <- train[lower:upper,]
      cvsvmmodel <- svm(Survived ~ Gender + Pclass + AgeCategory + Fare + FamilySize + Age + Parch + SibSp + Location , data=cvtrain, type="C-classification", kernel="radial",gamma=g/grange,cost=2*c/crange)
      cvprediction <- predict(cvsvmmodel,newdata=cvvalidate, type="class")
      wrongpredictions <- cvprediction!=cvvalidate$Survived
      errorval <- errorval + length(cvvalidate$Survived[wrongpredictions])/length(cvvalidate$Survived)
    }
    errorval <- errorval/cvparam
    errormatrix <- rbind(errormatrix,c(g/grange,2*c/crange,errorval))
    print(g)
  }
}

names(errormatrix)=c("Gamma","Cost","Eval")
ggplot(errormatrix,aes(x=Gamma,y=Eval))+geom_point()
ggplot(errormatrix,aes(x=Gamma,y=Cost))+geom_point()
g = errormatrix$Gamma[errormatrix$Eval==min(errormatrix$Eval)][1]
c = errormatrix$Cost[errormatrix$Eval==min(errormatrix$Eval)][1]

svmmodel <- svm(Survived ~ Gender + Pclass + AgeCategory + Fare + FamilySize + Age + Parch + SibSp + Location , data=train, type="C-classification", kernel="radial", gamma=g, cost=c)
prediction <- predict(svmmodel,newdata=test, type="class")

solution <- data.frame(PassengerId=test$PassengerId, Survived=prediction)

write.csv(solution,"..//output//svmwithgammecrossvalidation2.csv",row.names=FALSE)
