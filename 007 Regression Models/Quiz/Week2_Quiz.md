# 007 Regression Models

## Week 2 Quiz

### Author: Fernando Barranco Rodríguez

---

**1.  Consider the following data with x as the predictor and y as as the
    outcome.**

<!-- -->

    x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
    y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)

**Give a P-value for the two sided hypothesis test of whether
*β*<sub>1</sub> from a linear regression model is 0 or not.**

-   0.025

-   0.391

-   0.05296

-   2.325

<!-- -->

    fit <- lm(y ~ x)
    summary(fit)$coef

    ##              Estimate Std. Error   t value   Pr(>|t|)
    ## (Intercept) 0.1884572  0.2061290 0.9142681 0.39098029
    ## x           0.7224211  0.3106531 2.3254912 0.05296439

Answer: 0.05296

**2.  Consider the previous problem, give the estimate of the residual
    standard deviation.**

-   0.223

-   0.4358

-   0.05296

-   0.3552

<!-- -->

    summary(fit)$sigma

    ## [1] 0.2229981

Answer: 0.223

**3.  In the `mtcars` data set, fit a linear regression model of weight
    (predictor) on mpg (outcome). Get a 95% confidence interval for the
    expected mpg at the average weight. What is the lower endpoint?**

-   18.991

-   -4.00

-   -6.486

-   21.190

<!-- -->

    data("mtcars")
    y <- mtcars$mpg
    x <- mtcars$wt
    n <- length(y)
    fit.car <- lm(y ~ x)
    mean(x)

    ## [1] 3.21725

    fit.car$coef[1] + fit.car$coef[2] * mean(x)

    ## (Intercept) 
    ##    20.09062

    predict(fit.car, newdata = data.frame(x = mean(x)), interval = ("confidence"))

    ##        fit      lwr      upr
    ## 1 20.09062 18.99098 21.19027

Answer: 18.991

**4.  Refer to the previous question. Read the help file for mtcars. What
    is the weight coefficient interpreted as?**

-   It can't be interpreted without further information

-   The estimated expected change in mpg per 1,000 lb increase in
    weight.

-   The estimated 1,000 lb change in weight per 1 mpg increase.

-   The estimated expected change in mpg per 1 lb increase in weight.

Answer: The estimated expected change in mpg per 1,000 lb increase in
weight.

**5.  Consider again the mtcars data set and a linear regression model
    with mpg as predicted by weight (1,000 lbs). A new car is coming
    weighing 3000 pounds. Construct a 95% prediction interval for its
    mpg. What is the upper endpoint?**

-   -5.77

-   27.57

-   21.25

-   14.93

<!-- -->

    predict(fit.car, newdata = data.frame(x = 3), interval = ("prediction"))

    ##        fit      lwr      upr
    ## 1 21.25171 14.92987 27.57355

Answer: 27.57

**6.  Consider again the `mtcars` data set and a linear regression model
    with mpg as predicted by weight (in 1,000 lbs). A "short" ton is
    defined as 2,000 lbs. Construct a 95% confidence interval for the
    expected change in mpg per 1 short ton increase in weight. Give the
    lower endpoint.**

-   -6.486

-   4.2026

-   -12.973

-   -9.000

<!-- -->

    fit.ton <- lm(y ~ I(x/2))
    ton.coef <- coef(summary(fit.ton))
    ton.coef

    ##              Estimate Std. Error   t value     Pr(>|t|)
    ## (Intercept)  37.28513   1.877627 19.857575 8.241799e-19
    ## I(x/2)      -10.68894   1.118202 -9.559044 1.293959e-10

    ton.coef[2,1] + c(-1, 1) * qt(.975, df = n-2) * ton.coef[2,2]

    ## [1] -12.97262  -8.40527

Answer: -12.973

**7.  If my X from a linear regression is measured in centimeters and I
    convert it to meters what would happen to the slope coefficient?**

-   It would get multiplied by 100.

-   It would get multiplied by 10

-   It would get divided by 100

-   It would get divided by 10

Answer: It would get multiplied by 100.

**8.  I have an outcome, Y, and a predictor, X and fit a linear
    regression model with
    *Y* = *β*<sub>0</sub> + *β*<sub>1</sub>X + ϵ to obtain
    $\hat{\beta_0}$ and $\hat{\beta_1}$. What would be the
    consequence to the subsequent slope and intercept if I were to refit
    the model with a new regressor, X + c for some constant, c?**

-   The new slope would be $\hat{\beta_1+c}$

-   The new intercept would be $\hat{\beta_0}+c\hat{\beta_1}$

-   The new intercept would be $\hat{\beta_0}-c\hat{\beta_1}$

-   The new slope would be $c\hat{\beta_1}$

Answer: The new intercept would be $\hat{\beta_0}-c\hat{\beta_1}$

**9.  Refer back to the mtcars data set with mpg as an outcome and weight
    (wt) as the predictor. About what is the ratio of the the sum of the
    squared errors, $\sum_{i=1}^{n}(Y_i- \hat{Y_i})^2$ when
    comparing a model with just an intercept (denominator) to the model
    with the intercept and slope (numerator)?**

-   0.75

-   0.50

-   0.25

-   4.00

<!-- -->

    fit.with <- lm(y ~ x)
    summary(fit.with)$sigma^2 / (sum((y - mean(y))^2) / (n-1))

    ## [1] 0.2554061

Answer: 0.25

**10.  Do the residuals always have to sum to 0 in linear regression?**

-   If an intercept is included, the residuals most likely won't sum to
    zero.

-   If an intercept is included, then they will sum to 0.

-   The residuals never sum to zero.

-   The residuals must always sum to zero.

Answer: If an intercept is included, then they will sum to 0.
