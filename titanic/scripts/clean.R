train <- read.csv("..//data//train.csv",colClasses=c("integer","factor","factor","character","factor","numeric","integer","integer","character","numeric","character","factor"))
test <- read.csv("..//data//test.csv",colClasses=c("integer","factor","character","factor","numeric","integer","integer","character","numeric","character","factor"))	

test$Survived <- 2
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
#PassengerId Survived Pclass               Name  Sex  Age SibSp Parch Ticket Fare Cabin Embarked
#1044        0      3 Storey, Mr. Thomas male 60.5     0     0   3701   NA              S

temp$Faref <- temp$Fare
temp$Faref[1044] <- median(temp$Fare[!is.na(temp$Fare) & temp$Pclass==3 & temp$Sex=="male" & temp$Embarked=="S"])

# 2 missing values in train set for Passengers 62 and 830 - Embarked

table(temp$Embarked[temp$Sex=="female" & temp$Pclass==1])

# Most female passengers in first class were either from C or S. Records indicate Southampton

temp$Embarkedf <- temp$Embarked
temp$Embarkedf[c(62,830)] <- c("S","S")

#train <- temp[1:l1,]
#test <- temp[l3:l4,]

