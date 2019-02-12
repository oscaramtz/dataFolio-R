#Checking for and creating directories

## 1 .- Create a data storage directory

```{R}
if (!file.exists("data")){
    dir.create(data)
}
```
Downloading raw data
```{R}
fileUrl <- "https.//data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, 
              destfile = "./data/cameras.csv", 
              method = "curl")

list.files("./data")

dateDownloaded <- date()
```

## 2.- Reading local flat files

```{R}
camaraData <- read.table("./data/camaras.csv", sep = ",", header = TRUE) #Args file, header, sep, row.names, nrows 
    ## can use read.csv("./data/camaras.csv")
head(camaraData, 3)

#Read Excel

fileUrl <- "https.//data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, 
              destfile = "./data/cameras.xlsx", 
              method = "curl")
list.files("./data")
dateDownloaded <- date()

## reading data
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xslx", 
                        sheetIndex = 1, 
                        header = TRUE)
head(camaraData, 3)

## for reading specific rows and colums
colIndex <- 2:3 ## for the second and third colum
rowIndex <- 1:4 ## for the 1 to 4 row
cameraDataSubset <- read.xlsx("./data/cameras.xslx", 
                        sheetIndex = 1, 
                        colIndex = colIndex,
                        rowIndex = rowIndex)
                        
cameraDataSubset
```

#share data
```{R}
write.xlsx() ## same arguments

install.package("XLConnect") ## has more options for writing and manipulatin Excel files
```

```{R}
Reading XML for "Extensible markup language" frequently used to store structured data, widely used in web apps
- Tags, elements and attibutes

-Tags correspond to general labels
-Start tags   #<section>
-End tags     #</section>
-Empty tags   #<lie-breack />
-Elements are specific examples of tags
-#<Greeting> Hello, world!!! </Greeting>
-Attributes are components of the label
-#<img src = "oscar.jpg" alt = "instructor"/>
-#<step number = "3"> Connect A to B. </step>
```
XML Example
```{R}
##Read XML
install.packages("XML")
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, 
                    useInternal = TRUE)
                    
rootNode <- xmlRoot(doc)
xmlName(rootNode)

## Extracting diferent parts of the XML

xmlSApply(rootNode, xmlValue)
```
XPath reading 
```{R}
/node Top level node
//node Node at any leve
node[@attr-name] Node with an attribute name
node[@attr-name] Node with an attribute name attr-name = 'bob'

xpathSApply(rootNode, "//name", xmlValue)

## it will return the names

xpathSApply(rootNode, "//price", xmlValue)

## Example

  fileUrl <- 'http://www.espn.com/nfl/team/schedule/_/name/bal/year/2016'
  doc <- htmlTreeParse(fileUrl, useInternal=TRUE)

  # score vector is straightforward, using <li> tag   
  score <- xpathSApply(doc,"//li[@class='score']", xmlValue)

  # game status is a bit more tricky, because there are two different types
  # first, we combine the two classes in an R object
  gameStatus <- c("//li[@class='game-status loss']","//li[@class='game-status win']")

  # second, we use the object as the query string in xpathSApply()
  result <- xpathSApply(doc,gameStatus,xmlValue)

  opponent <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)

  # third, use a similar technique to extract game dates from the table, ignoring bye week
  daysOfWeek <- c("//td['Sun,']","//td['Mon,']","//td['Thu,']","//td['Sat,']")
  date <- grep("Sun,|Mon,|Thu,|Sat,",xpathSApply(doc,daysOfWeek,xmlValue),value=TRUE)

  # finally, combine into a data frame and print
  team <- rep("Baltimore Ravens",length(opponent))
  scoresData <- data.frame(team,date,opponent,result)
  scoresData
```

#Reading Json 
```{R}
install.packages("jsonlite")
library(jsonlite)

jsonData <- fromJSON("https://api.github.com/users/jfleek/repos")
names(jsonData)
names(json$owner)
```

