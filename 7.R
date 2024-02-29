 
# Question 2 

# installing and loading packages 
library(dplyr)  # for data manipulation
library(ggplot2)  # for visualization
library(pROC)  
library(caret)  
library(MASS)  

# setting the working directory and loading csv file
# set the working directory by dding the location of the csv file on your computer 
# the csv file contains data for a recomendation mode visual or auditory and wether it effects if the recomendation is followed.
# RecommendationFollowed is the dependent variable and Mode is the primary independent variable.
setwd("C:\\Users\\qosja\\Downloads\\") # set the working directory to the location of the csv file on your computer.
read.csv("recommendations.csv")
recommendations_data <- read.csv("recommendations.csv")

# Performed an exploratory data analysis to understand its structure, distribution, and any potential patterns or outliers.
# the summary shows that the mean of recommendations followed is 0.4542 meaning on average around 45% of participants followed the recommendations
# for the variables Competent, Intelligent, and Thoughtful have mean values around 5-6, indicating that respondents generally rated the recommend-er moderately to highly in these aspects. 
summary(data)
str(data)
head(data)

# Running logistic regression to analyze how recommendation modality affects whether or not a recommendation is followed.
# I chose logistic regression Since the outcome variable (RecommendationFollowed) is binary (0 or 1), logistic regression is a suitable choice for modeling.
model <- glm(RecommendationFollowed ~ Mode + Gender + Age + Competent + Intelligent + Thoughtful + CompositeIntellect + Stimulus,
             data = data, family = binomial)

# summary of model
# The results of this model show there is a negative relationship between presenting recommendations visually and the likelihood of them being followed.
# The effect of gender is not statistically significant (p-value > 0.05).The effect of age is not statistically significant (p-value > 0.05).
# the Competent, Intelligent, and Thoughtful variables have extremely large coefficients (around -8.942e+06), but their p-values are not significant (p-value > 0.05). It’s likely that these coefficients are not practically meaningful.
summary(model)

# this code interprets the coefficients 
# The exponentiated intercept (0.1436) means that the odds of following a recommendation are quite low when no other factors are considered.
# For each unit increase in ModeVisual, the odds of RecommendationFollowed decrease by about 0.46 (approximately 46%). This suggests that visual mode may negatively impact the likelihood of following recommendations compared to auditory.
# The exponentiated coefficient for gender (0.8889) indicates that gender has minimal impact on the odds of following recommendations.The odds decrease slightly for females compared to males, but the effect is not substantial.
# The exponentiated coefficient for age (0.9983) suggests that age has almost no impact on the odds of following recommendations.
# the Competent, Intelligent, and Thoughtful variables have extremely large coefficients (close to zero after exponentiation), indicating that they have no practical impact on the odds of following recommendations.The confidence intervals for these coefficients include zero, making them statistically insignificant.
# For each unit increase in StimulusCreditCard, the odds of RecommendationFollowed decrease by about 0.47 (approximately 47%).This suggests that using a credit card as a stimulus negatively impacts the likelihood of following recommendations.
# For each unit increase in StimulusExtensionCord, the odds of RecommendationFollowed increase by about 3.23 (approximately 323%).This variable has a significant positive effect on following recommendations.
# For each unit increase in StimulusRestaurant, the odds of RecommendationFollowed decrease by about 0.55 (approximately 55%).
# This implies that restaurant-related stimuli may reduce the likelihood of following recommendations.
exp(coef(model)) # Odds ratios

# visualizing the data 
# Created a bar plot for Mode vs. RecommendationFollowed because it compares the frequency of recomendation followed and not followed for both visual and auditory
# 0 means not followed. 1 means followed.
# This bar graph shows that the auditory mode has more equal numbers of followed and not followed recomedations than the visual.
# the visual had a higher number of recommendations not followed (higher than auditory) auditory had a slightly higher number of recomendations followed.. 

ggplot(data, aes(x = Mode, fill = factor(RecommendationFollowed))) +
  geom_bar(position = "dodge") +
  labs(title = "Effect of Recommendation Modality on Recommendation Followed",
       x = "Mode", y = "Count", fill = "Recommendation Followed")