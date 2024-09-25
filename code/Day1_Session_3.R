#===================
# Day 1 : Session 3 #
#===================

# The Iris Dataset:
# This built-in dataset is often used for demonstration purposes:
data("iris")
# Have a look:
head(iris)

# How To Draw a Scatterplot
# Here, we plot Petal.Length against Sepal.Length.
# The plot() function expects vectors (individual data columns):

plot(x=iris$Petal.Length,
     y=iris$Sepal.Length,
     pch=19, # symbol = bullet
     col=2 # color = red
)
# Default color indices:
# black=1, red=2, green=3

# Simpler notation:
#with(iris,
#     plot(Sepal.Length,
#          Petal.Length
#     )
#)

# Put a grid:
grid()

# Annotating Points

# In an interactive session, points can be labelled by mouse clicks and their vector indices returned. This can be very useful to identify exceptional points, but unfortunately it does not work inside the report. Interactively you would:
# - First draw the plot
# - Then call the identify() function with the x and y coordinates of the plot and
# -   quit the function by pressing the right mouse button
# -   Finally use the result to index into the data table:
plot(iris$Petal.Length,
     iris$Sepal.Length, pch=19,
     col=2)
my_points <-
  identify(x=iris$Petal.Length,
           y=iris$Sepal.Lengtth
  )
iris[my_points,]

# NOTE: If identify() and notably transparency do not work with your RStudio, ############
# you can use a temporary X11 window:
options(device = "X11") # change default graphics output
dev.new() # open a fresh X11 window
# do your plotting
dev.off() # close the X11 window
dev.cur() # Check where  you are now ...
# if the device is not "RStudioGD" again, try:
options(device = "RStudioGD")..
dev.new()
# .. anyway be careful not to mess up your rstudio plotting .. ############################


# Adding Elements To a Plot

# Base R graphics already subscribes to a concept which has been greatly expanded by the ggplot2 package: **plots are built up incrementally**.

# A plot is initialized when a graphics device is first opened (here, by calling the function plot()). Other functions can use an open graphics device to add more elements to the plot. We have already seen this above with the identify() function, which puts labels on the identified points.

# Adding Text
plot(iris$Petal.Length,
     iris$Sepal.Length,
     pch=19, col=2)

text(x=1.2,y=5.8,"outlier!",
     ## text should start
     ## exactly at (x,y)
     cex=2,adj=c(0,0)
)

# Adding Lines
# Lines are useful for highlighting positions or relationships in a plot. Base R's generic workhorse for lines is the abline() function. Depending on its arguments, it can

plot(iris$Petal.Length,
     iris$Sepal.Length,
     pch=19, col=2)
abline(v=c(2,4,6),col=c("blue","yellow","red"))

plot(iris$Petal.Length,
     iris$Sepal.Length,
     pch=19, col=2)
abline(a=4.2, b=0.5, col="blue", lwd=2)

# The lwd parameter sets line width. See ?par to learn more about the many **graphical parameters** which can modify the behaviour of base plotting functions. Call function colors() to see the common names of available colors.

# .. draw a Regression Line:

plot(iris$Petal.Length,
     iris$Sepal.Length,
     pch=19, col=2)
abline(lm(Sepal.Length ~ Petal.Length,
          iris),
       lwd=3)


# The lm() function computes a linear model of the relationship between x and y. We will have a closer look at it in the session on Inferential Statistics tommoroow. The point here is that abline() can take a model object and use it to draw a regression line.


# How To Draw a Line Graph

# Scatterplots visualize the distribution of points in the (x,y) plane. We may also ask how the observations of a variable change when we simply read along the respective table column from top to bottom. In this case, the y axis of the plot would be the variable's value, and the x axis would the index (the table row we are looking at). Because we are interested in the change of y with changing y, it makes sense to connect the y values by a line.

plot(1:length(iris$Sepal.Length),
     iris$Sepal.Length, col=3,
     type = 'l')


# More Additions: Adding Entire Plots
# Behind the scenes, plot() opens a graphics device and set up the coordinate system as specified by its parameters. An  internal function plot.xy() then takes care of plotting the requested scatterplot or line graph on this canvas. It is possible to draw more than a single such graph on the the same canvas. However you can't use plot() again to do this, because the device is already set up. Instead there are two separate functions for overplotting over an existing plot: points() for scatterplots and lines() for line graphs. These functions skip the setup part and call plot.xy() directly.

# Note: now x is an index (row number)
plot(1:length(iris$Sepal.Length),
     iris$Sepal.Length, col=3,
     type = 'l')

# add a scatterplot to the graph
points(1:length(iris$Sepal.Length),
       iris$Sepal.Length,
       pch=19, col="yellow"
)

# add another line graph, now with reversed index order:
lines(length(iris$Sepal.Length):1,
      iris$Sepal.Length,
      col="lightblue",
      type = 'l')


# How To Draw a Histogram

# The hist() function takes a data vector and breaks the range of the data into a set of bins, by default computed by Sturges's rule (see https://en.wikipedia.org/wiki/Sturges%27s_rule).  By default, it plots the frequency (=the count) of data points in the individual bins. Setting argument probability=TRUE, it will instead plot the probability to observe a data point in a given  bin.

# Histograms may also be overplotted. Unlike with plot(), this can be done by the same hist() function, by setting parameter add=TRUE.

# Here, we want to draw histograms of Petal.Length and Sepal.Length on the same canvas. These histograms will partially overlap, and it is therefore desirable to use **transparent colors** if possible. Note that it **depends on the system setup (both R and computer) whether this is possible**. If it does not work on your system, just put plain "red" and "blue" instead of rgb(1, 0, 0, alpha=0.5) and rgb(1, 0, 0, alpha=0.5).


# First, we need to determine the total range of both data vectors to be compared:
rP <- range(iris$Petal.Length)
rS <- range(iris$Sepal.Length)

#We will use the ranges to set the xlim parameter of hist(). This parameter specifies the x range of the drawing canvas. This parameter is acceppted by many plotting functions. (For plot types in which it makes sense, like scatterplots and line graphs, there is an equivalent ylim parameter for the y range.)


hist(iris$Petal.Length,
     # 1=red, 2=green, 3="blue"
     #col=rgb(1, 0, 0,   ## use this if transparency does work on your system
     #        alpha=0.5),
     col="red",

     xlim=c(min(rP),max(rS)),
     xlab="Organ Length",
     main = "Organ Distributions"
)
hist(iris$Sepal.Length,add=TRUE,
     #col=rgb(0,0,1,
     #        alpha=0.5)
     col="blue"
)
legend("topright",
       legend=c("Petal", "Sepal"),
       #fill=c(rgb(1, 0, 0, alpha=0.5),
       #       rgb(0, 0, 1, alpha=0.5))
       fill=c("red",
              "blue")
)

#The legend() is another generic element which can be added to most base R plots. It is highly configurable, but somewhat cumbersome to use. See ?legend for more information..

# How To Draw a Boxplot

# We have seen in the histograms that the petal lengths do not seem to fall into a single smooth distribution. The histograms did not take the species into account, so it makes sense to ask whether the variability can be explained by species differences.

boxplot(Petal.Length ~ Species, data = iris, col=c(1:3))

# The call to boxplot() uses the **model notation** we have already seen with abline() above. In this case it does not refer to a model in the strict sense, but rather has the generic meaning **"use the left hand side as the dependent variable, and the right hand side as the independent variable"**. This generic meaning is **used in many contexts in R**, especially also by the **tidyverse** functions.

# In the boxplot context above, Species is given (independent), and we ask whether Petal.Length depends on it.


# How To Draw a Bar Chart

# The barplot() functions produces a plot which looks superficially like a histogram, but it does much less work. While hist() aggregates data points and displays the counts per bin as bars, barplot() simply visualizes its input in the form of bars. The input may be a simple vector or a matrix; if it is a matrix, then each row is treated as a separate data vector and is shown in a different color.


# pre-compute all data means of the 3 species
df <- aggregate(
  iris[,1:4],
  by = list(iris$Species),
  FUN = mean)
df

# A bar graph of Petal.Length by species only:
barplot(Petal.Length ~ Group.1,
        data = df,
        xlab = c('Species'),
        ylab = c('Petal Length'),
        col=c(1:3)
)

# To draw a bar graph of all means by species, we need to convert df to a matrix.
# I use a bit tidyverse notation to do this here, because it is really convenient.
m <- df |> tibble::column_to_rownames("Group.1") |> as.matrix()
m

# Now the bar graph:
barplot(m,
        xlab = c('Species'),
        beside = TRUE,
        ylab = c('Mean'),
        col=c(1:3),
        legend.text=rownames(m)
)


# How To Draw a Pie Chart
# Pie charts display information similar to histograms, especially to hist(probability=TRUE).
# They are often said to be more easily misleading than histograms. Anyway here is how they
# can be drawn:


pie(df$Petal.Length, labels =df$Group.1)
