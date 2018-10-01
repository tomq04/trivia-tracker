#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# if (!require("DT")) install.packages('DT')
library(DT)

# Define the fields we want to save from the form
fields <- "name"
outputDir <- "Responses"

# Shiny app with 3 fields that the user can submit data for
shinyApp(
  ui = fluidPage(
    DT::dataTableOutput("responses", width = 300), tags$hr(),
    textInput("name", "Name", ""),
    actionButton("submit", "submit")
  ),
  server = function(input, output, session) {
    
    # Whenever a field is filled, aggregate all form data
    formData <- reactive({
      data <- sapply(fields, function(t) input[[t]])
      data
    })
    
    #load data function, if already written then load it back in
    loadData <- function() {
      if (exists("responses")) {
        responses
      }
    }
    
    # When the Submit button is clicked, save the form data
    observeEvent(input$submit, {
      save_data_flatfile <- function(responses) {
        data <- c(responses)
        file_name <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
        
    # Show the previous responses
    # (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
      input$submit
      loadData()})
        
    # Write the file to the local system
        write.csv(responses, file = file.path(outputDir, file_name), 
                  row.names = FALSE, quote = TRUE)
      }
      save_data_flatfile(formData())
    })
    

         
  }
)
