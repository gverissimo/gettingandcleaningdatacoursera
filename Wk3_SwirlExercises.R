
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
# -- swirl Week3/Lesson 2 (swirl#2): Grouping and Chaining with dplyr : 7hDXAhs43ZVp2JNq
# -- swirl Week3/Lesson 3 (swirl#3): Tidying Data with tidyr : OYjTp8U3IMBSUBIY
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



students3_ <- data.frame(chr:"name", chr:"test", chr"class1", "class2", "class3", "class4", "class5")
students3_
rbind(students3_, c("Sally", "midterm", "A", NA, "B", NA, NA))
rbind(students3_, c("Sally", "final", "C", NA, "C", NA, NA))
rbind(students3_, c("Jeff", "midterm", NA, "D", NA, "A", NA))
rbind(students3_, c("Jeff", "final", NA, "E", NA, "C", NA))
rbind(students3_, c("Roger", "midterm", NA, "C", NA, NA, "B"))
rbind(students3_, c("Roger", "final", NA, "A", NA, NA, "A"))
rbind(students3_, c("Karen", "midterm", NA, NA, "C", "A", NA))
rbind(students3_, c("Karen", "final", NA, NA, "C", "A", NA))
rbind(students3_, c("Brian", "midterm", "B", NA, NA, NA, "A"))
rbind(students3_, c("Brian", "final", "B", NA, NA, NA, "C"))
students3_

name    test class1 class2 class3 class4 class5
1  Sally midterm      A   <NA>      B   <NA>   <NA>
        2  Sally   final      C   <NA>      C   <NA>   <NA>
        3   Jeff midterm   <NA>      D   <NA>      A   <NA>
        4   Jeff   final   <NA>      E   <NA>      C   <NA>
        5  Roger midterm   <NA>      C   <NA>   <NA>      B
6  Roger   final   <NA>      A   <NA>   <NA>      A
7  Karen midterm   <NA>   <NA>      C      A   <NA>
        8  Karen   final   <NA>   <NA>      C      A   <NA>
        9  Brian midterm      B   <NA>   <NA>   <NA>      A
10 Brian   final      B   <NA>   <NA>   <NA>      C

| You are doing so well!
        
        |=================================                                       |  45%
| In students3, we have midterm and final exam grades for five students, each of
| whom were enrolled in exactly two of five possible classes.

...

|==================================                                      |  47%
| The first variable, name, is already a column and should remain as it is. The
| headers of the last five columns, class1 through class5, are all different
| values of what should be a class variable. The values in the test column,
| midterm and final, should each be its own variable containing the respective
| grades for each student.

...

|===================================                                     |  49%
| This will require multiple steps, which we will build up gradually using %>%.
| Edit the R script, save it, then type submit() when you are ready. Type reset()
| to reset the script to its original state.

> submit()

| Sourcing your script...

name    test  class grade
1  Sally midterm class1     A
2  Sally   final class1     C
9  Brian midterm class1     B
10 Brian   final class1     B
13  Jeff midterm class2     D
14  Jeff   final class2     E
15 Roger midterm class2     C
16 Roger   final class2     A
21 Sally midterm class3     B
22 Sally   final class3     C
27 Karen midterm class3     C
28 Karen   final class3     C
33  Jeff midterm class4     A
34  Jeff   final class4     C
37 Karen midterm class4     A
38 Karen   final class4     A
45 Roger midterm class5     B
46 Roger   final class5     A
49 Brian midterm class5     A
50 Brian   final class5     C

| That's the answer I was looking for.

  |=====================================                                   |  51%
| The next step will require the use of spread(). Pull up the documentation for
| spread() now.

> ?spread

| Excellent work!

  |======================================                                  |  53%
| Edit the R script, then save it and type submit() when you are ready. Type
| reset() to reset the script to its original state.

> submit()

| Sourcing your script...

    name  class final midterm
1  Brian class1     B       B
2  Brian class5     C       A
3   Jeff class2     E       D
4   Jeff class4     C       A
5  Karen class3     C       C
6  Karen class4     A       A
7  Roger class2     A       C
8  Roger class5     A       B
9  Sally class1     C       A
10 Sally class3     C       B

| Keep up the great work!

  |=======================================                                 |  55%
| readr is required for certain data manipulations, such as `parse_number(),
| which will be used in the next question.  Let's, (re)load the package with
| library(readr).


