# 007 Regression Models

## Week 1 Quiz

### Author: Fernando Barranco Rodríguez

---

**1.  Consider the data set given below**

<!-- -->

    x <- c(0.18, -1.54, 0.42, 0.95)

**And weights given by**

    w <- c(2, 1, 3, 1)

**Give the value of *μ* that minimizes the least squares equation $\sum_{i=1}^{n}w_i(x_i-\mu)^2$**

-   0.300

-   0.0025

-   0.1471

-   1.077

Answer: 0.1471

    mu <- sum(x*w) / sum(w)
    mu

    ## [1] 0.1471429

**2.  Consider the following data set**

<!-- -->

    x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
    y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

**Fit the regression through the origin and get the slope treating y as
the outcome and x as the regressor. (Hint, do not center the data since
we want regression through the origin, not through the means of the
data.)**

-   0.59915

-   -0.04462

-   0.8263

-   -1.713

Answer: 0.8263

    fit <- lm(y ~ x -1)
    fit

    ## 
    ## Call:
    ## lm(formula = y ~ x - 1)
    ## 
    ## Coefficients:
    ##      x  
    ## 0.8263

**3. Do `data(mtcars)` from the datasets package and fit the regression model
with mpg as the outcome and weight as the predictor. Give the slope
coefficient.**

-   0.5591

-   30.2851

-   -5.344

-   -9.559

Answer: -5.344

    data("mtcars")
    fit <- lm(mpg ~ wt, mtcars)
    fit$coeff[2]

    ##        wt 
    ## -5.344472

**4.  Consider data with an outcome (Y) and a predictor (X). The standard
    deviation of the predictor is one half that of the outcome. The
    correlation between the two variables is .5. What value would the
    slope coefficient for the regression model with Y as the outcome and
    X as the predictor?**

-   3

-   4

-   1

-   0.25

Answer: 1

    cor <- 1/2; sd_y <- 1; sd_x <- 1/2
    slope <- cor*(sd_y/sd_x)
    slope

    ## [1] 1

**5.  Students were given two hard tests and scores were normalized to
    have empirical mean 0 and variance 1. The correlation between the
    scores on the two tests was 0.4. What would be the expected score on
    Quiz 2 for a student who had a normalized score of 1.5 on Quiz 1?**

-   0.6

-   0.16

-   0.4

-   1.0

Answer: 0.6

    1.5 * 0.4

    ## [1] 0.6

**6.  Consider the data given by the following**

<!-- -->

    x <- c(8.58, 10.46, 9.01, 9.64, 8.86)

**What is the value of the first measurement if x were normalized (to have
mean 0 and variance 1)?**

-   -0.9719

-   8.58

-   8.86

-   9.31

Answer: -0.9719

    x_bar <- mean(x); x_sd <- sd(x)
    x_norm <- (x - x_bar)/x_sd
    x_norm[1]

    ## [1] -0.9718658

**7.  Consider the following data set (used above as well). What is the
    intercept for fitting the model with x as the predictor and y as the
    outcome?**

<!-- -->

    x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
    y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

-   1.252

-   -1.713

-   1.567

-   2.105

Answer: 1.567

    fit <- lm(y ~ x)
    fit$coefficients[1]

    ## (Intercept) 
    ##    1.567461

**8.  You know that both the predictor and response have mean 0. What can
    be said about the intercept when you fit a linear regression?**

-   It must be identically 0.

-   It is undefined as you have to divide by zero.

-   It must be exactly one.

-   Nothing about the intercept can be said from the information given.

Answer: It must be identically 0.

**9.  Consider the data given by**

<!-- -->

    x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)

**What value minimizes the sum of the squared distances between these
points and itself?**

-   0.8

-   0.36

-   0.44

-   0.573

Answer: 0.573

    mean(x)

    ## [1] 0.573

**10.  Let the slope having fit Y as the outcome and X as the predictor be
    denoted as *β*<sub>1</sub>. Let the slope from fitting X as the
    outcome and Y as the predictor be denoted as *γ*<sub>1</sub>.
    Suppose that you divide *β*<sub>1</sub> by *γ*<sub>1</sub>; in other
    words consider *β*<sub>1</sub>/*γ*<sub>1</sub>. What is this ratio
    always equal to?**

-   Cor(Y, X)

-   2SD(Y)/SD(X)

-   Var(Y)/Var(X)

-   1

Answer: Var(Y)/Var(X)
