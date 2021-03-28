library(shiny)
library(haven)
library(gendercoder)
library(dplyr)
library(DT)
library(rlang)
library(stringr)
library(readr)

shinyServer(function(input, output) {

    df <- reactive({
        req(input$file1)
        
        inFile <- input$file1
        if (is.null(inFile)) return(NULL)
        
        if (grepl(".sav$", inFile$name)) df <- read_sav(inFile$datapath) 
        if (grepl(".dta$", inFile$name)) df <- read_dta(inFile$datapath) 
        if (grepl(".csv$", inFile$name)) df <- read_csv(inFile$datapath) 
        
        # work out how to use recode_gender(!!sym(input$vars), dictionary = !!sym(input$dictionary)) here
         df #%>% mutate(coded_gender = recode_gender(.data[[input$vars]], dictionary = !!sym(input$dictionary)))
        
        })
    
    # Generate the gender selection
    output$varselect <- renderUI({
        
        # Variable selection:    
        selectInput("vars", "Gender Column:",
                    names(df()), names(df()), multiple = FALSE)            
    })
    
    # Create the output data
    
    output$downloadData <- downloadHandler(
        
      filename = function() {
        paste(sub(".sav|.csv|.dta", "", input$file1$name), "_coded",  input$dlformat, sep='')
      },
      content = function(file) {
          
          if (input$dlformat == ".csv") write_csv(df(), file)
          if (input$dlformat == ".sav") write_sav(df(), file)
          if (input$dlformat == ".dta") write_dta(df(), file)
      }
    )
    
    output$out1 <-  renderDT({df()})
    
       
})

