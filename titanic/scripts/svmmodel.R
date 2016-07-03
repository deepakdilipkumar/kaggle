library(svm)
library(rpart)

train <- read.csv("..//data//cleantrain.csv",colClasses=c("integer","factor","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))
test <- read.csv("..//data//cleantest.csv",colClasses=c("integer","factor","character","factor","numeric","integer","integer","character","numeric","character","factor","factor","factor","factor","integer"))	

