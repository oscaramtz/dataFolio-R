---
title: "PracticalMachineLearning -Course proyect-"
author: "OscarAMtz"
date: "13/4/2020"
output: html_document
---

```{r setup, include=FALSE, echo=FALSE}
knitr::opts_chunk$set(echo = FALSE)
```

## Background for this tutorial

Using devices for activity monitoring it is now possible to collect a large amount of data about personal activity relatively inexpensively. 
These type of devices are part of the quantified self movement – a group of enthusiasts who take measurements about themselves regularly to improve their health, to find patterns in their behavior, or because they are tech geeks. One thing that people regularly do is quantify how much of a particular activity they do, but they rarely quantify how well they do it.
In this tutorial we will be able to use data from accelerometers on the belt, forearm, arm, and dumbell of 6 participants. They were asked to perform barbell lifts correctly and incorrectly in 5 different ways. 
More information is available from the [website](http://groupware.les.inf.puc-rio.br/har)

## Data

The data used for this proyect can be found here:

[Training](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv)
[Testing](https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv)

[More info](http://groupware.les.inf.puc-rio.br/har)
