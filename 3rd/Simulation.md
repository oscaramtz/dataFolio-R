# Generating random numbers

Functions for probability distributions in {R}
Four associated funtions
> **d** for Density
> **r** for random number generation
> **P** for cumulative distribution (probability)
> **q** for quantile function

all apply to:

> norm
> pois
> gama
> binom ## Setting binomial distribution randomized
> exponentinal

**set.seed()** to assing se random set that you will use 

```{R}
## Common ttibutes size, mean, SD
rnorm() 
# Generates random Normal variates with a given mean and standard deviation

dnorm()
# Evaluates the Normal probability density (with a give mean/SD)at a point (or vector of point)

pnorm()
# Evaluate the cumulative distribution function for a Normal distribution

rpoins()
# Generate random Poisson variates with a given rate
```

## Simulation of a Linear model

```{R}
## Normal distribution
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 2)
y <- 0.5 +2 *x +e
summary(y)
plot(x, y)

## Binomial distribution
set.seed(10)
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)
y <- 0.5 +2 *x +e
summary(y)
plot(x, y)

## Poisson model distribution
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 *x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)

##
There are two methods for normalizing the data

"by.total"
"by.self"

## Simulation for sample function from a specified set of (scalar) objects allowing you to sample from arbitrary distribution

str(sample())
```

# R profiler

+ Profiling is a systematic way to examine how mush time is spend iin different parts of a program
+ Useful when trying to optimize your code
+ Often code runs fine once, but what if you have to put it in a loop for 1,000 itirations? is still fast enough?
+ Profiling is better than guessing

## General principles of optimization

+ Design first, then optimize
+ Remember: premature optimization is the root of all evil
+ Measure (collect data), don´t guess
+ I you're going to be a scientist, you need to apply the same principles here!

### Tools
```{R}
Rprof()
summaryRprof()

system.time()
parallel package

## example 
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
res <- data.frame()
system.time({
  trial <- 1
  while(trial <= trials) {
    ind <- sample(100, 100, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
    r <- coefficients(result1)
    res <- rbind(res, r)
    trial <- trial + 1
  }
})
### Response
##   user  system elapsed 
##  17.70    0.08   17.84 
```
