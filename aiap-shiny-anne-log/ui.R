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
    
    div(tags$h1("Hi Anne! How are you today?")),
    
    fluidRow(column(width = 6,
                    box(width = NULL, status = "warning",
                        dateInput('date',
                                  label = 'Date input: (yyyy-mm-dd)',
                                  value = Sys.Date(),
                                  format = "dd/mm/yyyy"
                        ),
                        timeInput("time1", "Time:", value = Sys.time()),
                        sliderInput("numMarker", "On the scale of 1 to 7, how are you feeling?:",
                                    min = 1, max = 7,
                                    value = 4),
                        actionButton("submitButton", "Submit Entry"),
                        p(""),
                        p("Click this button to submit your entry.")
                    )),
             column(width = 6,
                    box(width = NULL, status = "warning",
                        textAreaInput("logText1", "Hi Anne! How are you feeling today?", "", width = "750px", height = "400px")
                    ))
             )
    
    )
  
  
)
