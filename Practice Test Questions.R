## PRACTICE TEST 1

# QUESTION 1
# Load the data
boston <- read.csv('boston copy.csv')

# QUESTION 2
# The categorical variables are Town, TRACT, CHAS, RAD

# QUESTION 3
# Describe the data
str(boston)

# QUESTION 4
# Calculate the mean crime rate
bh_means <- mean(bh$CRIM, na.rm = TRUE)  #3.596249

# Replace NAs with the mean crime rate
boston$CRIM[is.na(boston$CRIM)] <- bh_means


# QUESTION 5
bintax <- function(v){
  u <- numeric(length(v))
  for (i in 1:length(v)){
    if (v[i]<200) u[i]<-0 else if (v[i]<300) u[i] <- 1 else if (v[i]<400) u[i] <- 2 else if (v[i]<500) u[i] <- 3 else u[i] <- 4
  }
  return(u)
}

boston$TAXBIN <- bintax(boston$TAX)


# QUESTION 6

boston_rad=sqldf('select RAD, count(1) CNT, avg(CRIM) CRIM_AVG, max(CRIM) CRIM_MAX, min(CRIM) CRIM_MIN
                 from boston 
                 where CRIM is not null 
                 group by 1 
                 order by 3 desc')

boston2=sqldf('select a.*, B.CRIM_AVG RAD_CRIM_AVG, CRIM/B.CRIM_AVG CRIM_RAD_RATIO 
              from boston a left outer join boston_rad b  on 
              a.rad=b.rad')



## PRACTICE TEST 2

# QUESTION 12
m <- cor(boston[c(3,4,5,6,7,8,10,11,12,13,15,16)])
m
corrplot(m, method="color")
# Most positively correlated with TAX and negatively correlated with MEDV

# QUESTION 13
# Load the caret library
library(caret)

# Partition data randomly so that 70% is used for training
train <- createDataPartition(bh$CRIM , p=0.7, list=FALSE)

# Separate data into training and testing 
training <- bh[ train, ]
testing <- bh[ -train, ]

# Select some predictor variables
expl_vars <- c("RM", "TAX", "ZN", "MEDV", "INDUS", "NOX", "AGE", "DIS")
expl_vars <- training[expl_vars]

# QUESTION 14
# Linear regression model using training data
lr <-train(x = expl_vars, y = training$CRIM, method = "lm", 
           trControl = trainControl(method = "cv"))

# Use the predict function along with the lr model
lr_pred <- predict(lr, testing)

# Check the summary of new prediction model
new_modvalues <- data.frame(obs = testing$CRIM, pred = lr_pred)
defaultSummary(new_modvalues)

# QUESTION 15
# prot the predicted against the observed values
xyplot(new_modvalues$obs ~ new_modvalues$pred,
       type = c("p", "g"),
       xlab = "Predicted", ylab = "Observed")

