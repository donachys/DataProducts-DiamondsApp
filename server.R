#server.R
#library(caret)
#library(rattle)
library(ggplot2)
library(caret)
rsq <- 0
shinyServer(function(input, output) {
  
  output$plot2 <- renderPlot({
    data1 <- switch(input$var1, 
                   "carat" = diamonds$carat,
                   "cut" = diamonds$cut,
                   "color" = diamonds$color,
                   "clarity" = diamonds$clarity,
                   "depth" = diamonds$depth,
                   "table" = diamonds$table,
                   "x" = diamonds$x,
                   "y" = diamonds$y,
                   "z" = diamonds$z)
    data2 <- switch(input$var2, 
                    "carat" = diamonds$carat,
                    "cut" = diamonds$cut,
                    "color" = diamonds$color,
                    "clarity" = diamonds$clarity,
                    "depth" = diamonds$depth,
                    "table" = diamonds$table,
                    "x" = diamonds$x,
                    "y" = diamonds$y,
                    "z" = diamonds$z)
    
    data <- data.frame(data1, data2, diamonds$price)#, data3,
    colnames(data) <- c(input$var1, input$var2, "price")# input$var3,
    inTrain <- createDataPartition(y=data$price,#4
                                   p=0.7, list=FALSE)
    training <- data[inTrain,]; 
    testing <- data[-inTrain,]
    #dim(training); dim(testing)
    modFitAll<- train(price ~ .,data=training,method="lm")
    output$rsq <- renderText({
      paste("R-squared: ", modFitAll$results$Rsquared)
    })
    output$plot1 <- renderPlot({
      qq <- qplot(testing[,input$var2],testing[,input$var1],color=price,data=testing)
      qq +  geom_smooth(method='lm',formula=y~x) + aes(group=1)
      qq +   xlab(input$var2) + ylab(input$var1)
    })
    pred <- predict(modFitAll, testing)
    qp <- qplot(price,pred,data=testing) + geom_smooth(method='lm',formula=y~x)
    qp + xlab("Actual Price (USD)") + ylab("Predicted Price (USD)")
  })
 
})