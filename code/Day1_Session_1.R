#===================
# Day 1 : Session 1 #
#===================

# help functions
#---------------
?hist           # example of [package]
help(hist)
example(hist)
demo(graphics)
browseVignettes("grid")
vignette("rectangle", package = "tidyr")
search()
data()

# Variables
#------------
# This is a comment
name <- "John"    # This is also a comment
age <- 40
name

name <- "Tom"
print (name)

# Data Types
#-----------
x <- 10.5
x <- 1000L
x <- 9i + 3
x <- "R is exciting"
x <- TRUE
x<-charToRaw("abc")
# Evaluete data type
class(x)

# R Data Structure
#-----------------
# Create a vector.
alphabets <- c('a','b',"c","d")
# Print the vector.
print(alphabets)

# Create a list.
list1 <- list(c(2,5,3),21.3,sin)
# Print the list.
print(list1)

# Create a vector.
apple_colors <- c('green','green','yellow','red','red','red','green')
# Create a factor object.
factor_apple <- factor(apple_colors)
# Print the factor.
print(factor_apple)

# Create a matrix.
M = matrix( c('a','a','b','c','b','a'),
            nrow = 2,
            ncol = 3,
            byrow = TRUE)
# Print the matrix
print(M)
# Create an array.
a <- array(c('green','yellow'),dim = c(1,3,2))
# Print the array
print(a)

# Create the data frame.
BMI <-     data.frame(
  gender = c("Male", "Male","Female"),
  height = c(152, 171.5, 165),
  weight = c(81,93, 78),
  Age = c(42,38,26)
)
# Print the data frame
print(BMI)

# R - Decision making
#--------------------
# if statement
x <- 30L
if(is.integer(x)) {
  print("X is an Integer")
}

# if...else statement
x <- c("what","is","truth")
if("Truth" %in% x) {
  print("Truth is found")
} else {
  print("Truth is not found")
}

# switch statement
x <- switch(
  3,
  "first",
  "second",
  "third",
  "fourth"
)
print(x)

# R-Loops
#--------
#for loop
v <- LETTERS[1:4]
for ( i in v) {
  print(i)
}

#while Loop
v <- c("Hello","while loop")
cnt <- 2
while (cnt < 7) {
  print(v)
  cnt = cnt + 1
}

#repeat Loop
v <- c("Hello","loop")
cnt <- 2
repeat {
  print(v)
  cnt <- cnt+1
  if(cnt > 5) {
    break
  }
}

#next statement
v <- LETTERS[1:6]
for ( i in v) {
  if (i == "D") {
    next
  }
  print(i)
}

#break statement
v <- c("Hello","loop")
cnt <- 2
repeat {
  print(v)
  cnt <- cnt + 1
  if(cnt > 5) {
    break
  }
}



# R-Functions
#------------
myfun <- function(x) {
  y <- x * 10
  print(y)
}

val <- myfun(20)   # value got assigned and printed
val

myfun2 <- function(x) {
  x * 10

}

val2 <-myfun2(20) # value got assigned and did not get printed
val2

# R packages
#-----------

.libPaths() # library path

library()   # list of installed library

install.packages("ggplot2") # install from CRAN

install.packages(path_to_file, repos = NULL, type="source") # # install from Local

BiocManager::install("DESeq2") # install from bioconductor

