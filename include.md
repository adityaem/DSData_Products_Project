---
title: "include.md"
author: "AKT"
date: "December 27, 2015"
output: html_document
---

Welcome to the Super Stores Sales Dashboard - Here you will find an overview into how to use the application and the primary objectives of the tool. 

This tool is intended for the Product Development and Sales Teams to analyze how their categories are perfroming geographically and to understand in which states to focus efforts for specific products. 

This tool is based on a sample dataset provided by Tableau Software called Supper Stores Orders. The data was essentially broken into three primary categories and by order date. Before using the data I aggregated it to Order Year and just retained the key metrics at the Sub-Category Level. [https://www.tableausoftware.com]

The Tool is broken up into three components:

1. Geographic Overview where the color gradient represents volume - The User can Toggle between a review with Sales Amounts, Just profit and finally Number of Customers. These dimensions help answer key questions if there is a correlation between number of customers and sales and profit or the types of products being purchase dby fewer customers and what are those categories.

2.Trend View - which allows the user to review all dimensions and measures over time and identify any trends to focus on.

3.Data View - This is essentially a data grid and allows the user to download the file for offline analysis.

Sidepanel Filters apply on all views except the data view.

Available Filters:
1. Year - USer can change the time dimension of the analysis
2. Product Category - Toggle between different categories to see what the drivers for sale are.

Finally this Shiny Application was developed for project work and was intended to meet the following criteria:
our Shiny Application

1. Write a shiny application with associated supporting documentation. The documentation should be thought of as whatever a user will need to get started using your application.
2. Deploy the application on Rstudio's shiny server
3. Share the application link by pasting it into the text box below
4. Share your server.R and ui.R code on github
5. The application must include the following:
6. Some form of input (widget: textbox, radio button, checkbox, ...)
7. Some operation on the ui input in sever.R
8. Some reactive output displayed as a result of server calculations
9. You must also include enough documentation so that a novice user could use your application. 

10.The documentation should be at the Shiny website itself. Do not post to an external link.

The Shiny application in question is entirely up to you. However, if you're having trouble coming up with ideas, you could start from the simple prediction algorithm done in class and build a new algorithm on one of the R datasets packages. Please make the package simple for the end user, so that they don't need a lot of your prerequisite knowledge to evaluate your application. You should emphasize a simple project given the short time frame.  

