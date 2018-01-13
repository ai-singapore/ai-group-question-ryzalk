library(shiny)
library(shinydashboard)
library(data.table)
library(plyr)
library(DT)
library(shinyjs)
library(shinyTime)

# Define UI for application that draws a histogram
dashboardPage(
  
  # Title on browser tab
  title = "AIAP Group 6",
  
  # UI overall skin colour
  skin = "black",
  
  dashboardHeader(),
  
  # Enable dashboard sidebar
  dashboardSidebar(disable = TRUE),
  
  # Dashboard body
  dashboardBody(
    
    # Use shinyJS
    useShinyjs(),
    
    div(tags$h1("Anne's Dashboard")),
    
    fluidRow(column(width = 6,
                    box(width = NULL, status = "warning",
                        div(tags$h3("Anne's Feeling Index")),
                        plotOutput("plot1")
                      
                    )),
             column(width = 6,
                    box(width = NULL, status = "warning",
                        div(tags$h3("Anne's Sentiment")),
                        plotOutput("wordPlot")
                    ))
    )
    
  )
  
  
)
