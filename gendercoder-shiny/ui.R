library(shiny)
library(shinydashboard)
library(DT)

dashboardPage(
    dashboardHeader(title = "Gendercoder app"),
    dashboardSidebar(
        fileInput("file1", "Choose data File",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv", 
                             ".dta", 
                             ".sav"), 
                placeholder = ".dta, .sav, or .csv"),
        
        
        
        # Control
        radioButtons("dictionary", "Coding dictionary:",   
                     choiceValues = c("broad", 'narrow'),
                     choiceNames = c("Broad", 'Narrow'),
                     selected = "broad"), 
        
        # Variable selection:
        htmlOutput("varselect")
        
    ),
    dashboardBody(
        
        DTOutput("out1")
    )
)
