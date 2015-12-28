library(shiny)

# Plotting 
library(ggplot2)
library(rCharts)
library(ggvis)

# Data processing libraries
library(data.table)
library(reshape2)
library(dplyr)

# Required by includeMarkdown
library(markdown)

# It has to loaded to plot ggplot maps on shinyapps.io
library(mapproj)
library(maps)

# Load helper functions
source("helpers.R", local = TRUE)


# Load data
states_map <- map_data("state")
dt <- fread('data/ssorders.agg.csv') 
salescat <- sort(unique(dt$SALECAT))


# Shiny server 
shinyServer(function(input, output, session) {
  
  # Define and initialize reactive values
  values <- reactiveValues()
  values$salescat <- salescat
  
  # Create Product Category Selector type checkbox
  output$cattypeControls <- renderUI({
    checkboxGroupInput('salescat', 'Product Category', salescat, selected=values$salescat)
  })
  
  # Add observers on clear and select all buttons
  observe({
    if(input$clear_all == 0) return()
    values$salescat <- c()
  })
  
  observe({
    if(input$select_all == 0) return()
    values$salescat <- salescat
  })
  
  # Prepare datasets
  
  # Prepare dataset for maps
  dt.agg <- reactive({
    aggregate_by_state(dt, input$range[1], input$range[2], input$salescat)
  })
  
  # Prepare dataset for time series
  dt.agg.year <- reactive({
    aggregate_by_year(dt, input$range[1], input$range[2], input$salescat)
  })
  
  # Prepare dataset for downloads
  dataTable <- reactive({
    prepare_downloads(dt.agg())
  })
  
  # Render Plots
  
  # Metrics By Category & State
  output$metricImpactByState <- renderPlot({
    print(plot_impact_by_state (
      dt = compute_affected(dt.agg(), input$PerformanceCategory),
      states_map = states_map, 
      year_min = input$range[1],
      year_max = input$range[2],
      title = "Performance by State",
      fill = "Metric"
    ))
  })
  
  # Sales Performance by year
  output$salesByYear <- renderChart({
    plot_sales_by_year(dt.agg.year())
  })
  
  # Impact if Customers & Sales over Profit
  output$metricImpact <- renderChart({
    plot_impact_by_year(
      dt = dt.agg.year() %>% select(Year, Profit, Customers,Sales),
      dom = "metricImpact",
      yAxisLabel = "Metric",
      desc = TRUE
    )
  })
  

  # Render data table and create download handler
  output$table <- renderDataTable(
    {dataTable()}, options = list(bFilter = FALSE, iDisplayLength = 50))
  
  output$downloadData <- downloadHandler(
    filename = 'data.csv',
    content = function(file) {
      write.csv(dataTable(), file, row.names=FALSE)
    }
  )
})