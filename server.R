#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(datasets)
data(ToothGrowth)
ToothGrowth$dose = as.factor(ToothGrowth$dose)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$doseToothPlot <- renderPlot({
    
    if (input$plotType == "IDP")
    {
        ## box plot
        g1 <- ggplot(ToothGrowth, aes(dose, len))
        g1 <- g1 + geom_point(color = "red", size = 2, shape = 15) +
        facet_grid(.~supp) +
           labs(x = "Dose (milligrams/day)") +
           labs(y = "Tooth length (mm)") +
           labs(title = "Effect of Supplement Type and Dose on Tooth Growth (individual data points)")
        return(g1)
    }
      
    if (input$plotType == "BP")
    {
        ## box plot
        g2 <- ggplot(data = ToothGrowth, aes(dose, len, fill = dose))
        g2 <- g2 + geom_boxplot(notch = F) +
            facet_grid(.~supp) +
            labs(x = "Dose (milligrams/day)") +
            labs(y = "Tooth length (mm)") +
            labs(title = "Effect of Supplement Type and Dose on Tooth Growth (box plot)")
        return(g2)
    }
      
    
  })
  
  output$tTestResults <- renderText({
    # run t.test
    confLevel = as.numeric(input$ciValue)
    res <- t.test(len ~ supp, data = ToothGrowth, conf.level = confLevel)
    
    # hyposthesis result
    total <- confLevel + res$p.value
    out <- ""
    if (total < 1)
      out <- "Hypothesis is TRUE"
    else
      out <- "Hypothesis is FALSE"
    out <- paste0(out, " for confidence interval: ", input$ciValue, ". ",
                 "(calculated p-value = ",
                 format(round(res$p.value, 3), nsmall = 3), ")")
    return(out)
  
  })
  
})
