
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
- Define the question

"Ask yourselver, what problem have you solved, ever, that was worth solvng, where you knew all the given information in advance? Where didn't have a surplus of information and have to filter it out, or you had insufficient information and have to go find some?"
**Dan Myer, Mathematics Educator**

You need a science background for doing the right question

- Define the ideal data set

Define the data needed for an accurate analysis (ideal)

- Determine what data you can access

Sometimes you can find data free on the web, other times you mey need to buy data. Be sure to respect the terms of use, if the data don't exist, you may neef to generate it yourself

- Obtain the data

Try to obtain the raw data, be sure to reference the source also, polite mails go a long way. If you will load the data from an internet source, record the url and time accessed

- Clean the data

Raw data often needs to be processed, if it is preprocessed, make sure you understand how. Understand the source of the data (if is a census, sample, convenience sample etc.), May need reformating, subsampling __always record these steps__

__Determine if the data are good enough__ if not, quit or change data

- Exploratory data analysis



- Statistical prediction/modeling
- Interpret results
- Challenge results
- Synthesize/write up results
- Create reproducible code
  
