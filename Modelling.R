# Modeling in R

# Linear Regression
# Subset only the numerical variables of the data
iris.num <- subset(iris, select = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"))

# correlation between variables
cor(iris.num) 

# Simple plot of the data
plot(iris.num)

# Fit regression model with one explanatory variable
iris.lr <- lm(Sepal.Length ~ Petal.Length,   data=iris.num)

# Summary of the model 
summary(iris.lr) 

# Linear regression multiple explanatory variables
iris.lr2 <- lm(Sepal.Length ~ Petal.Length + Sepal.Width + Petal.Width, data=iris.num)

# Print regression coefficients
summary(iris.lr2)
plot(iris.lr2)    # plot results

# Model accuracy evaluation
# Residual sum of squares
rss <- c(crossprod(iris.lr$residuals))

# Mean squared error
mse <- rss / length(iris.lr$residuals)

# Root Mean Squared Error
rmse <- sqrt(mse)

# Logistic Regression
# Load data set
data(GermanCredit)

# Load data set
log_model <- glm(Class ~ Age + ForeignWorker + Property.RealEstate 
                 + Housing.Own + CreditHistory.Critical, 
                 data=GermanCredit, family="binomial")

# Summary of model coefficients
summary(log_model)

# Test diagnostics
anova(log_model, test = "Chisq")

# Load caret library
library(caret)

# Partition data so that 60% is used for training
train <- createDataPartition(GermanCredit$Class, p=0.6, list=FALSE)

# Separate data into training and testing 
training <- GermanCredit[ train, ]
testing <- GermanCredit[ -train, ]

# Fit the model using the training data set
car_model <- train(Class ~ Age + ForeignWorker + Property.RealEstate + Housing.Own + CreditHistory.Critical,  data=training, method="glm", family="binomial")

# Predict Good / Bad
predict(car_model, newdata=testing)

# Predict probability of Good / Bad to occur
predict(car_model, newdata=testing, type="prob")

# K-means clustering
# Select the petal length and width as the features to base the clustering on 
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)

# Comparison between the clusters and the actual species
table(irisCluster$cluster, iris$Species)

# Change resulting clusters to factors for easier plotting
irisCluster$cluster <- as.factor(irisCluster$cluster)

# Plot the clustering results using ggplot
ggplot(iris, aes(Petal.Length, Petal.Width, color = irisCluster$cluster)) + geom_point()

