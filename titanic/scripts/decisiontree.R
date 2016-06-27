library(ggplot2)
library(rpart)

train <- read.csv("..//data//train.csv")
test <- read.csv("..//data//test.csv")

basic_tree <- rpart(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, model = "class")
prediction <- predict(basic_tree, data=test, model="class")

solution <- data.frame(PassengerId = test$PassengerId , Survived = prediction)

table(prediction)