# Question 2 

# installing and loading packages 
library(dplyr)  # for data manipulation
library(ggplot2)  # for visualization
library(pROC)  # for ROC curve and AUC calculation
library(caret)  # for model evaluation
library(MASS)  # for stepAIC

# setting the working directory and loading csv file
setwd("C:\\Users\\qosja\\Downloads\\")
read.csv("recommendations.csv")
data <- read.csv("recommendations.csv")

# Perform exploratory data analysis to understand its structure, distribution, and any potential patterns or outliers.
summary(data)
str(data)
head(data)