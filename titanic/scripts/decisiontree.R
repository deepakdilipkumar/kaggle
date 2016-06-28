library(ggplot2)
library(rpart)

train <- read.csv("..//data//train.csv")
test <- read.csv("..//data//test.csv")

basic_tree <- rpart(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method = "class")
prediction <- predict(basic_tree, test, type="class")

solution <- data.frame(PassengerId = test$PassengerId , Survived = prediction)

write.csv(solution,"..//data//decisiontreemodel.csv",row.names=FALSE)
table(prediction)