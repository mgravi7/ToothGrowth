#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # TITLE
  h1("Tooth Growth Analysis Interactive Experiment"),
  
  # EXPLORATION
  h3("Data Exploration"),
  
  # help text and plot type selection
  p("The below plot is based on the ToothGrowth data in the R datasets package. 
Y axis shows the tooth length and X axis shows the dosage.",
span("Orange Juice (OJ) and Vitamin C (VC) are the two supplements used in the study.",
     style = "color:blue")),
  p(em(span("Experiment with different Plot types to explore the data.", style = "color:red"))),
  radioButtons("plotType", "Choose Plot type:",
                    c("Individual Data Points" = "IDP",
                      "Boxplot" = "BP"),
                    selected = "IDP"),
  
  plotOutput("doseToothPlot"),
  
  # HYPOTHESIS TESTING
  h3("Hypothesis Testing"),
  
  # confidence interval selection
  p("Let us test the hypothesis",
    span("the difference in means between Orange Juice and Vitamin C is not equal to 0.",
         style = "color:blue")),
  p(em(span("Experiment with different Confidence Intervals and validate the
hypothesis using Student's t-Test.", style = "color:red"))),
  radioButtons("ciValue", "Choose Confidence Interval:",
                            c("0.90" = "0.90",
                              "0.95" = "0.95"),
                            selected = "0.90"),
  strong("Results of Student's t-test calculations"),
  verbatimTextOutput("tTestResults")
))
