#' Aggregate dataset by state
#' 
#' @param dt data.table
#' @param year_min integer
#' @param year_max integer
#' @param evtypes character vector
#' @return data.table
#'
aggregate_by_state <- function(dt, year_min, year_max, salescat) {
  replace_na <- function(x) ifelse(is.na(x), 0, x)
  round_2 <- function(x) round(x, 2)
  
  states <- data.table(STATE=sort(unique(dt$STATE)))
  
  aggregated <- dt %>% filter(YEAR >= year_min, YEAR <= year_max, SALECAT %in% salescat) %>%
    group_by(STATE) %>%
    summarise_each(funs(sum), SALES:TOTCUST)
  
  # We want all states to be present even if nothing happened
  left_join(states,  aggregated, by = "STATE") %>%
    mutate_each(funs(replace_na), PROFIT:TOTCUST) %>%
    mutate_each(funs(round_2), QTY, TOTCUST)    
}

#' Aggregate dataset by year
#' 
#' @param dt data.table
#' @param year_min integer
#' @param year_max integer
#' @param evtypes character vector
#' @return data.table
#'
aggregate_by_year <- function(dt, year_min, year_max, salescat) {
  round_2 <- function(x) round(x, 2)
  
  # Filter
  dt %>% filter(YEAR >= year_min, YEAR <= year_max, SALECAT %in% salescat) %>%
    # Group and aggregate
    group_by(YEAR) %>% summarise_each(funs(sum), SALES:TOTCUST) %>%
    # Round
    mutate_each(funs(round_2), QTY, TOTCUST) %>%
    rename(
      Year = YEAR, Sales = SALES,
      Profit = PROFIT, Customers = CUSTOMERS,
      Quantity = QTY, Total = TOTCUST
    )
}

#' Dereive Perfromancecolumn based on category
#'
#' @param dt data.table
#' @param category character
#' @return data.table
#'
compute_affected <- function(dt, category) {
  dt %>% mutate(Metric = {
    if(category == 'sales') {
      SALES
    } else if(category == 'profits') {
      PROFIT
    }
    else if(category == 'customers') {
      CUSTOMERS
    } 
    
    else { SALES
      
    }
  })
}

#' Prepare map of Performance Metric & Prouct Category impact -(1)
#' 
#' @param dt data.table
#' @param states_map data.frame returned from map_data("state")
#' @param year_min integer
#' @param year_max integer
#' @param fill character name of the variable
#' @param title character
#' @param low character hex
#' @param high character hex
#' @return ggplot
#' 
plot_impact_by_state <- function (dt, states_map, year_min, year_max, fill, title, low = "#fff5eb", high = "#d94801") {
  title <- sprintf(title, year_min, year_max)
  p <- ggplot(dt, aes(map_id = STATE))
  p <- p + geom_map(aes_string(fill = fill), map = states_map, colour='black')
  p <- p + expand_limits(x = states_map$long, y = states_map$lat)
  p <- p + coord_map() + theme_bw()
  p <- p + labs(x = "Long", y = "Lat", title = title)
  p + scale_fill_gradient(low = low, high = high)
}

#' Prepare plots of performance by year - (3)
#'
#' @param dt data.table
#' @param dom
#' @param yAxisLabel
#' @param desc
#' @return plot
#' 
plot_impact_by_year <- function(dt, dom, yAxisLabel, desc = FALSE) {
  impactPlot <- nPlot(
    value ~ Year, group = "variable",
    data = melt(dt, id="Year") %>% arrange(Year, if (desc) { desc(variable) } else { variable }),
    type = "stackedAreaChart", dom = dom, width = 650
  )
  impactPlot$chart(margin = list(left = 100))
  impactPlot$yAxis(axisLabel = yAxisLabel, width = 80)
  impactPlot$xAxis(axisLabel = "Year", width = 70)
  
  impactPlot
}

#' Prepare plot of total sales by year (2)
#'
#' @param dt data.table
#' @param dom
#' @param yAxisLabel
#' @return plot

plot_sales_by_year <- function(dt, dom = "salesByYear", yAxisLabel = "Sales") {
  salesByYear <- nPlot(
    Sales ~ Year,
    data = dt,
    type = "lineChart", dom = dom, width = 650
  )
  
  salesByYear$chart(margin = list(left = 100))
  salesByYear$yAxis( axisLabel = yAxisLabel, width = 80)
  salesByYear$xAxis( axisLabel = "Year", width = 70)
  salesByYear
}

#' Prepare dataset for downloads
#'
#' @param dt data.table
#' @return data.table
prepare_downloads <- function(dt) {
  dt %>% rename(
    State = STATE, Sales = SALES,
    Customers = CUSTOMERS, Profit = PROFIT,
    Quantity = QTY, Total = TOTCUST
  ) %>% mutate(State=state.abb[match(State, tolower(state.name))])
}