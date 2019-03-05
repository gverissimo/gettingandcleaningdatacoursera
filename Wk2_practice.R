
## clear the console
## click on the console and type ctrl-l

## clear the workspace
ls() # show workspace
rm(list=ls()) # clear workspace
ls() # show empty workspace

library(RMySQL)
ucscDb <- dbConnect(MySQL(),user="genome",host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;")
result
dbDisconnect(ucscDb)

hg19 <- dbConnect(MySQL(), 
                  user="genome", 
                  db="hg19", 
                  host="genome-mysql.cse.ucsc.edu")

allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query)
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10)
dbClearResult(query)
dim(affyMisSmall)

dbDisconnect(hg19)


source("http://bioconductor.org/biocLite.R")
biocLite("BiocUpgrade")
biocLite("rhdf5")

Library(rhdf5)
created = h5createFile("example.h5")
created
bm <- BiocManager::available()

source("https://bioconductor.org/biocLite.R")
BiocManager::install("rhdf5")

library(rhdf5)
created = h5createFile("example.h5")

created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")

h5ls("example.h5")

A = matrix(1:10, nr=5, nc=2)
A
h5write(A, "example.h5", "foo/A")
h5ls("example.h5")

B = array(seq(0.1, 2.0, by=0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
B

h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")

df = data.frame(
        1L:5L, 
        seq(0, 1, length.out=5), 
        c("ab","cde","fghi","a","s"), 
        stringsAsFactors=FALSE
        )
df
h5write(df, "example.h5", "df")
h5ls("example.h5")

readA = h5read("example.h5","foo/A")
readA
readB = h5read("example.h5","foo/foobaa/B")
readB
readdf = h5read("example.h5","df")
readdf

h5write(c(12,13,14), "example.h5", "foo/A", index=list(1:3,1))
h5read("example.h5","foo/A")

con = url("https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode


doc <- htmlTreeParse(fileUrl,asText=TRUE,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

library(XML)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url,useInternalNodes = TRUE)
html <- htmlParse(url)
xpathSApply(html,"//td[@id='col-citedby']", xmlValue)

library(httr)
url <- "https://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html2 = GET(url)
content2 = content(html2, as="text")
parsedHtml = htmlParse(content2, asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

pg2 = GET("http://httpbin.org/basic-auth/user/passwd", 
          authenticate("user", "password")
          )
pg2
names(pg2)

google = handle("http://google.com")
pg1 = GET(handle=google, path="/")
pg1
pg2 = GET(handle=google, path="search")
pg2

## QUIZ

## application name: gmv_github
## Homepage URL: http://github.com
## application description: n/a
## authorization callback URL: http://localhost:1410
## Client ID: 2cf0f8612a94c0b5844d
## Client Secret: bcc4689f9a72174c8dded6e37fab40cfcf560bdb

library(httpuv)
library(httr)
library(jsonlite)

oauth_endpoints("github")
myapp <- oauth_app("gmv_github",
                   key = "2cf0f8612a94c0b5844d",
                   secret = "bcc4689f9a72174c8dded6e37fab40cfcf560bdb"
                   )

# get oauth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gittoken <- config(token = github_token)
myrequest <- GET("https://api.github.com/users/jtleek/repos", gittoken)
stop_for_status(myrequest) # Take action on http error

# Extract content from a request
myjson = content(myrequest)

# Convert to a data.frame
DF = jsonlite::fromJSON(jsonlite::toJSON(myjson))

# Subset data.frame
DF[DF$full_name == "jtleek/datasharing", "created_at"] 

# Answer: 
# 2013-11-07T13:25:07Z



