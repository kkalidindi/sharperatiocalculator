library(shiny)

shinyUI(fluidPage(
  titlePanel("Sharpe Ratio Calculator"),

  sidebarLayout(
    sidebarPanel(
      helpText("Type in a valid stock ticker, choose risk-free return
               rate & select date range to use for calculations"),

      textInput("symb", "Symbol", "GOOG"),
      sliderInput("return", "Risk-free return %", 1, 5, 3),
      dateRangeInput("dates",
        "Date range",
        start = "2010-01-01",
        end = as.character(Sys.Date())),

      br()

    ),

    mainPanel(
      textOutput("inputs"),

      br(),

      tableOutput("results"),

      p(em("What is 'Sharpe Ratio'?")),

      p(em("The Sharpe Ratio is a measure for calculating risk-adjusted
           return. It was developed by Nobel laureate William F. Sharpe.")),

      p(em("The Sharpe ratio is the average return earned in excess of the
            risk-free rate per unit of volatility or total risk. Subtracting
            the risk-free rate from the mean return, the performance associated
            with risk-taking activities can be isolated. Generally, the greater
            the value of the Sharpe ratio, the more attractive the risk-adjusted
            return."))

  )
)))
