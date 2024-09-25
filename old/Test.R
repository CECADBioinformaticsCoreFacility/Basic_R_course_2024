library(dplyr)
library(openxlsx)
library(ggplot2)

# Filter Demo
iris |> 
  filter(Sepal.Length > 5) |>
  head()


# xlsx read/write
demolist <- list("IRIS" = iris, 
                 "MTCATS" = mtcars, 
                 "MATRIX"=matrix(runif(100), ncol = 5)
                 )

write.xlsx(demolist, "writeList1.xlsx", colWidths = c(NA, "auto", "auto"))

read.xlsx("writeList1.xlsx",3)

#========
# DAY 2 #
# =======

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
# cor(iris[,1:4])
# library(corrplot)
# corrplot(cor(iris[,1:4]),
#   method = "number",
#   type = "upper" # show only upper side
# )
# ---------------------------------
# 
# Correlation Test
cor.test(iris$Sepal.Length,iris$Sepal.Width)


# barplot
ggplot(demo_data) +
  aes(x = Species, fill = size) +
  geom_bar()

# Chi-square test in R
chisq.test(table(demo_data$Species, demo_data$size),correct=FALSE)

summary(table(demo_data$Species, demo_data$size))



# Fisher’s Exact Test in R
demo_data <- data.frame(
  "NonSmoker" = c(7, 1),
  "Smoker" = c(3, 9),
  row.names = c("Athlete", "NonAthlete"),
  stringsAsFactors = FALSE
)

demo_data

mosaicplot(demo_data,
           main = "Mosaic plot",
           color = TRUE
)

fisher.test(demo_data)
