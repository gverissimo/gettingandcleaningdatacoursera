
## clear the console
## click on the console and type ctrl-l

## clear the workspace
ls() # show workspace
rm(list=ls()) # clear workspace
ls() # show empty workspace

If(!dir.exists("data")) dir.create("data")
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile="./data/cameras.csv", method="curl")

dateDownloaded <- date()

cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE)
head(cameraData)

cameraData2 <- read.csv("./data/cameras.csv")
head(cameraData2)

## download excel file
if(!file.exists("data")) dir.create("data")
fileURL <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURL, destfile="./data/cameras.xlsx", method="curl")
dateDownloaded <- date()

library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)
head(cameraData)

colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",
                              sheetIndex=1, 
                              colIndex=colIndex,
                              rowIndex=rowIndex)
cameraDataSubset

library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
## URL resulted in XML error. Downloaded doc manually to working directory
## doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
doc <- xmlTreeParse("simple.xml",useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

rootNode[[1]]
rootNode[[1]][[1]]

xmlSApply(rootNode,xmlValue)

xpathSApply(rootNode,"//name",xmlValue)

xpathSApply(rootNode,"//price",xmlValue)

fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,asText=TRUE,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

library(jsonlite)

jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login

myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)

iris2 <- fromJSON(myjson)
head(iris2)

library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)

tables()

DT[2,]
DT[DT$y=="a",]
DT[c(2,3)]
DT[,c(2,3)]

## Quiz
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL, destfile="./data/AmericanCommunitySurvey06.csv", method="curl")
SurveyData <- read.csv("./data/AmericanCommunitySurvey06.csv")
head(SurveyData)
dim(SurveyData)
propertyValue <- SurveyData[which(SurveyData[,"VAL"] >= 24),]$VAL
length(propertyValue)
# ...another way
SurveyData <- read.csv("./data/AmericanCommunitySurvey06.csv")
propertyValue <- SurveyData[,c("SERIALNO","VAL")]
targetValue <- propertyValue[which(propertyValue[,"VAL"] >= 24),]
dim(targetValue)
targetValue

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileURL, destfile="./data/NaturalGasAquisitionProgram.xlsx", method="curl")
dat <- read.xlsx("./data/NaturalGasAquisitionProgram.xlsx",sheetIndex=1,header=TRUE,rowIndex=18:23,colIndex=7:15)
dat
sum(dat$Zip*dat$Ext,na.rm=T)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileURL, destfile="./data/BaltimoreRestaurants.xml", method="curl")
restaurants <- xmlTreeParse("./data/BaltimoreRestaurants.xml", useInternal=TRUE)
rootNode <- xmlRoot(restaurants)
xmlName(rootNode)
rootNode[[1]]
rootNode[[1]][[1]]
rootNode[[1]][[2]]
zipcodes <- xpathSApply(rootNode,"//zipcode",xmlValue)
propertyValue <- SurveyData[which(SurveyData[,"VAL"] >= 24),]$VAL
zip21231 <- zipcodes=="21231"
sum(zip21231)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileURL, destfile="./data/AmericanCommunitySurvey06a.csv", method="curl")
DT <- fread("./data/AmericanCommunitySurvey06a.csv")
head(DT)
dim(DT)
system.time( sapply(split(DT$pwgtp15,DT$SEX),mean) )

sapply(split(DT$pwgtp15,DT$SEX),mean)
mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
mean(DT$pwgtp15,by=DT$SEX)
tapply(DT$pwgtp15,DT$SEX,mean)
DT[,mean(pwgtp15),by=SEX]

system.time( {
        sapply(split(DT$pwgtp15,DT$SEX),mean) 
        } )
system.time( {
        mean(DT[DT$SEX==1,]$pwgtp15)
        mean(DT[DT$SEX==2,]$pwgtp15) 
        } )
system.time( {
        rowMeans(DT)[DT$SEX==1]
        rowMeans(DT)[DT$SEX==2] 
        } )
system.time( {
        mean(DT$pwgtp15,by=DT$SEX) 
        } )
system.time( {
        tapply(DT$pwgtp15,DT$SEX,mean) 
        } )
system.time( {
        DT[,mean(pwgtp15),by=SEX] 
        } )
