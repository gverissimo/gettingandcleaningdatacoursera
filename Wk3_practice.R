
## clear the console
## click on the console and type ctrl-l

## clear the workspace
ls() # show workspace
rm(list=ls()) # clear workspace
ls() # show empty workspace


set.seed(13435)
X <- data.frame(
        "var1" = sample(1:5), 
        "var2" = sample(6:10), 
        "var3" = sample(11:15)
        )
X
X <- X[sample(1:5),]
X
X$var2[c(1,3)] = NA
X

X[,1]
X[,"var1"]
X[1:2,"var2"]

X[(X$var1 <=3 & X$var3>11), ]
X[(X$var1 <=3 | X$var3>15), ]

X[which(X$var2 >8), ]

sort(X$var1)
sort(X$var1, decreasing=TRUE)
sort(X$var2, na.last=TRUE)

X
X[order(X$var1),]
X[order(X$var1,X$var3),]

library(plyr)

arrange(X, var1)
arrange(X, desc(var1))

X$var4 <- rnorm(5)
X

Y <- cbind(X, rnorm(5))
Y


fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/restaurants.csv", method="curl")
restData <- read.csv("./data/restaurants.csv")
head(restData)
tail(restData)
summary(restData)
str(restData)
quantile(restData$councilDistrict, na.rm=TRUE)
quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.90), na.rm=TRUE)
table(restData$zipCode, useNA="ifany")
plot(table(restData$zipCode, useNA="ifany"))

table(restData$zipCode[which(restData$zipCode>2100)], useNA="ifany")
plot(table(restData$zipCode[which(restData$zipCode>2100)], useNA="ifany"))

table(restData$councilDistrict, restData$zipCode)

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode>0)
colSums(is.na(restData))
all(colSums(is.na(restData))==0)

table(restData$zipCode %in% c("21212"))
table(restData$zipCode %in% c("21212", "21213"))
restData[restData$zipCode %in% c("21212", "21213"), ]

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
dim(DF)
summary(DF)
xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

warpbreaks$replicate <- rep(1:9, len=54)
summary(warpbreaks)
str(warpbreaks)
xt = xtabs(breaks ~., data=warpbreaks)
xt
ftable(xt)

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

s1 <- seq(1, 10, by=2)
s1
s2 <- seq(1, 10, length=3)
s2
x <- c(1, 3, 8, 25, 100)
x
seq(along=x)

restData$nearMe = restData$neighborhood %in% (c("Roland Park", "Homeland"))
table(restData$nearMe)

restData$zipWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
table(restData$zipWrong, restData$zipCode<0)

restData$zipGroups = cut(restData$zipCode, breaks=quantile(restData$zipCode))
table(restData$zipGroups)
table(restData$zipGroups, restData$zipCode)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)
str(restData)

yesno <- sample(c("yes", "no"), size=10, replace=TRUE)
table(yesno)
yesnofac = factor(yesno, levels=c("yes", "no"))
table(yesnofac)
relevel(yesnofac, ref="yes")
table(yesnofac)
as.numeric(yesnofac)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

library(plyr)
restData2 = mutate(restData, zipGroups=cut2(zipCode, g=4))
table(restData2$zipGroups)

library(reshape2)
head(mtcars)

mtcars$carname <- rownames(mtcars)
head(mtcars)
carMelt <- melt(
        mtcars, 
        id=c("carname", "gear", "cyl"), 
        measure.vars=c("mpg", "hp")
        )
head(carMelt, n=3)
tail(carMelt, n=3)
summary(carMelt)

cylData <- dcast(carMelt, cyl ~ variable)
cylData

cylData <- dcast(carMelt, cyl ~ variable,mean)
cylData

head(InsectSprays)
tail(InsectSprays)
tapply(InsectSprays$count, InsectSprays$spray, sum)

spIns = split(InsectSprays$count, InsectSprays$spray)
spIns
sprCount = lapply(spIns, sum)
sprCount
unlist(sprCount)
sapply(spIns, sum)

ddply(InsectSprays, .(spray), summarise, sum=sum(count))
spraySums <- ddply(InsectSprays, .(spray), summarise, sum=ave(count, FUN=sum))
dim(spraySums)
head(spraySums)

library(dplyr)
chicago <- readRDS("./data/chicago.rds")
dim(chicago)
str(chicago)
head(select(chicago, 1:5))
names(chicago)
names(chicago)[1:3]
head(select(chicago, city:dptp))

i <- match("city", names(chicago))
j <- match("dptp", names(chicago))
head(chicago[, -(i:j)])

head(select(chicago, -(city:dptp)))

chic.f <- filter(chicago, pm25tmean2 > 30)
head(chic.f, 10)

chic.f <- filter(chicago, pm25tmean2 > 30 & tmpd > 80)
head(chic.f)

head(select(chic.f, 1:3, pm25tmean2), 10)

head(chicago)
head(arrange(chicago, date))
head(arrange(chicago, desc(date)))

chicago <- readRDS("./data/chicago.rds")
head(chicago[, 1:5])
chicago <- rename(chicago, dewpoint = dptp, pm25 = pm25tmean2)
head(chicago[, 1:5])

chicago <- readRDS("./data/chicago.rds")
head(chicago)
chicago <- arrange(chicago, desc(date))
head(chicago)
chicago <- rename(chicago, pm25 = pm25tmean2, dewpoint = dptp)
head(chicago)
chicago <- mutate(chicago, pm25detrend = pm25 - mean(pm25, na.rm=TRUE))
head(select(chicago, pm25, pm25detrend))

chicago <- mutate(chicago, tempcat = factor(1*(tmpd>80), labels = c("cold", "hot")))
hotcold <- group_by(chicago, tempcat)
head(select(hotcold, tmpd, date, pm25, pm25detrend, tempcat), 10)
str(hotcold)

summarize(hotcold, 
          pm25 = mean(pm25, na.rm=TRUE), 
          o3 = max(o3tmean2), 
          no2 = median(no2tmean2)
          )

chicago <- mutate(chicago, year = as.POSIXlt(date)$year + 1900)
years <- group_by(chicago, year)
summarize(years, pm25 = mean(pm25), o3 = max(o3tmean2), no2 = median(no2tmean2))

chicago %>% 
        mutate(month = as.POSIXlt(date)$mon + 1) %>% 
        group_by(month) %>% 
        summarize(pm25 = mean(pm25, na.rm = TRUE),
                      o3 = max(o3tmean2, na.rm = TRUE),
                      no2 = median(no2tmean2, na.rm = TRUE)
                      )

## the dropbox links are broken
## fileUrl1 = "https://dl.dropboxusercontent.com/u/7710864/data/reviews-apr29.csv"
## fileUrl2 = "https://dl.dropboxusercontent.com/u/7710864/data/solutions-apr29.csv"
## download.file(fileUrl1, destfile="./data/reviews.csv", method="curl")
## download.file(fileUrl2, destfile="./data/solutions.csv", method="curl")
##
## instead, download files from here: 
## https://github.com/DataScienceSpecialization/courses/tree/master/03_GettingData/04_01_editingTextVariables/data 

reviews =read.csv("./data/reviews.csv")
solutions = read.csv("./data/solutions.csv")
head(reviews)
head(solutions)

names(reviews)
names(solutions)
intersect(names(solutions), names(reviews))

mergedData = merge(reviews, solutions, by.x="solution_id", by.y="id", all=TRUE)
head(mergedData)

mergedData2 = merge(reviews, solutions, all=TRUE)
head(mergedData2)

library(plyr)
df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
arrange(join(df1, df2), id)

df1 = data.frame(id=sample(1:10), x=rnorm(10))
df2 = data.frame(id=sample(1:10), y=rnorm(10))
df3 = data.frame(id=sample(1:10), y=rnorm(10))
dfList = list(df1, df2, df3)
join_all(dfList)


##________________________________ 
## QUIZZ - Problem_1

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile="./data/ss06hid.csv", method="curl")

households = read.csv("./data/ss06hid.csv", header=T)

## from: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
## ACR 1 - Lot size
##     b .N/A (GQ/not a one-family house or mobile home)
##     1 .House on less than one acre
##     2 .House on one to less than ten acres
##   **3 .House on ten or more acres**
## ...
## AGS 1 - Sales of Agriculture Products
##     b .N/A (less than 1 acre/GQ/vacant/
##       .2 or more units in structure)
##     1 .None
##     2 .$ 1-$999 
##     3 .$ 1000 - $ 2499 
##     4 .$ 2500 - $ 4999 
##     5 .$ 5000 - $ 9999 
##   **6 .$10000+**

agricultureLogical <- households$ACR == 3 & households$AGS == 6
summary(agricultureLogical)
which(agricultureLogical)[1:3]
## output: 
##     [1] 125 238 262


##________________________________ 
## QUIZZ - Problem_2

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
download.file(fileUrl, destfile="./data/jeff.jpg", mode = "wb")

library(jpeg)
jeffpic <- readJPEG("./data/jeff.jpg", native = TRUE)
hist(jeffpic)
quantile(jeffpic, probs = c(0.3, 0.8))
## output: 
##     30%       80%
##     -15259150 -10575416 


##________________________________ 
## QUIZZ - Problem_3

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl, destfile="./data/GDP.csv", method="curl")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl, destfile="./data/EDSTATS_Country.csv", method="curl")

## read & clean gdp
gdp = read.csv("./data/GDP.csv", skip=5, stringsAsFactors=F, header=F)
gdp <- gdp[, c(1, 2, 4, 5)]
colnames(gdp) <- c("CountryCode", "Rank", "Country", "GDP")
gdp$GDP <- as.numeric(gsub(",", "", gdp$GDP, fixed=T))
gdp$Rank <- as.numeric(gsub(",", "", gdp$Rank, fixed=T))
gdp <- gdp[1:215, ]
gdp <- gdp[gdp$CountryCode!="" & !is.na(gdp$GDP), ]
str(gdp)
colnames(gdp)

## read & clean edstats
edstats = read.csv("./data/EDSTATS_Country.csv", stringsAsFactors=F, header=T)
colnames(edstats)

## merge gdp & edstats
matchedCountries <- merge(gdp, edstats, all = TRUE, by = c("CountryCode"))

## Number of matched countries
dim(matchedCountries[!is.na(matchedCountries$Country), ])
## output: 
##     [1] 190  34

library(dplyr)
matchedCountries %>%
        arrange(desc(GDP)) %>%
        select(CountryCode:GDP) %>%
        filter(Rank==13)
## output:
##      CountryCode Rank Country     GDP
## 1         ESP   13   Spain 1322965

library(dplyr)
matchedCountries %>%
        arrange(Rank) %>%
        select(CountryCode:GDP, Income.Group) %>%
        head(n=25)

matchedCountries %>%
        arrange(Rank) %>%
        select(CountryCode:GDP, Income.Group) %>%
        group_by(Income.Group) %>%
        summarise(meanRank = mean(Rank, na.rm=TRUE))
## output:
## A tibble: 7 x 2
## Income.Group         meanRank
## <chr>                   <dbl>
##         1 NA                      131  
## 2 ""                      NaN  
## 3 High income: nonOECD     91.9
## 4 High income: OECD        33.0
## 5 Low income              134. 
## 6 Lower middle income     108. 
## 7 Upper middle income      92.1

matchedCountries <- merge(gdp, edstats, all = TRUE, by = c("CountryCode"))
cutCountries <- matchedCountries %>%
        arrange(Rank) %>%
        select(CountryCode:GDP, Income.Group) %>%
        mutate(quintile=ntile(GDP, 5, result="factor", reverse=FALSE))
table(cutCountries$Income.Group, cutCountries$quintile)
print(cutCountries)


test = "tBookBinding"
gsub(pattern="^t", replacement="Time", test)

  
