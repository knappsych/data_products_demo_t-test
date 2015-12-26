---
title       : Shiny t-tests
subtitle    : A useful tool for comparing different types of t-tests
author      : William H. Knapp III
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Purpose

* Do you want to run a two-sample t-test?
* Do you want to see how to report the results of t-tests in APA format?
* Do you want to see how changing assumptions can affect t-tests?

If so, check out my [Shiny 2-sample t-test app](https://knappsych.shinyapps.io/Data_Products_Demo_t-tests).

---

## How it works

1. Users enter data for two groups of observations.
2. Users indicate what type of test will be used (i.e. independent or paired).
3. Users indicate whether or not the equivalence of variance assumption is reasonable.
4. Users submit their information.
5. It returns the code needed to run the test in R, the summarized results, and a figure comparing the two groups.

---

## An Example
There are two groups of data:

```
##  [1] 13  4 15  8 13  2  8  9 13 19
```

```
##  [1] 10 13 12 14 16 27 15 21 14 11
```
After entering the data the user selects an independent t-test where the variance for the two groups are assumed to be equal.

The users see the following code:

```r
t.test(group1,group2,paired=FALSE,var.equal=TRUE)
```
But instead of seeing the following output...

---


```
## 
## 	Two Sample t-test
## 
## data:  group1 and group2
## t = -1.2711, df = 18, p-value = 0.2199
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -7.693398  1.893398
## sample estimates:
## mean of x mean of y 
##      10.9      13.8
```
They see:
```
t(18) = -1.2, p = .219
```
and an accompanying figure.

### [Try it for yourself!](https://knappsych.shinyapps.io/Data_Products_Demo_t-tests)
