# # Regression Models Course Project
# 
# Instructions
# 
# You work for Motor Trend, a magazine about the automobile industry. Looking at a data set of a collection of 
# cars, they are interested in exploring the relationship between a set of variables and miles per gallon (MPG) 
# (outcome). They are particularly interested in the following two questions:
#   
# “Is an automatic or manual transmission better for MPG”
# "Quantify the MPG difference between automatic and manual transmissions" 
# 
# Review criteria
# 
# Peer Grading
# 
# The criteria that your classmates will use to evaluate and grade your work are shown below.
# Each criteria is binary: (1 point = criteria met acceptably; 0 points = criteria not met acceptably)
# 
# Criteria
# 
# Did the student interpret the coefficients correctly?
#   Did the student do some exploratory data analyses?
#   Did the student fit multiple models and detail their strategy for model selection?
#   Did the student answer the questions of interest or detail why the question(s) is (are) not answerable?
#   Did the student do a residual plot and some diagnostics?
#   Did the student quantify the uncertainty in their conclusions and/or perform an inference correctly?
#   Was the report brief (about 2 pages long) for the main body of the report and no longer than 5 with 
#   supporting appendix of figures?
#   Did the report include an executive summary?
#   Was the report done in Rmd (knitr)? 
#   
# My Submission
# 
# Question
# 
# Take the data set and write up an analysis to answer their question using regression models and exploratory 
# data analyses.
# 
# Your report must be:
#   
# Written as a PDF printout of a compiled (using knitr) R markdown document.
# Brief. Roughly the equivalent of 2 pages or less for the main text. Supporting figures in an appendix can be 
# included up to 5 total pages including the 2 for the main report. The appendix can only include figures.
# Include a first paragraph executive summary.
# 
# Upload your PDF by clicking the Upload button below the text box.
# 
# Peer Grading
# 
# The criteria that your classmates will use to evaluate and grade your work are shown below.
# Each criteria is binary: (1 point = criteria met acceptably; 0 points = criteria not met acceptably)
# Your Course Project score will be the sum of the points and will count as 40% of your final grade in the 
# course. 
  
## -----------------------------------------

# Title: Regression Models Course Project
# Author: William Matthews
# Date: February 11, 2018

# Executive Summary
# We will be reviewing the mtcars dataset and exploring the relationship between its set of variables and
# miles per gallon (MPG) as the outcome. Of particular interest are the following questions:
#
# 1. Is an automatic or manual transmission better for mpg?
# 2. Can I quantify the mpg difference between automatic and manual transmission?
#
# Conclusions:
#
# Based on our analysis cars with manual transmission get higher mpg than those with automatic transmission. 
# The difference is about 7.2 mpg. However, transmission type only accounts for about 36% of the variability
# in mpg. As a result we looked at the other variables in the mtcars dataset to see what affect they had on
# mpg. 
# 
# The other variables from mtcars that had the highest affect on mpg were hp, cyl, and wt. 
# 
# When adjusting for hp, cyl, & wt manual transmission increased mpg by about 1.8 over automatic transmission.
# Mpg decreased by about 2.5 for every 1000 lb. increase in wt (adjusted for hp, cyl, & am).
# When cyl (the number of cylinders) increases from 4 to 6 to 8, mpg will decrease by 3 and 2.2 respectively
# (adjusted for hp, wt, & am). 

# Dataset: mtcars
#
# Format
# A data frame with 32 observations on 11 variables.
# 
# [, 1]	 mpg	 Miles/(US) gallon
# [, 2]	 cyl	 Number of cylinders
# [, 3]	 disp	 Displacement (cu.in.)
# [, 4]	 hp	 Gross horsepower
# [, 5]	 drat	 Rear axle ratio
# [, 6]	 wt	 Weight (1000 lbs)
# [, 7]	 qsec	 1/4 mile time
# [, 8]	 vs	 V/S
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
# [,10]	 gear	 Number of forward gears
# [,11]	 carb	 Number of carburetors

# Set working directory
setwd("C:/Users/Bill/Documents/Coursera/JohnsHopkins/Course 7 - Regression Models/Week 4/RM Course Project")

# Load tidyverse package
library(tidyverse)

# Load the mtcars dataset
data(mtcars)

# Exploratory Data Analysis
# use visualisation and transformation to explore your data in a systematic way. 
# http://r4ds.had.co.nz/exploratory-data-analysis.html
# https://www.r-bloggers.com/exploratory-data-analysis-useful-r-functions-for-exploring-a-data-frame/

# Your goal during Exploratory Data Analysis (EDA) is to develop an understanding of your data. The easiest 
# way to do this is to use questions as tools to guide your investigation. When you ask a question, the 
# question focuses your attention on a specific part of your dataset and helps you decide which graphs, 
# models, or transformations to make.

# Two types of questions will always be useful for making discoveries within your data. You can loosely word
# these questions as:

# 1. What type of variation occurs within my variables?
# 2. What type of covariation occurs between my variables?

# Use dim() to obtain the dimensions of the data frame (number of rows and number of columns). The output 
# is a vector.
dim(mtcars)  

# [1] 32 11

# The names() function will return the column headers.
names(mtcars)

#  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear" "carb"

# Use head() to obtain the first n observations and tail() to obtain the last n observations; by default, 
# n = 6.
head(mtcars)

#                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
# Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
# Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
# Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
# Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
# Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
# Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

head(mtcars, n = 4)
head(mtcars, n = -22)

# The str() function returns many useful pieces of information, including the types of data for each column.
# “num” denotes that the variable is numeric (continuous), and “Factor” denotes that the variable is 
# categorical with x categories or levels.  
# To obtain all of the categories or levels of a categorical variable, use the levels() function.
# Use the str() function to return the structure of the mtcars dataset. 
str(mtcars)

# 'data.frame':	32 obs. of  11 variables:
# $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
# $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
# $ disp: num  160 160 108 258 360 ...
# $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
# $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
# $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
# $ qsec: num  16.5 17 18.6 19.4 17 ...
# $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
# $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
# $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
# $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

# When applied to a data frame, the summary() function is essentially applied to each column, and the results 
# for all columns are shown together.  For a continuous (numeric) variable, it returns the 5-number summary.
# If there are any missing values (denoted by “NA” for a particular datum), it would also provide a count 
# for them.
#  For a categorical variable, it returns the levels and the number of data in each level.  
# Display a summary of the mtcars dataframe.
summary(mtcars)
#          mpg             cyl             disp             hp             drat             wt             qsec      
# Min.   :10.40   Min.   :4.000   Min.   : 71.1   Min.   : 52.0   Min.   :2.760   Min.   :1.513   Min.   :14.50  
# 1st Qu.:15.43   1st Qu.:4.000   1st Qu.:120.8   1st Qu.: 96.5   1st Qu.:3.080   1st Qu.:2.581   1st Qu.:16.89  
# Median :19.20   Median :6.000   Median :196.3   Median :123.0   Median :3.695   Median :3.325   Median :17.71  
# Mean   :20.09   Mean   :6.188   Mean   :230.7   Mean   :146.7   Mean   :3.597   Mean   :3.217   Mean   :17.85  
# 3rd Qu.:22.80   3rd Qu.:8.000   3rd Qu.:326.0   3rd Qu.:180.0   3rd Qu.:3.920   3rd Qu.:3.610   3rd Qu.:18.90  
# Max.   :33.90   Max.   :8.000   Max.   :472.0   Max.   :335.0   Max.   :4.930   Max.   :5.424   Max.   :22.90  
# vs               am              gear            carb      
# Min.   :0.0000   Min.   :0.0000   Min.   :3.000   Min.   :1.000  
# 1st Qu.:0.0000   1st Qu.:0.0000   1st Qu.:3.000   1st Qu.:2.000  
# Median :0.0000   Median :0.0000   Median :4.000   Median :2.000  
# Mean   :0.4375   Mean   :0.4062   Mean   :3.688   Mean   :2.812  
# 3rd Qu.:1.0000   3rd Qu.:1.0000   3rd Qu.:4.000   3rd Qu.:4.000  
# Max.   :1.0000   Max.   :1.0000   Max.   :5.000   Max.   :8.000  

# Display the correlation between mpg and the other variables in mtcars 
# (variables must be numeric to run this function)
cor(mtcars)

#             mpg        cyl       disp         hp        drat         wt        qsec         vs          am            gear        carb
# mpg   1.0000000 -0.8521620 -0.8475514 -0.7761684  0.68117191 -0.8676594  0.41868403  0.6640389  0.59983243       0.4802848 -0.55092507

#OR#
install.packages("corrr")
library(corrr)
mtcars %>% correlate() %>% focus(mpg)
# focus tells R which variable to correlate to all the other variables in the dataframe. 

# A tibble: 10 x 2
# rowname        mpg
# <chr>      <dbl>
# 1     cyl -0.8521620
# 2    disp -0.8475514
# 3      hp -0.7761684
# 4    drat  0.6811719
# 5      wt -0.8676594
# 6    qsec  0.4186840
# 7      vs  0.6640389
# 8      am  0.5998324
# 9    gear  0.4802848
# 10   carb -0.5509251

# The variables with the highest correlation to mpg are cyl, disp, hp, & wt

# Display unique values for variables
unique(mtcars$cyl)
# [1] 6 4 8

unique(mtcars$vs)
# [1] 0 1

unique(mtcars$am)
# [1] 1 0

unique(mtcars$gear)
# [1] 4 3 5

unique(mtcars$carb)
# [1] 4 1 2 3 6 8

# Recode selected numeric variables as factors
mtcars$cyl <- factor(mtcars$cyl)
mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual")) # 0 = automatic, 1 = manual
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

# Use str() function to return types of data for each column.
str(mtcars)

# 'data.frame':	32 obs. of  11 variables:
# $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
# $ cyl : Factor w/ 3 levels "4","6","8": 2 2 1 2 3 2 3 1 1 2 ...
# $ disp: num  160 160 108 258 360 ...
# $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
# $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
# $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
# $ qsec: num  16.5 17 18.6 19.4 17 ...
# $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
# $ am  : Factor w/ 2 levels "Automatic","Manual": 2 2 2 1 1 1 1 1 1 1 ...
# $ gear: Factor w/ 3 levels "3","4","5": 2 2 2 1 1 1 1 2 2 2 ...
# $ carb: Factor w/ 6 levels "1","2","3","4",..: 4 4 1 1 2 1 4 2 2 4 ...

# Regression Analysis
# Look at the relationship between mpg and the am (Transmission (0 = automatic, 1 = manual)) variable.

# Aggregate the mpg by transmission type (auto, manual)
aggregate(mpg~am, data = mtcars, mean)

#          am      mpg
# 1 Automatic 17.14737
# 2    Manual 24.39231

# The data indicates that on average mpg is higher with manual transmissions. 

# Statistical Inference
# Quantify the difference in mpg for the am variable with a t-test.
t.test(mpg ~ am, data = mtcars)

# Welch Two Sample t-test
# 
# data:  mpg by am
# t = -3.7671, df = 18.332, p-value = 0.001374
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#  -11.280194  -3.209684
# sample estimates:
# mean in group Automatic    mean in group Manual 
#                17.14737                24.39231 

# We test weather there is a relationship between our two variables with a significance level of .05. The
# p-value = 0.001374, which is less than .05, indicating that this is a significant difference and thus
# reject the null hypothesis that automatic and manual transmissions have the same effect on mpg.  

# Plot mpg by transmission type with mpg on the y axis and transmission type on the x axis.
plot(mpg~am, data = mtcars)

# Model selection
# Linear models

# Use lm function to fit a linear model with mpg as the outcome and am as the predictor.
fit <- lm(mpg~am, data = mtcars)

# View summary of lm fit.
summary(fit)

# Call:
#   lm(formula = mpg ~ am, data = mtcars)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -9.3923 -3.0923 -0.2974  3.2439  9.5077 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept)   17.147      1.125  15.247 1.13e-15 ***
# amManual       7.245      1.764   4.106 0.000285 ***
#   ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 4.902 on 30 degrees of freedom
# Multiple R-squared:  0.3598,	Adjusted R-squared:  0.3385 
# F-statistic: 16.86 on 1 and 30 DF,  p-value: 0.000285

# The lm summary shows that mpg increases by 7.245 for manual transmission. 
# The R-squared:  0.3598 indicates that this model explains only 34% of the variance of mpg.  

# Use summary function to return a list of summary statistics of the fitted linear model 
# residuals	
# the weighted residuals, the usual residuals rescaled by the square root of the weights specified in the 
# call to lm.
# coefficients	
# a p x 4 matrix with columns for the estimated coefficient, its standard error, t-statistic and 
# corresponding (two-sided) p-value. Aliased coefficients are omitted.
# sigma	
# the square root of the estimated variance of the random error σ^2 = 1/(n-p) Sum(w[i] R[i]^2),
# where R[i] is the i-th residual, residuals[i].
# df	
# degrees of freedom, a 3-vector (p, n-p, p*), the first being the number of non-aliased coefficients, the 
# last being the total number of coefficients.
# r.squared	
# R^2, the ‘fraction of variance explained by the model’, R^2 = 1 - Sum(R[i]^2) / Sum((y[i]- y*)^2),
# where y* is the mean of y[i] if there is an intercept and zero otherwise.
# adj.r.squared	
# the above R^2 statistic ‘adjusted’, penalizing for higher p.
# cov.unscaled	
# a p x p matrix of (unscaled) covariances of the coef[j], j=1, …, p.
# correlation	
# the correlation matrix corresponding to the above cov.unscaled, if correlation = TRUE is specified.
# symbolic.cor	
# (only if correlation is true.) The value of the argument symbolic.cor.
# na.action	
# from object, if present there.
# Function coef will extract the matrix of coefficients with standard errors, t-statistics and p-values.

# Multivariate linear model
# We now look at the relationship between mpg and the other variables in the mtcars dataset.
# Use the pairs function to plot a matrix of the relationship betwen mpg and the other variables.
pairs(mpg~., data = mtcars)

# Use the lm function to fit the linear model with mpg as the outcome and the other variables as predictors.
fit1 <- lm(mpg ~ ., data = mtcars)

# Use the step fuction to select a formula-based model by AIC of the variables that have the highest 
# correlation to mpg, ie the "best" model.
mv_fit <- step(fit1, direction = "both")

# Start:  AIC=76.4
# mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear + carb
# 
# Df Sum of Sq    RSS    AIC
# - carb  5   13.5989 134.00 69.828
# - gear  2    3.9729 124.38 73.442
# - am    1    1.1420 121.55 74.705
# - qsec  1    1.2413 121.64 74.732
# - drat  1    1.8208 122.22 74.884
# - cyl   2   10.9314 131.33 75.184
# - vs    1    3.6299 124.03 75.354
# <none>              120.40 76.403
# - disp  1    9.9672 130.37 76.948
# - wt    1   25.5541 145.96 80.562
# - hp    1   25.6715 146.07 80.588
# 
# Step:  AIC=69.83
# mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am + gear
# 
# Df Sum of Sq    RSS    AIC
# - gear  2    5.0215 139.02 67.005
# - disp  1    0.9934 135.00 68.064
# - drat  1    1.1854 135.19 68.110
# - vs    1    3.6763 137.68 68.694
# - cyl   2   12.5642 146.57 68.696
# - qsec  1    5.2634 139.26 69.061
# <none>              134.00 69.828
# - am    1   11.9255 145.93 70.556
# - wt    1   19.7963 153.80 72.237
# - hp    1   22.7935 156.79 72.855
# + carb  5   13.5989 120.40 76.403
# 
# Step:  AIC=67
# mpg ~ cyl + disp + hp + drat + wt + qsec + vs + am
# 
# Df Sum of Sq    RSS    AIC
# - drat  1    0.9672 139.99 65.227
# - cyl   2   10.4247 149.45 65.319
# - disp  1    1.5483 140.57 65.359
# - vs    1    2.1829 141.21 65.503
# - qsec  1    3.6324 142.66 65.830
# <none>              139.02 67.005
# - am    1   16.5665 155.59 68.608
# - hp    1   18.1768 157.20 68.937
# + gear  2    5.0215 134.00 69.828
# - wt    1   31.1896 170.21 71.482
# + carb  5   14.6475 124.38 73.442
# 
# Step:  AIC=65.23
# mpg ~ cyl + disp + hp + wt + qsec + vs + am
# 
# Df Sum of Sq    RSS    AIC
# - disp  1    1.2474 141.24 63.511
# - vs    1    2.3403 142.33 63.757
# - cyl   2   12.3267 152.32 63.927
# - qsec  1    3.1000 143.09 63.928
# <none>              139.99 65.227
# + drat  1    0.9672 139.02 67.005
# - hp    1   17.7382 157.73 67.044
# - am    1   19.4660 159.46 67.393
# + gear  2    4.8033 135.19 68.110
# - wt    1   30.7151 170.71 69.574
# + carb  5   13.0509 126.94 72.095
# 
# Step:  AIC=63.51
# mpg ~ cyl + hp + wt + qsec + vs + am
# 
# Df Sum of Sq    RSS    AIC
# - qsec  1     2.442 143.68 62.059
# - vs    1     2.744 143.98 62.126
# - cyl   2    18.580 159.82 63.466
# <none>              141.24 63.511
# + disp  1     1.247 139.99 65.227
# + drat  1     0.666 140.57 65.359
# - hp    1    18.184 159.42 65.386
# - am    1    18.885 160.12 65.527
# + gear  2     4.684 136.55 66.431
# - wt    1    39.645 180.88 69.428
# + carb  5     2.331 138.91 72.978
# 
# Step:  AIC=62.06
# mpg ~ cyl + hp + wt + vs + am
# 
# Df Sum of Sq    RSS    AIC
# - vs    1     7.346 151.03 61.655
# <none>              143.68 62.059
# - cyl   2    25.284 168.96 63.246
# + qsec  1     2.442 141.24 63.511
# - am    1    16.443 160.12 63.527
# + disp  1     0.589 143.09 63.928
# + drat  1     0.330 143.35 63.986
# + gear  2     3.437 140.24 65.284
# - hp    1    36.344 180.02 67.275
# - wt    1    41.088 184.77 68.108
# + carb  5     3.480 140.20 71.275
# 
# Step:  AIC=61.65
# mpg ~ cyl + hp + wt + am
# 
# Df Sum of Sq    RSS    AIC
# <none>              151.03 61.655
# - am    1     9.752 160.78 61.657
# + vs    1     7.346 143.68 62.059
# + qsec  1     7.044 143.98 62.126
# - cyl   2    29.265 180.29 63.323
# + disp  1     0.617 150.41 63.524
# + drat  1     0.220 150.81 63.608
# + gear  2     1.361 149.66 65.365
# - hp    1    31.943 182.97 65.794
# - wt    1    46.173 197.20 68.191
# + carb  5     5.633 145.39 70.438

# The model with the lowest AIC and thus fit is mpg ~ cyl + hp + wt + am

# View summary of mv_fit model
summary(mv_fit)

# Call:
# lm(formula = mpg ~ cyl + hp + wt + am, data = mtcars)
# 
# Residuals:
#     Min      1Q  Median      3Q     Max 
# -3.9387 -1.2560 -0.4013  1.1253  5.0513 
# 
# Coefficients:
#             Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 33.70832    2.60489  12.940 7.73e-13 ***
# cyl6        -3.03134    1.40728  -2.154  0.04068 *  
# cyl8        -2.16368    2.28425  -0.947  0.35225    
# hp          -0.03211    0.01369  -2.345  0.02693 *  
# wt          -2.49683    0.88559  -2.819  0.00908 ** 
# amManual     1.80921    1.39630   1.296  0.20646    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 2.41 on 26 degrees of freedom
# Multiple R-squared:  0.8659,	Adjusted R-squared:  0.8401 
# F-statistic: 33.57 on 5 and 26 DF,  p-value: 1.506e-10

# When accounting for the other variables (cyl, hp, wt) manual transmission increases mpg by 1.8. 
# The R^2 value indicates tht 86.59% of the variance is explained by the model. 

# Use anova function to compare the base model against the best model.
anova(fit, mv_fit)

# Analysis of Variance Table
# 
# Model 1: mpg ~ am
# Model 2: mpg ~ cyl + hp + wt + am
#   Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
# 1     30 720.90                                  
# 2     26 151.03  4    569.87 24.527 1.688e-08 ***
#   ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

# The p-vale is less than .05 indicating its significant, therefore we can reject the null hypothesis
# that the other variables have no effect on mpg.

# Test the confidence of the model.
confint(mv_fit)

#                   2.5 %       97.5 %
# (Intercept) 28.35390366 39.062744138
# cyl6        -5.92405718 -0.138631806
# cyl8        -6.85902199  2.531671342
# hp          -0.06025492 -0.003963941
# wt          -4.31718120 -0.676477640
# amManual    -1.06093363  4.679356394

# We can say with 95% confidence that the variables correlations are within the ranges listed. 

# Residual
# View the residual plots for multivariate regression model and compute regression diagnostic of model
# to uncover outliers.
par(mfrow = c(2,2))
plot(mv_fit)

# The Residuals vs Fitted plot shows that the points are randomly distributed indicating independence.
# The Normal Q-Q plot shows that the distribution is generally normal because the points mostly fall
# on the normal line.
# The Scale-Location plot shows the points scattered in a constant pattern indicating a constance variance
# condition.
# The Residuals vs Leverage plot shows some outliers


###-------------------------------
# Let’s define some terms:

# A variable is a quantity, quality, or property that you can measure.
# 
# A value is the state of a variable when you measure it. The value of a variable may change from measurement 
# to measurement.
# 
# An observation is a set of measurements made under similar conditions (you usually make all of the 
# measurements in an observation at the same time and on the same object). An observation will contain 
# several values, each associated with a different variable. I’ll sometimes refer to an observation as a 
# data point.
# 
# Tabular data is a set of values, each associated with a variable and an observation. Tabular data is tidy 
# if each value is placed in its own “cell”, each variable in its own column, and each observation in its own 
# row.

# Variation is the tendency of the values of a variable to change from measurement to measurement.
# Every variable has its own pattern of variation, which can reveal interesting information. 
# The best way to understand that pattern is to visualise the distribution of the variable’s values.

# Visualising distributions
# A variable is categorical if it can only take one of a small set of values. In R, categorical variables are 
# usually saved as factors or character vectors. To examine the distribution of a categorical variable, use a 
# bar chart:
# 
# A variable is continuous if it can take any of an infinite set of ordered values. Numbers and date-times are 
# two examples of continuous variables. To examine the distribution of a continuous variable, use a histogram:

data(diamonds)
dim(diamonds)
head(diamonds)
names(diamonds)
str(diamonds)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = mtcars) +
  geom_histogram(mapping = aes(x = mpg), binwidth = 1.5)

# You can compute this by hand by combining dplyr::count() and ggplot2::cut_width():
mtcars %>%
  count(cut_width(mpg, 1.5))

ggplot(data = mtcars, mapping = aes(x = mpg, colour = am)) +
  geom_freqpoly(binwidth = 1.5)
###------------------------------------

require(graphics)
pairs(mtcars, main = "mtcars data")
coplot(mpg ~ disp | as.factor(cyl), data = mtcars, panel = panel.smooth, rows = 1)


