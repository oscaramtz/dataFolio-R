---
title: "Questions for data science"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
From.
https://www.coursera.org/learn/data-scientists-tools

##Types of Data Science Questions (order of difficulty)
- Descriptive (Goal: describe a set of data)
  --Is the first kind of data analysis performed
  -- Commonly applied to census data
  --Description and interpretation are different steps
  --Descriptions can usually not be generalized without additional statistical modeling
- Exploratory (Goal: find relationships you didn't know about)
  -- Exploratory models are good for discovering new connections
  -- They are also useful for defining future studies
  -- Exploratory analyses are usualy not the final say
  -- exploratory analyses alone should not be used for generalizing/predicting
  -- Correlations does not imply causation
- Inferential (Goal: Use a relatively small sample of data to say something about a bigger population)
  -- inference is commonly the goal of statistical models
  --Inference involves estimating both the quantity you care about and your uncertainty about your estimate
  -- Inference depends heavily on both, the population and the sampling scheme
- Predictive (Goal: To use the data on some objects to predictvalues for another object)
  -- If "X" predicts "Y" it does not mena that "X" causes "Y"
  -- Accurate prediction depends heavily on measuring the right variables
  -- Although there are better and worse predictions models, more data and a simple model really well
  -- Prediction is very hard, especially about the future references
- Causal (Goal: To find out what happends yo one variable when you make another variable change)
  -- Usually ramdomized studies are required to identify causation
  -- There are approaches to inferring causation in non-randomized studies, but they are complicated and sensitive to assumptions
  -- Causal relationship are usually identifies as average effects, but may not apply to every individual
  -- Causal models are usually the gold standart for data analysis
- Mechanistic (Goal: Understand the exact changes in variables that lead to changes in other variables for individual objects)
  -- Incredibly hard to infer, except in simple situations
  -- Usually modeled by a deterministic set of quations (physical/engineering science)
  -- Generally the random component of the data is measurement error
  -- If the equiations are known but the parameters are not, they may be inferred with data analysis
  
  ## The data is the second most important thing
  - The most important thing in data science is the question
  - The second most important thing is the data
  - Often the data will limit or enable the questions
  - But having data can't save you if you don't have a question
