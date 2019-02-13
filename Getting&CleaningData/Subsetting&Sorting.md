## Sample

```{R}
set.seed(12345)
x <- data.frame("var1" = sample(1:5), "var2" = sample(6:10), "var3" = sample(11:15))
x <- x[sample(1:5),]; x$var2[c(1,3)] = NA
x
```

Operator| Description
---|---
+|Addition
– |Subtraction
`*`	|Multiplication
/ |Division
^ |Exponent
%% |Modulus (Remainder from division)
%/% |Integer Division


## Subsetting obey to logical commands if true will be called but if is false it will not be called

table(restData$zipCode %in% c("21212" ,"21213"))


### retunrs a table with the row values if the condition is satisficed
restData[restData$zipCode %in% c("21212" ,"21213"),]

## Cross Tabs
```{R}
data("UCBAdmissions")
df <- as.data.frame(UCBAdmissions)
summary(df)

xt <- xtabs(Freq ~ Gender + Admit, data = df)
xt
```
Resulting table
###Admit

Gender| Admitted| Rejected
---|---|---
Male|1198|1493
Female|557|1278


## Flat Tables summarize the data 
```{R}
warpbreaks$replicate <- rep(1:9, len = 54)
xt <- xtabs(breaks ~ ., data = warpbreaks)
ftable(xt)
```

## Creating new variables

- Missingness indicators
- "Cutting up" quantitative variables
- Applying transforms

```{R}
if(!exists("./data")){dir.create("./data")}
url <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(url, destfile = "./data/restaurants.csv")
restData <- read.csv("./data/restaurants.csv")

restData$nearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$nearMe)

restData$zipWrong <- ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode < 0)

restData$ZipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)

## Create Factor variables
restData$zcf <- factor(restData$zipCode)

```

## Reshape data
###Principles for tidy data
- Each variable forms a column
- Each observation forms a row
- Each table/file stores data about one kind of observation (people/hospital)

### MTCars example
```{R}
mtcars$carname <- rownames(mtcars)
carMelt <- melt(mtcars, id = c("carname", "gear", "cyl"), measure.vars = c("mpg", "hp"))
head(carMelt, 3)

##Casting data Frames
cylData <- dcast(carMelt, cyl ~ variable)

cylData <- dcast(carMelt, cyl ~ variable, mean)
cylData
```

### InsectSprays example
```{R}
head(InsectSprays)

tapply(InsectSprays$count, InsectSprays$spray, sum)

library(dplyr)
ddply(InsectSprays, .(spray), summarize, sum = sum(count))
```
