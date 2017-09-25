# 002 R Programming

## Week 1 Quiz

### Author: Fernando Barranco Rodríguez

---

**1. R was developed by statisticians working at**

* Bell Labs

* StatSci

* The University of Auckland

* Harvard University

Answer: The University of Auckland

**2. The definition of free software consists of four freedoms (freedoms 0 through 3). Which of the following is NOT one of the freedoms that are part of the definition? Select all that apply.**

* The freedom to sell the software for any price.

* The freedom to study how the program works, and adapt it to your needs.

* The freedom to restrict access to the source code for the software.

* The freedom to prevent users from using the software for undesirable purposes.

* The freedom to redistribute copies so you can help your neighbor.

* The freedom to run the program, for any purpose.

* The freedom to improve the program, and release your improvements to the public, so that the whole community benefits.

Answer: The freedom to sell the software for any price, The freedom to restrict access to the source code for the software, The freedom to prevent users from using the software for undesirable purposes.

**3. In R the following are all atomic data types EXCEPT: (Select all that apply)**

* data frame

* character

* numeric

* list

* matrix

* array

* table

* complex

* logical

* integer

Answers: data frame, list, matrix, array, table

**4. If I execute the expression `x <- 4` in R, what is the class of the object `x` as determined by the `class()` function?**

* numeric

* integer

* vector

* real

* complex

* list

* matrix

Answer: numeric

**5. What is the class of the object defined by the expression `x <- c(4, "a", TRUE)`?**

* logical

* mixed

* character

* numeric

* integer

Answer: character

**6. If I have two vectors `x <- c(1,3, 5)` and `y <- c(3, 2, 10)`, what is produced by the expression `rbind(x, y)`?**

* a matrix with two rows and three columns

* a vector of length 3

* a 3 by 2 matrix

* a 3 by 3 matrix

* a 2 by 2 matrix

* a vector of length 2

Answer: a matrix with two rows and three columns

**7. A key property of vectors in R is that**

* elements of a vector all must be of the same class

* a vector cannot have have attributes like dimensions

* the length of a vector must be less than 32,768

* elements of a vector can only be character or numeric

* elements of a vector can be of different classes

Answer: elements of a vector all must be of the same class

**8. Suppose I have a list defined as `x <- list(2, "a", "b", TRUE)`. What does `x[[2]]` give me? Select all that apply.**

* a character vector with the elements "a" and "b".

* a character vector of length 1.

* a character vector containing the letter "a".

* a list containing character vector with the letter "a".

* a list containing the number 2 and the letter "a".

Answers: a character vector of length 1, a character vector containing the letter "a".

**9. Suppose I have a vector `x <- 1:4` and `y <- 2:3`. What is produced by the expression `x + y`?**

* an integer vector with the values 3, 5, 5, 7.

* an numeric vector with the values 3, 5, 5, 7.

* a warning

* a numeric vector with the values 1, 2, 5, 7.

* an error.

* an integer vector with the values 3, 5, 3, 4.

* a numeric vector with the values 3, 5, 3, 4.

Answer: an integer vector with the values 3, 5, 5, 7.

**10. Suppose I have a vector `x <- c(3, 5, 1, 10, 12, 6)` and I want to set all elements of this vector that are less than 6 to be equal to zero. What R code achieves this? Select all that apply.**

* x[x == 6] <- 0

* x[x > 6] <- 0

* x[x > 0] <- 6

* x[x <= 5] <- 0

* x[x < 6] == 0

* x[x != 6] <- 0

* x[x >= 6] <- 0

* x[x == 0] < 6

* x[x %in% 1:5] <- 0

* x[x == 0] <- 6

* x[x < 6] <- 0

Answers: x[x <= 5] <- 0; x[x %in% 1:5] <- 0; x[x < 6] <- 0

**11. Use the Week 1 Quiz Data Set to answer questions 11-20. In the dataset provided for this Quiz, what are the column names of the dataset?**

* Month, Day, Temp, Wind

* Ozone, Solar.R, Wind, Temp, Month, Day

* Ozone, Solar.R, Wind

* 1, 2, 3, 4, 5, 6

Answer: Ozone, Solar.R, Wind, Temp, Month, Day

**12. Extract the first 2 rows of the data frame and print them to the console. What does the output look like?**

```
#   Ozone Solar.R Wind Temp Month Day

# 1     7      NA  6.9   74     5  11

# 2    35     274 10.3   82     7  17
```
```
#   Ozone Solar.R Wind Temp Month Day

# 1     9      24 10.9   71     9  14

# 2    18     131  8.0   76     9  29
```
```
#   Ozone Solar.R Wind Temp Month Day
# 
1    18     224 13.8   67     9  17

# 2    NA     258  9.7   81     7  22
```
```
#   Ozone Solar.R Wind Temp Month Day
# 
1    41     190  7.4   67     5   1
# 
2    36     118  8.0   72     5   2
```

Answer: 

```
#   Ozone Solar.R Wind Temp Month Day
# 
1    41     190  7.4   67     5   1
# 
2    36     118  8.0   72     5   2
```

**13. How many observations (i.e. rows) are in this data frame?**

* 160

* 129

* 45

* 153

Answer: 153

**14. Extract the last 2 rows of the data frame and print them to the console. What does the output look like?**

```
#     Ozone Solar.R Wind Temp Month Day

# 152    31     244 10.9   78     8  19

# 153    29     127  9.7   82     6   7
```
```
#     Ozone Solar.R Wind Temp Month Day
# 
152    11      44  9.7   62     5  20
# 
153   108     223  8.0   85     7  25
```
```
#     Ozone Solar.R Wind Temp Month Day

# 152    18     131  8.0   76     9  29
# 
153    20     223 11.5   68     9  30
```
```
#     Ozone Solar.R Wind Temp Month Day
# 
152    34     307 12.0   66     5  17
# 
153    13      27 10.3   76     9  18
```

Answer: 

```
#     Ozone Solar.R Wind Temp Month Day

# 152    18     131  8.0   76     9  29
# 
153    20     223 11.5   68     9  30
```

**15. What is the value of Ozone in the 47th row?**

* 18

* 63

* 34

* 21

Answer: 21

**16. How many missing values are in the Ozone column of this data frame?**

* 78

* 43

* 9

* 37

Answer: 37

**17. What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.**

* 18.0

* 31.5

* 53.2

* 42.1

Answer: 42.1

**18. Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?**

* 334.0

* 205.0

* 185.9

* 212.8

Answer: 212.8

**19. What is the mean of "Temp" when "Month" is equal to 6?**

* 75.3

* 85.6

* 90.2

* 79.1

Answer: 79.1

**20. What was the maximum ozone value in the month of May (i.e. Month is equal to 5)?**

* 100

* 115

* 97

* 18

Answer: 115

