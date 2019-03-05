
## clear the console
## click on the console and type ctrl-l

## clear the workspace
ls() # show workspace
rm(list=ls()) # clear workspace
ls() # show empty workspace

fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile=".data/cameras.csv", method="curl")
cameraData <- read.csv("./data/cameras.csv")
names(cameraData)

tolower(names(cameraData))

splitNames = strsplit(names(cameraData), "\\.")
splitNames[[5]]
splitNames[[6]]
  
myList <- list(letters=c("A", "b", "c"), numbers=1:3, matrix(1:25, ncol=5))
head(myList)

myList[1]
myList$letters
myList[[1]]

splitNames[[6]][1]

firstElement <- function(x){x[1]}
sapply(splitNames, firstElement)

fileUrl1 <- "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
fileUrl2 <- "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
download.file(fileUrl1, destfile=".data/reviews.csv", method="curl")
download.file(fileUrl2, destfile=".data/solutions.csv", method="curl")

reviews <- read.csv("./data/reviews.csv")
head(reviews,2)

solutions <- read.csv("./data/solutions.csv")
head(solutions,2)

names(reviews)
sub("_", "", names(reviews),)

testName <- "this_is_a_test"
sub("_", "", testName)
gsub("_", "", testName)

grep("Alameda", cameraData$intersection)
table(grepl("Alameda", cameraData$intersection))
cameraData2 <- cameraData[!grepl("Alameda", cameraData$intersection), ]

dim(cameraData)
dim(cameraData2)

grep("Alameda", cameraData$intersection, value=TRUE)
grep("JeffStreet", cameraData$intersection)
length(grep("JeffStreet", cameraData$intersection))

library(stringr)

nchar("Jeffrey Leek")
substr("Jeffrey Leek", 1, 7)
paste("Jeffrey", "Leek")
paste0("Jeffrey", "Leek")
str_trim("Jeff       ")

d1 <- date()
d1
class(d1)

d2 <- Sys.Date()
d2
class(d2)
format(d2, "%a %b %d")

x <- c("1jan1960", "2jan1960", "31mar1960", "30jul1960")
z <- as.Date(x, "%d%b%Y")
z
z[1] - z[2]
as.numeric(z[1] - z[2])

weekdays(d2)
months(d2)
julian(d2)

library(lubridate)
ymd("20140108")
ymd("140108")

ymd_hms("2011-08-03 10:15:03")
ymd_hms("2011-08-03 10:15:03", tz="Pacific/Auckland")
?Sys.timezone

##________________________________ 
## QUIZZ - Problem_1

df <- read.csv("./data/ss06hid.csv", stringsAsFactors = FALSE)
split_names <- strsplit(names(df),"wgtp")
split_names[123]

## output:
##     [[1]]
##     [1] ""   "15"

##________________________________ 
## QUIZZ - Problem_2
gdp = read.csv("./data/GDP.csv", skip=5, nrows=190, stringsAsFactors=F, header=F)
gdp <- gdp[, c(1, 2, 4, 5)]
colnames(gdp) <- c("CountryCode", "Rank", "Country", "GDP")
gdp$GDP <- as.numeric(gsub(",", "", gdp$GDP, fixed=T))
summary(gdp$GDP)
mean(gdp$GDP,na.rm = TRUE)

## output:
##     [1] 377652.4

##________________________________ 
## QUIZZ - Problem_3
gdp = read.csv("./data/GDP.csv", skip=5, nrows=190, stringsAsFactors=F, header=F)
gdp <- gdp[, c(1, 2, 4, 5)]
colnames(gdp) <- c("CountryCode", "Rank", "Country", "GDP")
gdp$GDP <- as.numeric(gsub(",", "", gdp$GDP, fixed=T))

countryNames <- gdp$Country
countryNames

length(grep("United$",countryNames))
## output:
##   [1] 0  

length(grep("*United",countryNames))
## output:
##     [1] 3

length(grep("^United",countryNames))
## output:
##     [1] 3

countryNames[99]
countryNames[186]

##________________________________ 
## QUIZZ - Problem_4
gdp = read.csv("./data/GDP.csv", skip=5, nrows=190, stringsAsFactors=F, header=F)
gdp <- gdp[, c(1, 2, 4, 5)]
colnames(gdp) <- c("CountryCode", "Rank", "Country", "GDP")
gdp$GDP <- as.numeric(gsub(",", "", gdp$GDP, fixed=T))

## read & clean edstats
edstats = read.csv("./data/EDSTATS_Country.csv", stringsAsFactors=F, header=T)
colnames(edstats)

## merge gdp & edstats
matchedCountries <- merge(gdp, edstats, all = TRUE, by = c("CountryCode"))
specialNotes <- matchedCountries$Special.Notes

juneEnders <- grep("Fiscal year end: June 30",specialNotes)
length(juneEnders)
## output:
##     [1] 13

matchedCountries[juneEnders, c("Country", "Special.Notes")]

##________________________________ 
## QUIZZ - Problem_5

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

length(grep("^2012",sampleTimes))
## output:
##     [1] 250

library(lubridate)
sampleDates <- ymd(sampleTimes)
table(year(sampleTimes), weekdays(sampleTimes))
## output:
##            Friday Monday Thursday Tuesday Wednesday
##     2007     51     48       51      50        51
##     2008     50     48       50      52        53
##     2009     49     48       51      52        52
##     2010     50     47       51      52        52
##     2011     51     46       51      52        52
##     2012     51     47       51      50        51
##     2013     51     48       50      52        51
##     2014     50     48       50      52        52
##     2015     49     48       51      52        52
##     2016     51     46       51      52        52
##     2017     51     46       51      51        52
##     2018     51     48       51      51        50
##     2019      8      6        9       8         9

