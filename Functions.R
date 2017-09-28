################### IF ELSE ##########################
# One line example
n <- 3
if (n%%2==0) print("Even") else print("Odd")

# More complex Example
x <- c(2,7,1,6,9)
if (length(x)%%2==0) {
  med=(sort(x)[length(x)/2]+sort(x)[1+length(x)/2])/2 
} else {
  med=sort(x)[ceiling(length(x)/2)]
}

# Nested if else statement
client = 'public'
net.price = 100

if(client=='private'){
  tot.price <- net.price * 1.12      # 12% VAT
} else {
  if(client=='public'){
    tot.price <- net.price * 1.06    # 6% VAT
  } else {
    tot.price <- net.price * 1    # 0% VAT
  }
}
tot.price

# Using else if instead
if(client=='private'){
  tot.price <- net.price * 1.12
} else if(client=='public'){
  tot.price <- net.price * 1.06
} else {
  tot.price <- net.price
}
tot.price
################### FOR LOOPS ########################
# BASIC FOR LOOP
x <- 1:10
y <- numeric(10)
for (i in 1:length(x)) y[i] <- x[i]^2


# NESTED FOR LOOP
mymat <- matrix(nrow=30, ncol=30) # Create a 30 x 30 matrix (of 30 rows and 30 columns)
mymat[1:10, 1:10]

# For each row and for each column, assign values based on position: product of two indexes
for(i in 1:dim(mymat)[1]) {
  for(j in 1:dim(mymat)[2]) {
    mymat[i,j] = i*j
  }
}

mymat[1:10, 1:10]


# For loops work well when we know the number of iterations, otherwise we can use while or repeat loops

# Define a dummy function for this example
readinteger <- function(){
  n <- readline(prompt="Please, enter your ANSWER: ")
}
response <- as.integer(readinteger())

# While loop keeps going until the response is 42
while (response!=42) {   
  print("Sorry, the answer to whatever the question MUST be 42");
  response <- as.integer(readinteger());
}

# Repeat does the same thing but uses an if condition and break to stop the iterations
repeat{
  response <- as.integer(readinteger());
  if (response == 42){
    print("Well Done!");
    break
  } else print("Sorry, the answer to whatever the question MUST be 42");
  
}

################### FUNCTIONS ########################
# SIMPLE FUNCTION WITH NO ARGUMENTS
foo <- function() print("bar")
foo()

# CALCULATING THE MEDIAN
x <- c(2,7,1,6,9)
med <- function(x){odd=length(x)%%2
if (odd==0) {
  med <- (sort(x)[length(x)/2]+sort(x)[1+length(x)/2])/2 
} else {
  med <- sort(x)[ceiling(length(x)/2)]
}
return(med)
}
med(x)

# RICKER FUNCTION (DEFAULT VALUES USED)
ricker <- function(nzero, r, K=1, time=100, from=0, to=time){
  N <- numeric(time+1)
  N[1] <- nzero
  for (i in 1:time) N[i+1] <- N[i]*exp(r*(1-N[i]/K))
  Time <- 0:time
  plot(Time, N, type="l", xlim=c(from, to))
  
}
ricker(0.1, 1); title("r=1")
ricker(0.1, 2); title("r=2")
ricker(0.1, 3); title("r=3")

# 


