library(ggplot2)
library(rpart)
#library(rattle)

train <- read.csv("..//data//train.csv")
test <- read.csv("..//data//test.csv")

basic_tree <- rpart(formula = Survived ~ Pclass + Sex + Age + SibSp + Parch + Fare + Embarked, data=train, method = "class")
prediction <- predict(basic_tree, newdata=test, type="class")

#pdf(file="..//output//decisiontree.pdf")
#fancyRpartPlot(basic_tree)
#dev.off()

solution <- data.frame(PassengerId = test$PassengerId , Survived = prediction)

write.csv(solution,"..//output//decisiontreemodel.csv",row.names=FALSE)
table(prediction)