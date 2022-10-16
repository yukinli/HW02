library(ggplot2)
library(tidyverse)
library(tidymodels)
library(corrplot)
library(ggthemes)
tidymodels_prefer()


url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data"
abalone <- read.table(url, sep = ",")
#My suggestion when reading datasets from the Web, is to always try to get a local copy of the data file in your machine (as long as you have enough free space to save it in your computer). To do this, you can use the function download.file() and specify the url address, and the name of the file that will be created in your computer. For instance, to save the abalone data file in your working directory, type the following commands directly on the R console:

# do NOT include this code in your Rmd file
# download it to your working directory
origin <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data'
destination <- 'abalone.data'
download.file(origin, destination)

abalone <- read.table("abalone.data", sep = ",")
# take a peek of first rows
head(abalone)
# take a peek of last rows
tail(abalone)
Age <- abalone$V9 + 1.5
abalone$Age<-Age
setNames(abalone,c("Sex","Length","Diameter","Height","Whole","Shucked","Viscera","Shell","Rings","Age"))

y <- abalone$Age # give n standard normal quantiles

set.seed(3435)

abalone_split <- initial_split(abalone, prop = 0.80)
abalone_train <- training(abalone_split)
abalone_test <- testing(abalone_split)


step_dummy(all_nominal_predictors())

Optionally, you could also specify a type "factor" for the variable sex since this is supposed to be in nominal scale (i.e. it is a categorical variable). Also note that the variable rings is supposed to be integers, therefore we can choose an integer vector for this column.

Look at the documentation of the function read.table() and try to read the abalone.data table in R. Find out which arguments you need to specify so that you pass your vectors column_names and column_types to read.table(). Read in the data as abalone, and then check its structure with str().

Now re-read abalone.data with the read.csv() function. Name this data as abalone2, and check its structure with str().

How would you read just the first 10 lines in abalone.data? Name this data as abalone10, and check its structure with str().

How would you skip the first 10 lines in abalone.data, in order to read the next 10 lines (lines 11-20)? Name this data as abalone20, and check its structure with str().

Read the documentation of read.table() about the argument colClasses. What happens when you specify the data-type of one or more columns as "NULL"?
  
  Use the following functions to start examining descriptive aspects about the abalone data frame:
  
  str()
summary()
head() and tail()
dim()
names()
colnames()
nrow()
ncol()
Use R functions to compute descriptive statistics, and confirm the following statistics. Your output does not have to be in the same format of the table below. The important thing is that you begin learning how to manipulate columns (or vectors) of a data.frame.