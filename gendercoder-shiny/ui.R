library(shiny)
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Gendercoder app"),
    dashboardSidebar(
        fileInput("file1", "Choose data File",
                  multiple = FALSE,
                  accept = c("text/csv",
                             "text/comma-separated-values,text/plain",
                             ".csv", 
                             ".dta", 
                             ".sav"))
    ),
    dashboardBody(
        tableOutput("out1")
    )
)
