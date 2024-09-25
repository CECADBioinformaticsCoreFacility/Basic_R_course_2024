#===================
# Day 1 : Session 4 #
#===================
library(ggplot2)
data("iris")

min(iris$Sepal.Length)
max(iris$Sepal.Length)
range(iris$Sepal.Length)

mean(iris$Sepal.Length)
median(iris$Sepal.Length)
table(iris$Sepal.Length) |>
  sort(decreasing = TRUE)

quantile(iris$Sepal.Length, 0.25) # first quartile
quantile(iris$Sepal.Length, 0.75) # third quartile
IQR(iris$Sepal.Length) # interquartile range

summary(iris)

sd(iris$Sepal.Length) # standard deviation

var(iris$Sepal.Length) # variance


# Contingency Tables
demo_data <- iris |>
  filter(Species == "versicolor" | Species == "virginica")
demo_data$Species <- droplevels(demo_data$Species)

demo_data$size <- ifelse(demo_data$Sepal.Length < median(demo_data$Sepal.Length),
                         "small", "big"
)
table(demo_data$Species, demo_data$size)

# Contingency Tables : mosaicplot
mosaicplot(table(demo_data$Species, demo_data$size),
           color = TRUE,
           xlab = "Species", # label for x-axis
           ylab = "Size" # label for y-axis
)

# Correlation
cor(iris$Sepal.Length,iris$Sepal.Width, method = "pearson")

cor(iris$Sepal.Length,iris$Sepal.Width, method = "spearman")

#-------------------------------------
cor(iris[,1:4])
library(corrplot)
corrplot(cor(iris[,1:4]),
  method = "number",
  type = "upper" # show only upper side
)
# ---------------------------------
#
# Correlation Test
cor.test(iris$Sepal.Length,iris$Sepal.Width)



