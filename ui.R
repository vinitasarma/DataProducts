library(shiny)
library(rpart)
library(rattle)
library(rpart.plot)
require(rCharts)

shinyUI(fluidPage(
  titlePanel("Developing Data Products Project"),
  sidebarLayout(
    sidebarPanel(
      
      helpText(strong('Instructions:')),
      helpText('In order to make the problem simpler, only the most relevant predictors of the dataset have been selected.'),
      br(),
      helpText('You have to choose the values for the variables shown, in order to predict the income 
               level. The app is reactive. At the end of the page there is a plot of the Decision Tree Implemented that describes how the algorithm makes the final  
               classification.'),
      br(),
      h4('Variables to be selected:'),      
      sliderInput('cap', 'capital_gain', 
                  value = 1, min = 0, max = 100000, step = 10,),      
      radioButtons('Education', "Education",
                   choices = list("Associates" = "Associates", "Bachelors" = "Bachelors", "Doctorate" = "Doctorate",
                                  "Dropout" = "Dropout", "Masters" = "Masters", "HS-grad" ="HS-grad", "HS-Graduate" = "HS-Graduate",
                                  "Prof-School" = "Prof-School"), selected = "Bachelors"),
      radioButtons('Sex', "Sex",
                   choices = list("Female" = "Female", "Male" = "Male"), selected = "Female"),
      
      radioButtons('rel', "Relationship",
                   choices = list("Not-in-family" = "Not-in-family", "Husband" = "Husband", "Wife" = "Wife",
                                  "Own-child" = "Own-child", "Unmarried" = "Unmarried", "Other-relative" = "Other-relative"), 
                   selected = "Not-in-family"),
      
      radioButtons('marStat', "Marital Status",
                   choices = list("Married" = "Married", "Never Married" = "Never-Married", "Not Married" = "Not-Married",
                                  "Widowed" = "Widowed"), selected = "Married"),
      radioButtons('occu', "Occupation",
                   choices = list("Admin" = "Admin", "White-Collar" = "White-Collar", "Professional" = "Professional",
                                  "Service" = "Service", "Sales" = "Sales", "Other-Occupations" ="Other-Occupations", "Military" = "Military"
                                  ), selected = "Admin"),
      
      
      br(),
      br()
      
      
      ),
    
    mainPanel(
      h3('Prediction of Income Level'),
      p("This project predicts if a person with a certain attributes has an income over $50k. The training dataset has been taken from", a("Adult
        dataset in the UCI Machine Learning repository", href = "http://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"), 
        "This dataset has initially been preprocessed by cleaning the factor attributes. The next step was to set fewer predictors based on variable importance 
      values from an initial classification. The algorithm classifies income earned, as >50K (1) or <50K (0)"),
      h4("Dataset description:"),
      p("This dataset has two classes for income level: 1(>50k) or 0(<50K). The predictors are the variables you see on the left: 
        education, marital status, occupation, relationship and capital gain. Other than Capital Gain,
        all others are factor variables."),
      
      br(),  
      br(),
      h5('Values Selected:'), 
      h6('You entered education level:'), 
      verbatimTextOutput("oid1"),
      h6('You entered relationship'), 
      verbatimTextOutput("oid2"),
      h6('You entered marital status'), 
      verbatimTextOutput("oid3"),
      h6('You entered occupation'), 
      verbatimTextOutput("oid4"),
      h6('You entered capital gain'),
      verbatimTextOutput("oid5"),
      h4(strong('Predicted Income level'), style = "color:red"),
      verbatimTextOutput("prediction"),
      
      br(),
      
      h3('Plot for studying capital gain by occupation'),
      p("Capital Gain vs Occupation, colored by Income"),
    helpText(" select the range of capital gain"),
    sliderInput("range", 
                label = "Range of Age of interest:",
                min = 1, max = 9999, value = c(2000, 4000)),
    br(),
    showOutput("newplot1", "polycharts"),    
    br(),
    br(),
    
    h3('Decision Tree Graph'),
    p('An Rpart tree has been used to implement the prediction algorithm.'),
    plotOutput('newplot2')
    
    )
  )
))
