## Useful functions for text cleaning

```{R}
tolower() #All the letters to lowercase
toupper() #All the letters to uppercase

strsplit() ## Separate text values by the given character or complex of characters
## example

names <- "inter.1"
names
[1] "inter.1"
splitNames <- strsplit(names, "\\.")
splitNames
[1] "inter" "1"
```

## Substitute
```{R}

names <- "your_name_is"
sub("_", "", names)   ##The command substitutes the first element that match
names
[1] "yourname_is"

names <- "your_name_is"
gsub("_", "", names)   ##gsub() substitutes all the elementes that match
names
[1] "yournameis"


##Finding values grep() which kind retunr, grepl() Logical return


library(stringr)
substr() ## Subtract the number of characters assigned

substr("Oscar Martinez", 1, 5)
[1] "Oscar"

paste("Oscar", "Martinez")
[1] "Oscar Martinez"

paste0("Oscar", "Martinez")
[1] "OscarMartinez"

str_trim("Oscar        ")
[1] "Oscar" 
```


# RegEx (regular expressions)
it is preferred to read the RedEx support page, can be enough with the cheatSheet

[RegExCheatsheet.pdf](https://www.rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf)



