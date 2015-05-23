library(shiny) 
library(caret)
library(rpart)
library(rattle)
library(rpart.plot)
library(randomForest)
require(rCharts)

# LOAD DATA AND CLEANUP
data<- read.csv("adult.csv", header = TRUE)
data$income = as.factor(data$income)
fit<- rpart(income ~ ., data = data)
imp<- varImp(fit)
impCols<-c(rownames(imp)[order(imp$Overall, decreasing=TRUE)[1:5]], "income")
datafit<-data[,impCols] # only select the 5 most important predictors + Class
fit2<- rpart(income ~., data = datafit)

shinyServer(
  function(input, output) {
    output$oid1 <- renderText({input$Education})  
    output$oid2 <- renderText({input$rel})
    output$oid3 <- renderText({input$marStat})
    output$oid4 <- renderText({input$occu})
    output$oid5 <- renderText({input$cap})
    
    output$prediction <- renderPrint({
      m <- data.frame( capital_gain = as.numeric(input$cap), education = input$Education,
                       occupation = input$occu , relationship = input$rel, 
                       marital = input$marStat)
      n<- predict(fit2, m, type="class") 
      n[[1]]
    })
    
    output$newplot1 <- renderChart({ 
      dat<-subset(datafit, (capital_gain>input$range[1] & capital_gain<input$range[2] ))
      n1 <- rPlot(capital_gain ~ occupation, color = 'income', type = 'point', data =dat)
      n1$set(title="Income for capital gain, by education-level",
             width = 650, height = 350)
      n1$addParams(dom = 'newplot1')
      return(n1)
    })
    
    output$newplot2 <- renderPlot({ 
      fancyRpartPlot(fit)
    })
    
  }
)

