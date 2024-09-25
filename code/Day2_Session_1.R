#===================
# Day 2 : Session 1 #
#===================

library(dplyr)
library(openxlsx)
library(ggplot2)

# Contingency Tables
demo_data <- iris |>
  filter(Species == "versicolor" | Species == "virginica")
demo_data$Species <- droplevels(demo_data$Species)

demo_data$size <- ifelse(demo_data$Sepal.Length < median(demo_data$Sepal.Length),
                         "small", "big"
)
table(demo_data$Species, demo_data$size)


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
