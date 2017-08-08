# 006 Statistical Inference

## Week 3 Quiz

### Author: Fernando Barranco Rodríguez

---

#### 1. In a population of interest, a sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is a 95% Student's T confidence interval for the mean brain volume in this new population?

```{r}
round( 1100 + c(-1, 1) * qt(p = .975, df = 8) * (30/sqrt(9)) )
```
```{r}
#> [1] 1077 1123
```

* [1077, 1123]

#### 2. A diet pill is given to 9 subjects over six weeks. The average difference in weight (follow up - baseline) is -2 pounds. What would the standard deviation of the difference in weight have to be for the upper endpoint of the 95% T confidence interval to touch 0?

```{r}
round( 2 / qt(0.975, 8) * sqrt(9), 2)
```
```{r}
#> [1] 2.6
``` 

* 2.60

#### 3. In an effort to improve running performance, 5 runners were either given a protein supplement or placebo. Then, after a suitable washout period, they were given the opposite treatment. Their mile times were recorded under both the treatment and placebo, yielding 10 measurements with 2 per subject. The researchers intend to use a T test and interval to investigate the treatment. Should they use a paired or independent group T test and interval?

* A paired interval

#### 4. In a study of emergency room waiting times, investigators consider a new and the standard triage systems. To test the systems, administrators selected 20 nights and randomly assigned the new triage system to be used on 10 nights and the standard system on the remaining 10 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 3 hours with a variance of 0.60 while the average MWT for the old system was 5 hours with a variance of 0.68. Consider the 95% confidence interval estimate for the differences of the mean MWT associated with the new system. Assume a constant variance. What is the interval? Subtract in this order (New System - Old System).

Formula: y_bar - x_bar ± t_(n_x+n_y-2, 1-alpha/2) * S_p * (1/n_x + 1/n_y)^(1/2)
	 where S_p^2 = {(n_x-1)*S_x^2 + (n_y-1)*S_y^2}/(n_x+n_y-2) 

```{r}
n_x <- 10 ; n_y <- 10
x_bar <- 5; y_bar <- 3
var_x <- 0.68; var_y <- 0.60
alpha <- 0.05
S_p <- sqrt( ((n_x-1)*var_x + (n_y-1)*var_y) / (n_x+n_y-2) )
t_s <- qt(1-alpha/2, n_x+n_y-2)
round( (y_bar - x_bar) + c(-1, 1) * t_s * S_p * (sqrt(1/n_x + 1/n_y)), 2)
```
```{r}
#> [1] -2.75 -1.25
``` 

* [-2.75, -1.25]

#### 5. Suppose that you create a 95% T confidence interval. You then create a 90% interval using the same data. What can be said about the 90% interval with respect to the 95% interval?

* The interval will be narrower.

#### 6. To further test the hospital triage system, administrators selected 200 nights and randomly assigned a new triage system to be used on 100 nights and a standard system on the remaining 100 nights. They calculated the nightly median waiting time (MWT) to see a physician. The average MWT for the new system was 4 hours with a standard deviation of 0.5 hours while the average MWT for the old system was 6 hours with a standard deviation of 2 hours. Consider the hypothesis of a decrease in the mean MWT associated with the new treatment. What does the 95% independent group confidence interval with unequal variances suggest vis a vis this hypothesis? (Because there's so many observations per group, just use the Z quantile instead of the T.)

Formula: y_bar - x_bar ± t_df * (s^2_x/n_x + s^2_y/n_y)^(1/2) where df = (s^2_x/n_x + s^2_y/n_y)^(2) / ( (s^2_x/n_x)^2/(n_x-1) + (s^2_y/n_y)^2/(n_y-1) ) 

```{r}
y_bar <- 6; x_bar <- 4
n_x <- 100; n_y <- 100
s_x <- 0.5; s_y <- 2
alpha <- 0.05
t_df <- qnorm(1-alpha/2) # Because there's so many observations per group, use the Z quantile instead of the T.
round( (y_bar - x_bar) + c(-1, 1) * t_df * sqrt(s_x^2/n_x + s_y^2/n_y), 2)
```
```
#> [1] 1.6 2.4
```

* When subtracting (old - new) the interval is entirely above zero. The new system appears to be effective.

#### 7. Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI over the four week period appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, calculate the relevant *90%* t confidence interval. Subtract in the order of (Treated - Placebo) with the smaller (more negative) number first.

Formula: y_bar - x_bar ± t_(n_x+n_y-2, 1-alpha/2) * S_p * (1/n_x + 1/n_y)^(1/2)
	 where S_p^2 = {(n_x-1)*S_x^2 + (n_y-1)*S_y^2}/(n_x+n_y-2) 

```{r}
n_x <- 9 ; n_y <- 9
x_bar <- 1; y_bar <- -3
sd_x <- 1.8; sd_y <- 1.5
alpha <- 0.10
S_p <- sqrt( ((n_x-1)*sd_x^2 + (n_y-1)*sd_y^2) / (n_x+n_y-2) )
t_s <- qt(1-alpha/2, n_x+n_y-2)
round( (y_bar - x_bar) + c(-1, 1) * t_s * S_p * (sqrt(1/n_x + 1/n_y)), 3)
```
```{r}
#> [1] -5.364 -2.636
``` 

* [-5.364, -2.636]

