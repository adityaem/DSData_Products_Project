---
title       : Super Store Analyzer 
subtitle    : Developing Data Products
author      : AKT
date        : December 28th 2015
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---



## Introduction
This presentation is part of the Course Project for the Coursera Developing Data Products class. The peer assessed assignment has two parts. 

First, we need to create a Shiny application and deploy it on Rstudio's servers.

Link to App: https://adityaem.shinyapps.io/DSData_Products_Project

Link to src:https://github.com/adityaem/DSData_Products_Project/tree/master

Second, we should use Slidify or Rstudio Presenter to prepare a reproducible pitch presentation about the application. 

This presentation adresses the second part of the course project.

--- .class #id 

## Objectives for Super Store Analyzer
Build a Shiny application leveraging UI controls integrated with efficient server side processing using reactive functions.
The Application is intended for Product managers and the Sales Team to analyze performance by product and geographic location.
We see the data is broken out by Year, Product Category,Sales Revenue, Quantity Sold and Number of Customers by State

```
##   YEAR    STATE     SALECAT SALES PROFIT CUSTOMERS QTY TOTCUST
## 1 2011 illinois   Bookcases   918   -101        83  11      83
## 2 2011 illinois      Chairs  2509   -311       132  19     132
## 3 2011 illinois Furnishings   305   -210         9  33       9
```


--- &twocol

## Super Store Data Exploration
Review relationship between Categories and key metrics like sales , profits, qty & number of customers
*** =left
![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png) 
*** =right
![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

--- .class #id 
## Why the Super Store Analyzer?

1. Onestop shop for Super Store Performance Insights
2. One of a kind Shiny Application
3. Trend Analysis

--Coming Phase II

1. Forecasting by Product Category 
2. Segmentation
