---
title: "Statistical Inference Course, Basic Inferential Data Analysis"
author: "Jackson"
date: "November 23, 2015"
output: html_document
---

The second part of the project, the Author has analyze the `ToothGrowth` data in the R datasets package. The Author has use confidence intervals or hypothesis tests to compare tooth growth by supp and dose.The data is set of 60 observations, length of odontoblasts (teeth) in each of 10 guinea pigs at each of three dose levels of Vitamin C(0.5, 1 and 2 mg) with each of two delivery methods (orange juice or ascorbic acid).

# Basic Summary of the Data

```{r}
# load dataset
library(datasets)
data("ToothGrowth")
# check the dataset variables
head(ToothGrowth)

library(ggplot2)
ggplot(data=ToothGrowth, aes(x=as.factor(dose), y=len, fill=supp)) +
    geom_bar(stat="Identity",) +
    facet_grid(. ~ supp) +
    xlab("Dose In Miligrams") +
    ylab("Tooth Length") +
    guides(fill=guide_legend(title="Supplement Type"))
```

The chart has shown the clear positive correlation between the
tooth length and the dose levels of Vitamin C, for both delivery methods.

The effect of the dose can be identified using regression analysis. The tests has answered the questions whether the suplement types(i.e. orange juice or ascorbic acid) has any effect on the tooth length. if not, how much of the variance in tooth length, if any that can be explained by the supplement type?


```{r}
ft <- lm(len ~ dose + supp, data=ToothGrowth)
summary(ft)
```

The chart has shows 70% of the variance in the data.
The intercept is `r ft$coefficients[[1]]`, meaning that is no containing any supplement of Vitamin C, the average tooth length is `r ft$coefficients[[1]]` units. The coefficient of `dose` is `r ft$coefficients[[2]]`. It can be interpreted as
increasing the delievered dose 1 mg, all else equal (i.e. no change in the
supplement type), and will increase the tooth become longer length `r ft$coefficients[[2]]` units. The last coefficient is for the supplement type. Since the supplement type isa categorical variable, dummy variables are used. The computed coefficientis for `suppVC` and the value is `r ft$coefficients[[3]]` meaning that deliveringa given dose as ascorbic acid, and have no changing the dose, affecting the result in `r abs(ft$coefficients[[3]])` units of decrease in the tooth length. Since there are only two categories, the author has conclude that on average, delivering the dosage as orange juice would increase the tooth length by `rabs(ft$coefficients[[3]])` units.


95% confidence intervals for two variables and the intercept are as shown below.
```{r}
confint(ft)
```
The confidence intervals mean that the more times of collection from a different set of data and estimate parameters of the linear model, there will have 95% of the time, the coefficient estimations will be within in these ranges. For each coefficient (i.e.intercept, `dose` and `suppVC`), the null hypothesis is that the coefficients are zero, meaning that no tooth length variation is explained by that variable.
All _p_-values are less than 0.05, rejecting the null hypothesis and suggesting
that each variable explains a significant portion of variability in tooth length,
assuming the significance level is 5%.

The Author has included the code at...