################### MISSING VALUES #####################
# LOAD DATA AND ADD MISSING VALUES TO WORK WITH
data <- airquality
data[4:10, 3] <- rep(NA,7)
data[1:5,4] <- NA

# CHECK PERCENTAGE OF MISSING DATA
for (i in 1:length(data)){
  print(colnames(data)[i])
  print(sum(is.na(data[,i]))/length(data[,i])*100)
}

# LOAD MICE LIBRARY AND DISPLAY MISSING ROW PATTERNS
library(mice)
md.pattern(data)

# LOAD VIM LIBRARY AND PLOT MISSING VALUES FOR DATA
library(VIM)
aggr_plot <- aggr(data, col=c('navyblue','red'), numbers=TRUE, sortVars=TRUE, labels=names(data), cex.axis=.7, gap=3, ylab=c("Histogram of missing data","Pattern"))

# MARGIN PLOT BETWEEN OZONE AND SOLAR.R
marginplot(data[c(1,2)])

# MEAN AND MEDIAN IMPUTATION FUNCTIONS
meanimpute <- function(x){
  x[is.na(x)] <- mean(x, na.rm=TRUE)  
  x
}

medianimpute <- function(x){
  x[is.na(x)] <- median(x, na.rm=TRUE)
  x
}

# IMPUTE VALUES IN THE DATAFRAME WITH NEW COLUMNS
data$OzoneMeanImp <- meanimpute(data$Ozone)
data$OzoneMedianImp <- medianimpute(data$Ozone)

# VISUALIZE THE DISTRIBUTIONS OF THE NEW OZONE FIGURES WITH IMPUTATION
library(gridExtra)
p1 <- ggplot(data,aes(Ozone)) + geom_density() + labs(title="Original distribution")
p2 <- ggplot(data, aes(OzoneMeanImp)) + geom_density() + labs(title="Mean Imputed Values")
p3 <- ggplot(data, aes(OzoneMedianImp)) + geom_density() + labs(title="Median Imputed Values")
grid.arrange(p1, p2, p3, ncol=1)


############## CORRELATIONS #########################
# IMPORT CORRPLOT LIBRARY
library(corrplot)

# CALCULATE THE CORRELATION MATRIX OF ALL MTCARS DATA
cor(mtcars)

# CALCULATING CORRELATION MATRIX OF SUBSET OF VARIABLES
cor(mtcars[c(1,2,4,6)])

# CORRELATION PLOT OF ALL DATA
corrplot(cor(mtcars), method="color")

# CORRELATION PLOT OF SUBSET OF DATA
corrplot(cor(mtcars[c(1,2,4,6)]), method="color")

# DIFFERENT PLOT METHODS
corrplot(cor(mtcars[c(1,2,4,6)]), method="circle")

