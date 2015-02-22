#ui.R
library(ggplot2)
shinyUI(fluidPage(
  titlePanel("Features of Diamond Prices"),
  
  sidebarLayout(
    sidebarPanel(
     selectInput("var1", 
                 label = "Choose feature 1",
                 choices = names(diamonds)[-7],
                 selected = names(diamonds)[-7][1]),
     selectInput("var2", 
                 label = "Choose feature 2",
                 choices = names(diamonds)[-7],
                 selected = names(diamonds)[-7][2]),
    textOutput("rsq"),
    h3("Using this App"),
    p("This app uses the diamonds data set of ggplot2.
      The data includes price and 9 other features of about ~50k diamonds, they are:"),
      p("carat - the carat weight of the diamond"),
      p("cut - the cut quality"),
      p("color - diamond color rating"),
      p("clarity - measurement of how clear the diamond is"),
      p("x - length in mm"),
      p("y - width in mm"),
      p("z - depth in mm"),
      p("depth - (2 * z / (x + y))"),
      p("table - width of top of diamond relative to widest point"),
      p("Use this app to select two features for comparison. The top plot 
        shows feature 1 on the vertical axis and feature 2 on the horizontal axis.
        A linear model is fit to these features with price and the bottom plot shows
        the result of predicting using these features and a linear model against the
        actual price of the diamond. A perfect model would have slope of 1 in the bottom
        plot. An R-squared value is provided to indicate how good these features are at
        explaining the price data.")
    ),
    
    
     mainPanel("Plot of Feature 1 and Feature 2 with price",
               plotOutput("plot1"),
               h5("Prediction versus Actual Price"),
               plotOutput("plot2")
               
               )
    
  )
))