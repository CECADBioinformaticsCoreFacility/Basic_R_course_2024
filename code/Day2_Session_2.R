#===================
# Day 2 : Session 2 #
#===================
library(ggpubr)
library(dplyr)

# The Dataset to be explored:
load("../data/statistics_data.RData")
dataset

# Simply plotting income versus IQ, there is no structure at all:
ggplot(dataset, aes(x=income,
                    y=IQ)
) +
  geom_point(size=3) +
  theme_bw()

# Individually coloring by parental education or by schooling_decision shows a pattern:

ggplot(dataset, aes(x=income,
                    y=IQ,
                    color = parental_education)
) +
  geom_point(size=3) +
  scale_color_manual(values =  c(low="blue",
                                 high="yellow"
  )
  )+
  theme_bw() ## white background


ggplot(dataset, aes(x=income,
                    y=IQ,
                    color = schooling_decision)
) +
  geom_point(size=3) +
  scale_color_manual(values =  c(secondary="blue",
                                 highschool="yellow"
  )
  )+
  theme_bw() ## white background

## Coloring by both factors simultaneously,  it becomes obvious that this dataset falls into quite sharply separated groups:
ggplot(dataset,
       aes(x=income,
           y=IQ,
           color = group)
) +
  geom_point(size=3) +
  scale_color_manual(values =  c(`low|secondary`="lightblue",
                                 `low|highschool`="blue",
                                 `high|secondary`="orange",
                                 `high|highschool`="yellow")) +
  theme_bw() ## white background


# Recapitulation: Chi-squared test
## How many data points do we have in each group?
crosstab <- table(dataset$parental_education,
                  dataset$schooling_decision)

crosstab

## The table cells are quite uevenly populated ...

##     outer(x1,x2) returns a matrix:
##     x1[1] * x2[1] x1[1] * x2[2]
##     x1[2] * x2[1] x2[2] * x2[2]

outer(rowSums(crosstab),
      colSums(crosstab)
) / sum(crosstab)

## ... much more uneven than expected:
chisq.test(crosstab)

# Comparing Group Means: Concepts (see html)
# Comparing Group Means: Assumptions (see html)
# Comparing Group Means: Workflow (see html)

# Do the Assumptions Hold?
## Is IQ Normally Distributed?
## (!NOTE that the confidence band requires transparency to work!!)
ggqqplot(dataset,"IQ",
         facet.by="group",
         ylab = "IQ")

## The quantiles of the IQ distribution fall reasonably within the 95% confidence band, as they should (with the exception of high|highschool) at the extreme ends)
##The Q-Q plot gives a visual impression (and, via the confidence band, also a more rigorous check of the normality assumption). An alternative formal test for normality is Shapiro's test:

shapiro_results <- list()

for(this_group in levels(dataset$group)) {
  IQ_data <- dataset |>
    dplyr::filter(group == this_group) |>
    dplyr::pull(IQ)
  ## base R notation:
  ## IQ_data <- dataset$IQ[data$group == this_group]

  res <- shapiro.test(IQ_data)
  shapiro_results[["IQ"]][[this_group]] <- res
}

shapiro_results[["IQ"]][1:2]
shapiro_results[["IQ"]][3:4]

## Is Income Normally Distributed?
ggqqplot(dataset,"income",
         facet.by="group")

         for(this_group in levels(dataset$group)) {
           income_data <- dataset |>
             dplyr::filter(group == this_group) |>
             dplyr::pull(income)
           ## base R notation:
           ## income_data <- dataset$income[data$group == this_group]

           res <- shapiro.test(income_data)
           shapiro_results[["income"]][[this_group]] <- res
         }
         shapiro_results[["income"]][1:2]
         shapiro_results[["income"]][3:4]

         ## Are the Variances of IQ and of Income the Same in All Groups?

         ##Levene's test can be used to check the "equal variance" assumption:

         car::leveneTest(y = IQ ~ group, data = dataset)
         car::leveneTest(y = income ~ group, data = dataset)

         ## The results clearly show that the **assumption of equal variances does not hold**.

         # Pairwise Equality of Means Tests
         ##First we construct a matrix, in which each column contains the group names of one of the pairwise comparisons we want to make:
         ## function combn  creates all subsets of a set
         comparisons <- combn(
           levels(dataset$group), ## the set to choose from
           2 ## we want subsets of size 2
         )
         ## construct column  names for the resulting matrix:
         colnames(comparisons) <-
           apply(comparisons,
                 2, ## traverse by column

                 function(x) {
                   ## x takes the value of the current column

                   ## construct and return the name
                   paste0(x[1],"_vs_",x[2])
                 }
           )
         ##This is how it looks like:
         comparisons

         ##Next we traverse the matrix column-wise, using the `apply` function. This function takes 3 parameters:
         ##1.   a matrix
         ##2.   whether it should take one row at a time (1) or one column at a time (2)
         ##3.   a function to apply to each row or column in turn

         ##Here, we give it our own hand-crafted function as the third argument. It
         ##-     extract the IQ values of the two groups to be compared into variables IQ_1 and IQ_2
         ##-     calls function `t.test` to compare these two IQ distributions
         ##Note that parameter `var.equal=FALSE` tells `t.test` that it should do a **Welch's t-test**, which does not assume equal variance in the two groups.
         t_results_IQ <-
           apply(comparisons, ## a matrix, where each column
                 ## holds the names of the two
                 ## groups to be compared
                 2, ## traverse by column
                 function(this_cmp) {
                   IQ_1 <- dataset |> filter(group == this_cmp[1]) |> pull(IQ)
                   IQ_2 <- dataset |> filter(group == this_cmp[2]) |> pull(IQ)
                   t.test(
                     x = IQ_1,
                     y = IQ_2,
                     var.equal=FALSE
                   )
                 })

         ## Same for IQ:
         t_results_income <-
           apply(comparisons, ## a matrix, where each column
                 ## holds the names of the two
                 ## groups to be compared
                 2, ## traverse by column
                 function(this_cmp) {
                   income_1 <- dataset |> filter(group == this_cmp[1]) |> pull(income)
                   income_2 <- dataset |> filter(group == this_cmp[2]) |> pull(income)
                   t.test(
                     x = income_1,
                     y = income_2,
                     var.equal=FALSE
                   )
                 })

         ##Here are the results for IQ:

         t_results_IQ[1]
         t_results_IQ[2]
         t_results_IQ[3]
         t_results_IQ[4]
         t_results_IQ[5]
         t_results_IQ[6]

         ## **Comparisons involving different school types are highly significant as expected**, because the schooling_decision had been based on the IQ value to a large part.


         ##Same for income:

         t_results_income[1]
         t_results_income[2]
         t_results_income[3]
         t_results_income[4]
         t_results_income[5]
         t_results_income[6]

         ## As expected, **any comparison involving highly versus lowly educated parents is highly significant**, because education has a large influence on income.


         # Pairwise Tests with ggboxplot (IQ)
         ##The textual output of `t.test` is not very self-explanatory. Function `ggboxplot` of the `ggpubr` package runs `t.test` internally and uses the results to annotate a boxplot of the per-group distributions of the variable which had been input to `t.test`:
         ggboxplot(dataset, x = "group", y = "IQ",

                   color = "group", palette = c("lightblue", "blue","orange", "yellow"),
                   order = levels(dataset$group),
                   ylab = "IQ", xlab = "group") +

           stat_compare_means(method = "t.test",
                              method.args = list(var.equal = FALSE),
                              ## The "comparisons" argument expects a list consisting
                              ## of vectors of length 2, i.e.
                              ## a list of the columns of our "comparisons" matrix.
                              ## Trick to do the conversion:
                              ## First convert the matrix to a data.frame, which is implicitly a list,
                              ## then convert the data.frame to an explicit list:
                              comparisons = comparisons|> as.data.frame() |> as.list()
           )

         ##The visual representation makes the points noted above more clear:
         ##- in comparisons involving different schooling decisions, IQ differs with high significance
         ##
         ##- in the two comparisons with the same schooling decision but different parental_education values
         ##    + the IQ differences are generally much smaller
         ##    + the difference is nevertheless significant for parents with low education


         ##Same for income:
         ggboxplot(dataset, x = "group", y = "income",

                   color = "group", palette = c("lightblue", "blue","orange", "yellow"),
                   order = levels(dataset$group),
                   ylab = "income", xlab = "group") +

           stat_compare_means(method = "t.test",
                              method.args = list(var.equal = FALSE),
                              ## The "comparisons" argument expects a list consisting
                              ## of vectors of length 2, i.e.
                              ## a list of the columns of our "comparisons" matrix.
                              ## Trick to do the conversion:
                              ## First convert the matrix to a data.frame, which is implicitly a list,
                              ## then convert the data.frame to an explicit list:
                              comparisons = comparisons|> as.data.frame() |> as.list()
           )


         # Preparing to Compare IQ to IQ_after_1y
         ## Next **we will do a paired t-test**, comparing the originally measured IQ value to the value measured after one year at the school chosen by the parents.

         ##The `t.test` function compares two vectors, so our original dataset would be structured OK for running the test on the columns IQ and IQ_after_1y, which are already in two different columns in our dataset.

         ##However, the `ggboxplot` expects a single data vector plus a second vector identifying the groups to be compared. This gives us the chance to do some **data wrangling**!

         ### Transformation (1)

         ##The values of columns IQ and the IQ_after_1y will be merged in the **data vector**.
         ##A **grouping vector** will hold the name of each value's column of origin:

         ## Rearrange the data table:
         data_long <- dataset |>
           tidyr::pivot_longer(cols = c(IQ,IQ_after_1y),
                               names_to = "measurement",
                               values_to = "IQ_value")


         head(data_long, n=4)

         ### Transformation (2)
         ##**The column of origin is not enough if we want to trace each value back to the "group" column it belonged to**. A simple solution is to prepend the group names to the measurement values:

         data_long <- data_long |>
           mutate(measurement =
                    paste(group,
                          measurement,sep="_"))

         head(data_long)

         ### Transformation (3)
         ##Next we make the new "measurement" column a factor, with a defined order of levels:

         data_long <- data_long |>
           mutate(measurement =
                    factor(measurement, # set factor levels
                           levels=
                             c("low|secondary_IQ","low|secondary_IQ_after_1y",
                               "low|highschool_IQ","low|highschool_IQ_after_1y",
                               "high|secondary_IQ","high|secondary_IQ_after_1y" ,
                               "high|highschool_IQ","high|highschool_IQ_after_1y"
                             )
                    ))

         ### Transformation (4)
         ##**We want to compare "IQ"s and "IQ_after_1y"s within each group, but so far coloring is solely by group, not by time point**. Here we append a "4" to the colors of "IQ_after_1y" values, which makes them a bit darker.

         data_long <-
           data_long |> mutate(plot_color=
                                 if_else(grepl("_after_1y$",
                                               measurement),
                                         paste0(plot_color,"4"),
                                         plot_color)
           )

         # same in base R (a little bit simpler):
         # data_long$plot_color <- ifelse(grepl("_after_1y$",
         #                                      measurement
         #                                      ),
         #                                paste0(data$plot_color,"4"),
         #                                data$plot_color)

         data_long

         ##Finally we make a color palette for the ggboxplot, associating colors (a vector) with the corresponding levels of the "measurements" factor:

         ## find the unique pairings of  (a) "plot_color" and (b) a "measurement" level --
         ## In base R:
         d <- unique(data_long[,c("plot_color","measurement")])
         ## make (b) the vector element names of (a)
         colors_long <- setNames(d$plot_color,d$measurement)

         ## In tidyverse style .. more complex:
         colors_long <- (data_long |>
                           select(plot_color,measurement) |>
                           unique() |>
                           tibble::column_to_rownames("measurement")  |>
                           as.matrix()
         )[,1]

         # Paired t-Test: IQ Change After One Year

         pairwise_comparisons <- matrix(levels(data_long$measurement),
                                        nrow=2)
         ## set column names:
         colnames(pairwise_comparisons) <- apply(pairwise_comparisons,
                                                 2,
                                                 function(x) {
                                                   paste0(x[1],"_vs_",x[2])
                                                 })
         ## print it
         pairwise_comparisons

         ## plot it
         ggboxplot(data_long, x = "measurement", y = "IQ_value",
                   color = "measurement",
                   palette = colors_long,
                   order = levels(data_long$measurement),
                   ylab = "IQ", xlab = "group") +

           stat_compare_means(method = "t.test",
                              ## convert matrix columns to list elements:
                              comparisons = pairwise_comparisons|>
                                as.data.frame() |> as.list(),
                              paired = TRUE ## pairwise test!
           )


         ##The IQ measured after one year at the new school  is clearly higher than IQ at schooling decision **only for children attending highschool**. This effect does not depend on parental education.


         # Linear Regression: Concepts (see html)


         # Simple Linear Regression: IQ vs Income in low|highschool
         ##Extract the subset of the full dataset we want to look at:
         low_highschool <- subset(dataset, group == "low|highschool")
         low_highschool

         ## Compute a regression
         ##The `lm` (**L**inear ""M**odeling) function is the workhorse for both simple and multiple regression:

         fit1 <- lm(IQ ~ income, low_highschool)
         ##Note that you should **always safe the result in a variable**.

         ##A **typical behavior of R's statistical functions** is:
         ##-    they do not return a lot of output to the console
         ##-    but rather return an object containing lots of details of the result
         ##-    which can be extracted by dedicated functions as needed

         ## See the Result:
         ##A typical function which can interpret the objects returned by many statistical functions is `summary`:
         summary(fit1)

         ## Interpret the Result (see html)

         ## Is the Interpretation Valid?
         ##The above interpretation is only valid if at least two basic assumptions of linear modeling are met:
         ##-   The **residuals** = Y_i - fitted_i are normally distributed (**not** necessarily the Y_i themselves!)
         ##-   The values of the residuals are independent of the values of the fitted values

         ##R's generic `plot` function can take a result of `lm` as input and produce one of six different **diagnostic** plots,
         ##which check these assumptions from various angles. The plots can be individually request by the `which` parameter
         ##to `plot`. Alternatively, if `plot` is simply called with a regression result, hitting <Enter> will produce plots
         ##1,2,3, and 5 in turn. For our `fit1` they look like this:

         layout(matrix(1:4,nrow=2,byrow=TRUE))
         plot(fit1,which=1)
         plot(fit1,which=2)
         plot(fit1,which=3)
         plot(fit1,which=5)
         layout(1)

         ##"Residuals vs Fitted" shows an even scatter of the residuals along the entire range of the fitted values, as required.
         ##""The Scale-Location" plot is a variant of this, saying essentially the same. The Q-Q plot shows that the residuals are
         ##"mostly normally distributed as they should, however there are deviations from normality at the extremes of the distribution,
         ##"which should be checked in a real case. The "Residuals vs Leverage" has ax X axis the leverage, which is a measure of how
         ##"much influence a given data point has on the final location of the regression line. The Y axis is the residuals minus their standard
         ##"deviation, the so-called Standardized Residuals. We see that some observations do have higher influences than others. However
         ##"the critical Cook's distance is nowhere violated, which is evident from the fact that the plot has no red dashed boundaries
         ##"in the edges which would demarcate the critical areas.


         ##"Altogether one can therefore conclude that the assumptions are reasonably well met.


         # Multiple Linear Regression: Role of "group: in IQ ~ income

         ## A Model With Two Predictors On the Full Dataset:

         fit2 <- lm(IQ ~ income + group, dataset)
         summary(fit2)

         ##Parental income has no independent predictive value on the IQ when the grouping factor is part of the model.

         ##  F-Statistic For Model Comparison

         ##The F-statistic in the model summaries compares the predictive power of the model to the NULL model without any predictors, using an ANOVA framework. Function **anova()** can do this for any two models. Let us compare the fit2 model to a model on the full data with income as the only predictor:

         fit0 <- lm(IQ ~ income, dataset) ## now not restricted to one group level!
         anova(fit0, fit2)

         ##As expected, including "group" improves the model greatly.

         ##  Diagnostic Plots With Multiple Predictors

         layout(matrix(1:4,nrow=2,byrow=TRUE))
         plot(fit2,which=1)
         plot(fit2,which=2)
         plot(fit2,which=3)
         plot(fit2,which=5)
         layout(1)


         ##Because the regression is now actually done in 3D space, the diagnostic 2D plots are no longer that easy to interpret. What is important is the normality of the residuals (plot 2) and an approximately horizontal red line in the last two plots.

