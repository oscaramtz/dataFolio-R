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

- . character {dot}, search for any character in the position that is placed
- | character {pipe}, identifies one OR other expression, it can be evaluate as an OR
- ^ character {pyramid quote}, referes to search at the begining of a text line
- [Aa] brackets {[]}, the hard brackets are used to serch different characters in the same position. In this case is Capital A an lowercase a
- * repeat the character any number including none
- + repeat the character at least one of the item
- \ use of foward slash supress the colon effect


# Examples

[0-9]+(.*)[0-9]+ Means := at least one number, follow by any number of characters, follow by at least one number
[Bb]ush( +[^ ]+ +){1, 5} debate Means := search bush or Bush follow by at least one space, follow by somthing that is not a space, follow by at least one space between 1 to 5 times follow by the word debate


