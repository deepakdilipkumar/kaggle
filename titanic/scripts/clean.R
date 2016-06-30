library(rpart)

train <- read.csv("..//data//train.csv",colClasses=c("integer","factor","factor","character","factor","numeric","integer","integer","character","numeric","character","factor"))
test <- read.csv("..//data//test.csv",colClasses=c("integer","factor","character","factor","numeric","integer","integer","character","numeric","character","factor"))	

test$Survived <- 2  # Fill with invalid values so missing values can be treated together
l1 <- length(train$Survived)
l2 <- length(test$Survived)
temp <- rbind(train,test)
l3<-l1+1
l4<-l1+l2

summary(temp)

for (i in 1:12) {
  print(length(temp[temp[,i]=="" | is.na(temp[,i]),i]))   # Number of missing values in each column
}

# 1 missing value in test set for Passenger 1044 - Fare

temp$Fare[1044] <- median(train$Fare[!is.na(train$Fare) & train$Pclass==3 & train$Sex=="male" & train$Embarked=="S"])

# 2 missing values in train set for Passengers 62 and 830 - Embarked

table(train$Embarked[temp$Sex=="female" & temp$Pclass==1])

# Most female passengers in first class were either from C or S. Records indicate Southampton

temp$Embarked[c(62,830)] <- c("S","S")

# 263 missing values in Age

simpleTree <- rpart(formula = Age ~ Sex + Pclass + SibSp + Parch + Fare + Embarked, data=train)
agePrediction <- predict(simpleTree, newdata=temp[is.na(temp$Age),])

temp$Age[is.na(temp$Age)] <- agePrediction

# Changing categorical variables to numerical values for easy input to learning models

temp$Gender <- 0      # male
temp$Gender[temp$Sex=="female"] <- 1

temp$Location <- "0"  # Q
temp$Location[temp$Embarked=="C"] <- 1
temp$Location[temp$Embarked=="S"] <- 2

cleantrain <- temp[1:l1,]
cleantest <- temp[l3:l4,-2]   # Removing Survived column

write.csv(cleantrain,"..//data//cleantrain.csv",row.names = FALSE)
write.csv(cleantest,"..//data//cleantest.csv",row.names = FALSE)
