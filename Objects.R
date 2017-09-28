# Objects

# numeric object
x <- 15 

# Vectors
a <- c(1,2,5.3,6,-2,4)                     # numeric vector
b <- c("cat","dog","parrot")               # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)    # logical vector

# Matrices
y <- matrix(1:12, nrow=3,ncol=4)

# Lists
mylist <- list(name="Rosie", mynumbers=a, mymatrix=y, age=5.3)
mylist

# Concatenate lists
lists <- c(list.a, list.b, list.c)

# Data frames
data("iris")
iris <- read.table("iris")           # Read data from a table
iris <- read.csv("~/data/iris.csv",  # Read data from a csv file on your local machine
                  header = True)
head(iris)    # check the first 6 rows of data in the data frame

# Summarize the data set
str(iris)

# Accessing a column - multiple ways 
iris$Species    
iris[["Species"]]
iris[5]
iris[, 2]

# Number indexing
# Accessing a row
iris[2,] 

nrow(iris)     # number of rows in data set
ncol(iris)     # number of columns in data set

# Access column 3
iris[3]

# Access row 1 and column 4
iris[1,4]  

# Get rows 1 to 3 and all columns  
iris[1:3, ]

# Get only rows 3 and 9 and all columns
iris[c(3,9), ]

# Name indexing
# Get a column by name
iris["Sepal.Length"]

# Get rows by name
iris["10",]
iris[c("10","119"),]

# Logical indexing
# In the setosa vector, the member value is TRUE if value in column “Species” is equal to “setosa” 
setosa = iris$Species == "setosa"
iris[setosa,]

# Subsetting
# Subset data based on columns
myvars <- c("Sepal.Length","Sepal.Width")
newiris <- iris[myvars]

# Excluding columns from data by name
myvars <- names(iris) %in% 
  c("Sepal.Length","Sepal.Width")
newiris <- iris[!myvars]

# Exclude columns by number 
newiris <- iris[c(-1,-3)]

# Subsetting data based on rows
newiris <- iris[1:10,]

# Subsetting based on conditions within columns
newiris <- iris[ 
  which(iris$Sepal.Width >= 4 
        & iris$Species == "setosa"), ]

# Using the subset function to subset based on column conditions
newiris <- subset(
  iris, Sepal.Width < 2 | 
    Sepal.Width > 3, 
  select=c(Sepal.Length, Species))

#Challenge: How will you subset columns 1, and 3 to 5?
iris[,c(1, 3:5)]

# Missing Values
# Testing data frame for missing value
is.na(iris)

# Replace sepal length lower than 5 with NA
iris$Sepal.Length[iris$Sepal.Length < 5] <- NA
  
# List cases with missing values
iris[complete.cases(iris),]

# Create new data set excluding the missing values
newiris <- na.omit(iris)

# Date values
# Check the class(type of values in a column)
class(iris$Sepal.Width)

# Use as.Date() to convert string to dates
dates <- as.Date(c("2007-06-22", "2004-02-13"))

# The same function can be applied to a column in the data frame. 
df <- data.frame(time=c("2014-05-10","2015-03-23","2015-07-12","2016-02-17"),
                 precip=c(8,9,6,7))

# Change the dates in the appropriate format
df$time <- as.Date(df$time, format = "%Y-%m-%d")
