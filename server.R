# server.R

library(quantmod)

shinyServer(function(input, output) {
      ohlcdata <- reactive({
        getSymbols(input$symb, src = "yahoo",
        from = input$dates[1],
        to = input$dates[2],
        auto.assign = FALSE)
      })
      yearly <- reactive({
        yearlyReturn(ohlcdata())
      })
      excess <- reactive({
        yearly() - ((input$return/100))
      })
      average <- reactive({
        mean(excess())*100
      })
      stdev <- reactive({
        sd(excess())*100
      })
      sharpe <- reactive({
        average()/stdev()
      })
      output$inputs <- renderText({
        paste("For the stock symbol ", input$symb, ", assuming a
              risk-free rate of", input$return, "% and using daily
              stock closing price data over the period ", input$dates[1],
              " to ", input$dates[2], "we calculated:")
      })
      output$results <- renderTable(
        data.frame(Metric=c("Average Excess
                            Return over risk-free rate (%)",
                            "Standard Deviation of Excess Returns",
                            "Sharpe Ratio (Avg. Excess Return / Std. Dev.)"),
                   Value=c(average(),stdev(),sharpe())))
  })

