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
###Admit

Gender| Admitted| Rejected
---|---|---
Male|1198|1493
Female|557|1278
