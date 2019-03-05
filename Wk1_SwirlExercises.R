
# clear terminal
ctrl-L

# load swirl
library(swirl)

# load class
install_from_swirl("Getting and Cleaning Data")

# clear workspace
ls()
rm(list=ls())

# launch swirl
swirl()

# 1) 
mydf <- read.csv(path2csv, stringsAsFactors=FALSE)
dim(mydf)
head(mydf)

library(dplyr)
packageVersion("dplyr")
cran <- tbl_df(mydf)
rm("mydf") # remove original mydf

# | dplyr output (of cran) is much more informative and compact than what we would get if we
# | printed the original data frame (mydf) to the console.
# 
# | First, we are shown the class and dimensions of the dataset. Just below that,
# | we get a preview of the data. Instead of attempting to print the entire
# | dataset, dplyr just shows us the first 10 rows of data and only as many columns
# | as fit neatly in our console. At the bottom, we see the names and classes for
# | any variables that didn't fit on our screen.
cran

# | According to the "Introduction to dplyr" vignette written by the package
# | authors, "The dplyr philosophy is to have small functions that each do one
# | thing well." Specifically, dplyr supplies five 'verbs' that cover most
# | fundamental data manipulation tasks: 
# |     * select(), 
# |     * filter(), 
# |     * arrange(), 
# |     * mutate(),
# |     * summarize().
?select

# | The first thing to notice is that we don't have to type cran$ip_id,
# | cran$package, and cran$country, as we normally would when referring to columns
# | of a data frame. The select() function knows we are referring to columns of the
# | cran dataset.
# | Also, note that the columns are returned to us in the order we specified, even
# | though ip_id is the rightmost column in the original dataset.
select(cran, ip_id, package, country)

# | Normally, a:b notation is reserved for numbers, but select() allows you to
# | specify a sequence of columns this way, which can save a bunch of typing. Use
# | select(cran, r_arch:country) to select all columns starting from r_arch and
# | ending with country.
select(cran, r_arch:country)

# | Instead of specifying the columns we want to keep, we can also specify the
# | columns we want to throw away. To see how this works, do select(cran, -time) to
# | omit the time column.
select(cran, -time)

# omit all columns X:size using select().
select(cran, -(X:size))

# | Now that you know how to select a subset of columns using select(), a natural
# | next question is "How do I select a subset of rows?" That's where the filter()
# | function comes in.
# | Use filter(cran, package == "swirl") to select all rows for which the package
# | variable is equal to "swirl". Be sure to use two equals signs side-by-side!
filter(cran, package == "swirl")

# | You can specify as many conditions as you want, separated by commas. For
# | example filter(cran, r_version == "3.1.1", country == "US") will return all
# | rows of cran corresponding to downloads from users in the US running R version
# | 3.1.1.
filter(cran, r_version == "3.1.1", country == "US")

# | Edit your previous call to filter() to instead return rows corresponding to
# | users in "IN" (India) running an R version that is less than or equal to
# | "3.0.2"
filter(cran, r_version <= "3.0.2", country == "IN")

# | Our last two calls to filter() requested all rows for which some condition AND
# | another condition were TRUE. We can also request rows for which EITHER one
# | condition OR another condition are TRUE. For example, 
# filter(cran, country == "US" | country == "IN") 
# will gives us all rows for which the country variable equals either "US" or "IN". Give it a go.
filter(cran, country == "US" | country == "IN") 

# | Now, use filter() to fetch all rows for which size is strictly greater than (>)
# | 100500 (no quotes, since size is numeric) AND r_os equals "linux-gnu". Hint:
# | You are passing three arguments to filter(): the name of the dataset, the first
# | condition, and the second condition.
filter(cran, size>100500, r_os == "linux-gnu")

# | Finally, we want to get only the rows for which the r_version is not missing. R
# | represents missing values with NA and these missing values can be detected
# | using the is.na() function.
filter(cran, !is.na(r_version)) 

# | Sometimes we want to order the rows of a dataset according to the values of a
# | particular variable. This is the job of arrange().
# | To see how arrange() works, let's first take a subset of cran. select() all
# | columns from size through ip_id and store the result in cran2.
cran2 <- select(cran, size:ip_id)

# | Now, to order the ROWS of cran2 so that ip_id is in ascending order (from small
# | to large), type arrange(cran2, ip_id). You may want to make your console wide
# | enough so that you can see ip_id, which is the last column.
arrange(cran2, ip_id)

# | To do the same, but in descending order, change the second argument to
# | desc(ip_id), where desc() stands for 'descending'.
arrange(cran2, desc(ip_id))

# | We can also arrange the data according to the values of multiple variables. For
# | example, arrange(cran2, package, ip_id) will first arrange by package names
# | (ascending alphabetically), then by ip_id. This means that if there are
# | multiple rows with the same value for package, they will be sorted by ip_id
# | (ascending numerically). 
arrange(cran2, package, ip_id)

# | Arrange cran2 by the following three variables, in this order: country
# | (ascending), r_version (descending), and ip_id (ascending).
arrange(cran2, country, desc(r_version), ip_id)

# | To illustrate the next major function in dplyr, let's take another subset of
# | our original data. Use select() to grab 3 columns from cran -- ip_id, package,
# | and size (in that order) -- and store the result in a new variable called
# | cran3.
cran3 <- select(cran, ip_id, package, size)
cran3

# | It's common to create a new variable based on the value of one or more
# | variables already in a dataset. The mutate() function does exactly this.
# | The size variable represents the download size in bytes, which are units of
# | computer memory. These days, megabytes (MB) are a more common unit of
# | measurement. One megabyte is equal to 2^20 bytes.
# | We want to add a column called size_mb that contains the download size in
# | megabytes. Here's the code to do it: mutate(cran3, size_mb = size / 2^20)
mutate(cran3, size_mb = size / 2^20)

# | An even larger unit of memory is a gigabyte (GB), which equals 2^10 megabytes.
# | We might as well add another column for download size in gigabytes!
# | One very nice feature of mutate() is that you can use the value computed for
# | your second column (size_mb) to create a third column, all in the same line of
# | code. To see this in action, repeat the exact same command as above, except add
# | a third argument creating a column that is named size_gb and equal to size_mb /
# | 2^10.
mutate(cran3, size_mb = size / 2^20, size_gb = size_mb / 2^10)

# | Let's try one more for practice. Pretend we discovered a glitch in the system
# | that provided the original values for the size variable. All of the values in
# | cran3 are 1000 bytes less than they should be. Using cran3, create just one new
# | column called correct_size that contains the correct size.
mutate(cran3, correct_size = size + 1000)

# | The last of the five core dplyr verbs, summarize(), collapses the dataset to a
# | single row. Let's say we're interested in knowing the average download size.
# | summarize(cran, avg_bytes = mean(size)) will yield the mean value of the size
# | variable. Here we've chosen to label the result 'avg_bytes', but we could have
# | named it anything.
summarize(cran, avg_bytes = mean(size))

# | That's not particularly interesting. summarize() is most useful when working
# | with data that has been grouped by the values of a particular variable.
# | We'll look at grouped data in the next lesson, but the idea is that summarize()
# | can give you the requested value FOR EACH group in your dataset.

# | In this lesson, you learned how to manipulate data using dplyr's five main
# | functions. In the next lesson, we'll look at how to take advantage of some
# | other useful features of dplyr to make your life as a data analyst much easier.





# You can exit swirl and return to the R prompt (>) at any time by pressing the
# Esc key. If you are already at the prompt, type bye() to exit and save your
# progress. When you exit properly, you'll see a short message letting you know
# you've done so.
#
# When you are at the R prompt (>):
# -- Typing skip() allows you to skip the current question.
# -- Typing play() lets you experiment with R on your own; swirl will ignore what you do...
#    - UNTIL you type nxt() which will regain swirl's attention.
# -- Typing bye() causes swirl to exit. Your progress will be saved.
# -- Typing main() returns you to swirl's main menu.
# -- Typing info() displays these options again.


# follow the menus and select the R Programming course when given the option. For the first part of this course you should complete the following lessons:

# Basic Building Blocks
# Workspace and Files
# Sequences of Numbers
# Vectors
# Missing Values
# Subsetting Vectors
# Matrices and Data Frames
# 

# If you need help...
# * Visit the Frequently Asked Questions (FAQ) page at https://github.com/swirldev/swirl/wiki/Coursera-FAQ
# to see if you can answer your own question immediately.
# 
# * Search the Discussion Forums this course.
# 
# * If you still can't find an answer to your question, then create a new thread under the swirl Programming Assignment sub-forum and provide the following information:
# -- A descriptive title
# -- Any input/output from the console (copy & paste) or a screenshot
# -- The output from sessionInfo()
# 
# Good luck and have fun!
# 
# For more information on swirl, visit http://swirlstats.com/ 
# 


# How to submit
# Copy the token below and run the submission script included in the assignment download. 
# When prompted:
# 
# * use your email address gvca80-coursera@yahoo.com
# 
# * and tokens:
# -- swirl Week3/Lesson 1 (swirl#1): Manipulating Data with dplyr : gUxfJGiXWHw1Fjl7
# -- swirl Week3/Lesson 2 (swirl#2): Grouping and Chaining with dplyr : 
# -- swirl Week3/Lesson 3 (swirl#3): Tidying Data with tidyr : 
# -- swirl Week4/Lesson 1 (swirl#4): Dates and Times with lubridate : 
# 
# Your submission token is unique to you and shou0ld not be shared with anyone. 
# You may submit as many times as you like.
#
# create a random mix of NA and samples from a normal distribution 
# by creating 1000 samples of each and then taking 100 random samples from each:
#   y <- rnorm(1000) #vector of 1000 samples drawn from normal distribution
#   z <- rep(NA, 1000) #vector of 1000 NA
#   my_data <- sample(c(y,z),100) # 100 random samples drown from union(y,z)

