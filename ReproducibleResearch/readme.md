
# Reproducible Research
taken from [Report Writing for Data Science in R](https://leanpub.com/reportwriting)
## Elements of reproducibility

- Analytic data available
- Analytic code available
- Documentation of the code and data
- Standard means of distribution

## literate statistical programing

The text is readable by people and the code is readable by computers. The analysis is described in a series of text and code chunks. Each kind of code chunk will do something like load some data or compute some results. Each text chunk will relay something in a human readable language.

### Tools for literate statistical programing
- [Sweave](https://cran.r-project.org/doc/contrib/Rivera-Tutorial_Sweave.pdf)
- [Knitr](https://yihui.name/knitr/)

## Organizing a Data Analysis
**Not an universal way**
- __Raw and processed data__

# Structure of a Data analysis
- __Define the question__

"Ask yourselver, what problem have you solved, ever, that was worth solvng, where you knew all the given information in advance? Where didn't have a surplus of information and have to filter it out, or you had insufficient information and have to go find some?"
**Dan Myer, Mathematics Educator**

You need a science background for doing the right question

- __Define the ideal data set__

Define the data needed for an accurate analysis (ideal)

- __Determine what data you can access__

Sometimes you can find data free on the web, other times you mey need to buy data. Be sure to respect the terms of use, if the data don't exist, you may neef to generate it yourself

- __Obtain the data__

Try to obtain the raw data, be sure to reference the source also, polite mails go a long way. If you will load the data from an internet source, record the url and time accessed

- __Clean the data__

Raw data often needs to be processed, if it is preprocessed, make sure you understand how. Understand the source of the data (if is a census, sample, convenience sample etc.), May need reformating, subsampling __always record these steps__

__Determine if the data are good enough__ if not, quit or change data

- __Exploratory data analysis__

 Look at summaries of the data, check missing data, create exploratory plots, perform exploratory analysis (e.g. Clustering)
 
 _Some steps_ 
```{R}
names()
head()
table()
plot()
+ scatter
+ lineal
+ bar
+ box&whiskers
+ hclust
```
- __Statistical prediction/modeling__

Should be informed by the results of your exploratory analysis, exact methods depend on the question of interest, tranformation/processing should be accounted for when necessary. Measures of uncertainty should be reported.

predict if a mail is spam or not just from a single variable
```{R}
trainSpam$numType <- as.numeric(trainSpam$Type) - 1
costFunction <- function(x, y) {sum (x != (y > 0.5))}
cvError = rep(NA, 55)
library(boot)

for (i in 1:55) {
  lmFormula <- reformulate(names(trainSpam)[i], response =  "numType")
  glmFit <- glm(lmFormula, family = "binomial", data =  trainSpam)
  cvError[i] <- cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

## Which predictor has minimun cros-validated error?
names(trainSpam)[which.im(cvError)]
```

- __Interpret results__

Use the appropiate language: describes, correlates with/associated with, lead to/causes, predicts

Give an explaniation

interpret coefficients

interpret measures of uncertainty

- __Challenge results__

Challange all steps: question, data source, processing, analysis, conclusions

Challange measures of uncertainty

Challenge choices of terms to include in models

Think of potential alternative analysis

- __Synthesize/write up results__

Lead with the question, summarize the analyses into the story

Don't include every analysis, include it: if it is needed for the story or if it is needed to adress a challenge

Order analyses according to the story, rather than chronologically

Include "pretty" figures that contribute to the story

- __Create reproducible code__

Using standard tools, and readeble 


