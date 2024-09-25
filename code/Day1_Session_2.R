#===================
# Day 1 : Session 2 #
#===================

# Data Import and Export
#-----------------------
library(openxlsx)
demolist <- list("IRIS" = iris,
                 "MTCATS" = mtcars,
                 "MATRIX"=matrix(runif(100), ncol = 5)
)

demolist
write.xlsx(demolist, 'writeList1.xlsx', sheetName = c('IRIS','MTCATS','MATRIX'), rowNames=FALSE)
read.xlsx("writeList1.xlsx",2)   # read the 2nd sheet from the xls file

write.csv(demolist[[1]],'writeCSV.csv', row.names = FALSE)
read.csv('writeCSV.csv')

subset(iris, Sepal.Length > 5 | Sepal.Width > 3.5, select=c(Petal.Width, Species))


# Data reshaping
#---------------

# Create vector objects.
address <- data.frame(
  city = c("Cologne","Frankfurt","Ulm","Mainz"),
  state = c("NRW","Hesse","BW","RLP")
)
# Create vector
zipcode <- c(33602,98104,06161,80294)
# Create another data frame with similar columns
new.address <- data.frame(
  city = c("Lowry"),
  state = c("CO"),
  zipcode = c("80230")
)

# Combine above vector into one data frame.
address <- cbind(address,zipcode)
# Print the data frame.
print(address)

# Combine rows form both the data frames.
all.addresses <- rbind(address,new.address)
# Print the result.
print(all.addresses)


df1 <- data.frame(ID = c(1, 2, 3, 4),
                  Name = c("A", "B", "C", "D"),
                  Age = c(25, 30, 35, 40))

df2 <- data.frame(ID = c(2, 3, 4, 5),
                  Occupation = c("Engineer", "Teacher", "Doctor", "Lawyer"),
                  Salary = c(5000, 4000, 6000, 7000))

merge(df1, df2, by = "ID")               # inner join
merge(df1, df2, by = "ID", all.x = TRUE) # left join
merge(df1, df2, by = "ID", all.y = TRUE) # right join
merge(df1, df2, by = "ID", all = TRUE)   # full join




my.matrx <- matrix(c(1:5, 11:15, 21:25), nrow = 5, ncol = 3)
my.matrx

apply(my.matrx, 1, sum) # rows

apply(my.matrx, 2, sum) # columns

# Data Reshaping with dplyr
#--------------------------

library(dplyr)

iris |>
  filter(Sepal.Length > 5) |>
  select(Sepal.Length, Petal.Length, Species) |>
  mutate(SePa.Length=Sepal.Length+Petal.Length) |>
  arrange(desc(Sepal.Length)) |>
  group_by(Species) |>
  summarise(mean = mean(Petal.Length), n = n())


