library(shiny)
library(haven)
library(gendercoder)
library(dplyr)


shinyServer(function(input, output) {

    output$out1 <-  renderTable({
        req(input$file1)
        
        if (grepl(".sav$", input$file1$name)) df <- read_sav(input$file1$datapath) 
        if (grepl(".dta$", input$file1$name)) df <- read_dta(input$file1$datapath) 
        if (grepl(".csv$", input$file1$name)) df <- read_csv(input$file1$datapath) 
       
        head((df))
        })
    
   
})
