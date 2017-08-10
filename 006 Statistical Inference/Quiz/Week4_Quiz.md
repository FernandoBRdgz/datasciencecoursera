#### 1. A pharmaceutical company is interested in testing a potential blood pressure lowering medication. Their first examination considers only subjects that received the medication at baseline then two weeks later. The data are as follows (SBP in mmHg)

|Subject	|Baseline	|Week 2|
| ------------- | ------------- | ---- |
|1	        |140	        |132   |
|2	        |138	        |135   |
|3	        |150	        |151   |
|4	        |148	        |146   |
|5	        |135	        |130   |

#### Consider testing the hypothesis that there was a mean reduction in blood pressure? Give the P-value for the associated two sided T test. (Hint, consider that the observations are paired.)

```{r}
round(t.test(SBP$Baseline, SBP$Week2, alternative = "two.sided", paired = TRUE)$p.value, 3)
```
```{r}
#> [1] 0.087
```

* 0.087

#### 2. A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. What is the complete set of values of μ0 that a test of H0:μ=μ0 would fail to reject the null hypothesis in a two sided 5% Students t-test?

```{r}
round(1100 + c(-1, 1) * qt(p = 1-.05/2, df = 8) *  30/sqrt(9), 0)
```
```
#> [1] 1077 1123
```

* 1077 to 1123

#### 3. Researchers conducted a blind taste test of Coke versus Pepsi. Each of four people was asked which of two blinded drinks given in random order that they preferred. The data was such that 3 of the 4 people chose Coke. Assuming that this sample is representative, report a P-value for a test of the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

```{r}
round(binom.test(x = 3, n = 4, p = 0.5, alternative = "greater", conf.level = 0.95)$p.value, 2)
```
```
#> [1] 0.31
```

* 0.31

#### 4. Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark. A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk. About what is the one sided P-value for the relevant test of whether the hospital is *below* the standard?

```{r}
round(poisson.test(x = 10, T = 1787, r = 1/100, alternative = "less")$p.value, 2)
```
```
#> [1] 0.03
```

* 0.03

#### 5. Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ body mass indices (BMIs) were measured at a baseline and again after having received the treatment or placebo for four weeks. The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for the treated group and 1 kg/m2 for the placebo group. The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group and 1.8 kg/m2 for the placebo group. Does the change in BMI appear to differ between the treated and placebo groups? Assuming normality of the underlying data and a common population variance, give a pvalue for a two sided t test.

```{r}
n_x <- 9 ; n_y <- 9
x_bar <- 1; y_bar <- -3
sd_x <- 1.8; sd_y <- 1.5
S_p <- sqrt( ((n_x-1)*sd_x^2 + (n_y-1)*sd_y^2) / (n_x+n_y-2) ) 
p.value <- pt( (y_bar - x_bar) / (S_p * (sqrt(1/n_x + 1/n_y)) ), n_x+n_y-2 )
p.value * 2
```
```
#> [1] 0.0001025174
```

* Less than 0.01

#### 6. Brain volumes for 9 men yielded a 90% confidence interval of 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of H0:μ=1,078?

* No you wouldn't reject.

#### 7. Researchers would like to conduct a study of 100 healthy adults to detect a four year mean brain volume loss of .01 mm3. Assume that the standard deviation of four year volume loss in this population is .04 mm3. About what would be the power of the study for a 5% one sided test versus a null hypothesis of no volume loss?

```{r}
round(power.t.test(n = 100, delta = .01, sd = .04, sig.level = 0.05, type = "one.sample", alternative = "one.sided")$power, 2)
```
```
#> [1] 0.8
```

* 0.80

#### 8. Researchers would like to conduct a study of n healthy adults to detect a four year mean brain volume loss of .01 mm3. Assume that the standard deviation of four year volume loss in this population is .04 mm3. About what would be the value of n needed for 90% power of type one error rate of 5% one sided test versus a null hypothesis of no volume loss?

```{r}
ceiling(power.t.test(power = .90, delta = .01, sd = .04, sig.level = 0.05, type = "one.sample", alternative = "one.sided")$n/10)*10
```
```{r}
#> [1] 140
```

* 140

#### 9. As you increase the type one error rate, α, what happens to power?

* You will get larger power.









