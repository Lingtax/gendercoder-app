library(shiny)
library(haven)
library(gendercoder)
library(dplyr)
library(DT)

shinyServer(function(input, output) {

    df <- reactive({
        req(input$file1)
        
        inFile <- input$file1
        if (is.null(inFile)) return(NULL)
        
        if (grepl(".sav$", inFile$name)) df <- read_sav(inFile$datapath) 
        if (grepl(".dta$", inFile$name)) df <- read_dta(inFile$datapath) 
        if (grepl(".csv$", inFile$name)) df <- read_csv(inFile$datapath) 
        
        # work out how to use recode_gender(input$vars, dictionary = sym(input$dictionary)) here
        df 
        
        })
    
    output$out1 <-  renderDT({df()})

    output$varselect <- renderUI({
        
        # Variable selection:    
        selectInput("vars", "Gender Column:",
                    names(df()), names(df()), multiple = FALSE)            
    })
    
       
})

