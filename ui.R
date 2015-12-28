# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

# Fix tag("div", list(...)) : could not find function "showOut… 
library(rCharts)

shinyUI(
  navbarPage("Super Store Sales Dashboard",
             tabPanel("Insights",
                      sidebarPanel(
                        sliderInput("range", 
                                    "Range:", 
                                    min = 2011, 
                                    max = 2015, 
                                    value = c(2011, 2015),
                                    format="####"),
                        uiOutput("cattypeControls"),
                        actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
                        actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
                      ),
                      
                      mainPanel(
                        tabsetPanel(
                          
                          # Data by state
                          tabPanel(p(icon("map-marker"), "By state"),
                                   column(3,
                                          wellPanel(
                                            radioButtons(
                                              "PerformanceCategory",
                                              "Performance category:",
                                              c("Sales" = "sales", "Profits" = "profits", "Customers" = "customers")),
                                            align = "top"  )
                                   ),
                                   column(7,
                                          plotOutput("metricImpactByState")
                                         
                                   )
                                   
                          ),
                          
                          # Time series data
                          tabPanel(p(icon("line-chart"), "By year"),
                                   h4('Sales Trend by year', align = "center"),
                                   showOutput("salesByYear", "nvd3"),
                                   h4('Impact of Sales & Customers on Profit by year', align = "center"),
                                   showOutput("metricImpact", "nvd3")
                                   
                          ),
                          
                          
                          
                          # Data 
                          tabPanel(p(icon("table"), "Data"),
                                   dataTableOutput(outputId="table"),
                                   downloadButton('downloadData', 'Download')
                          )
                        )
                      )
                      
             ),
             
             tabPanel("About",
                      mainPanel(
                        includeMarkdown("include.md")
                      )
             )
  )
)