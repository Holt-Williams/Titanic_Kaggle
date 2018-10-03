#STILL UNDER DEVELOPMENT

#This script is a collection of Explroatory Data Analysis that can be used on the Kaggle Titanic Data Set.
# The majority of the analysis is done with use of the tidyverse set of packages.
library(tidyverse)


train<- read.csv("C:/Users/garland/Desktop/Titanic_Kaggle_GitHub/train.csv")
test<- read.csv("C:/Users/garland/Desktop/Titanic_Kaggle_GitHub/test.csv")
sample<- read.csv("C:/Users/garland/Desktop/Titanic_Kaggle_GitHub/gender_submission.csv")
#it is helpful to look at the head (and tail) of a dataset to maek sure it loaded the data as expected.
head(train)
head(test)
#This also shows us that the test dataset is missing the Survived column as that is what we are predicting



#Check the number of rows for each dataset
nrow(train)
nrow(test)

#check the number of NA's per row. Dependign on which variables used lateron we willneed to refer back to these results to see where we made need to change or drop NAs
map(train, ~sum(is.na(.)))
map(test, ~sum(is.na(.)))
#Age is missing a lot of values from each dataset, and test is missing one fair value.


#Utilizing summary is aslo helpfulto see if there are any outliers, and it also lists NAs
summary(train)
summary(test)

# table can be usful to see how often certain combinations occur
table(train[,c("Survived", "Pclass")])
table(train[,c("Survived", "Sex")])


#cor can be used to check correlation of different variables whichcan be useful in chooisng variables for the model
correlation<- cor(train[,unlist(lapply(train, is.numeric))])
correlation
#Below is a visualization of said correlations
library(PerformanceAnalytics)
chart.Correlation(train[c(1,2,3,6)])



#Plots can be a great way to visualize the relationship of diffrent variables: ggplot

train%>%ggplot(aes(as.factor(Survived),Age))+geom_boxplot()
train%>%ggplot(aes(as.factor(Survived),Fare))+geom_boxplot()
train%>%ggplot(aes(as.factor(Survived),Fare, fill= Sex))+geom_boxplot()
# Alternate style
train%>%ggplot(aes(as.factor(Survived),Fare))+geom_boxplot()+facet_wrap(~Sex)


