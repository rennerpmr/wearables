---
title: "codebook"
author: "Phil Renner"
date: "12/30/2020"
output:
  pdf_document: default
  html_document: default
---

run_analysis.R will extract and summarize the wearables data as specified in the assignment

1. Download the data
Downloads data from the source file, and extracts the zip into a folder called "UCI HAR Dataset"
source data URL: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Merge test and training sets to create one tidy data set
There are two data sets, a training set and a test set. The files are
Testsubject and trainsubject, a data frame of one variable, which identifies the subject of each data row
features reads in the list of variable names for the test and training sets
activity reads in the code and activity name
testactivity and trainactivity reads in the activity code for each row in the test and training sets
xtest and xtrain read in the accelerometer data
The test and train data frames are merged into allx, allactivity, allsubject
These three files are then combined in a single tidy data frame all_data

3. Subset all_data to only include mean and standard deviation fields
all_data is subsetted to include the activity, subject, and fields for mean and standard deviation into mean_sd
the activity codes are replaced with the activity names
variable names are cleaned up

4. Create summary table of means
mean_sd is then summarized by subject and activity, with the mean for each variable calculated
This summary is read into summarydata, and then written as a table summarydata.txt












```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
