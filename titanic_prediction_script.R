# This script is used to make an entry on the kaggle Titanic dataset
#packages: caret, randomForest
# I also prefer the tidyverse set of packages for any data wrangling I need
#to see EDA for the Titanic dataset look at the titanic_EDA upload

library(caret)
library(randomForest)
library(tidyverse)

train<- read.csv("/Titanic_Kaggle_GitHub/train.csv")
test<- read.csv("/Titanic_Kaggle_GitHub/test.csv")

#this code uses the following variabels and a random forest algorithm to predict a passengers survival 

# sets Survived as a factor
train$Survived<- factor(train$Survived)
#sets a seed for reproducibility
set.seed(66)

#This creates a model object using the randomForest algorithim
model<- train(Survived ~ Pclass + Sex + SibSp + Embarked +Parch + Fare,
              data= train,
              method= "rf",
              trControl= trainControl(method="cv",
                                      number=5)
              )
model

#Prediction time!

test$Survived<- predict(model, newdata=test)
# this throws an error as one of the variables in "test" has an NA, which can be remedied with:
#Lookign at the EDA analysis we see Fare has an NA and remedy it below. NOTE: Setting a column mean for NA value is generally not best practice
test$Fare[is.na(test$Fare)]<- mean(test$Fare, na.rm=TRUE)

#Repeat above
test$Survived<- predict(model, newdata=test)
head(test)

submission<- test%>%select("PassengerId", "Survived")
write.table(submission, file="submission.csv",col.names=TRUE,row.names=FALSE, sep = ",")





