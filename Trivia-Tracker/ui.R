#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


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
      data <- sapply(fields, function(x) input[[x]])
      data
    })
    
    # When the Submit button is clicked, save the form data
    observeEvent(input$submit, {
      save_data_flatfile <- function(responses) {
        data <- t(responses)
        file_name <- sprintf("%s_%s.csv", as.integer(Sys.time()), digest::digest(data))
    # Write the file to the local system
        write.csv(responses, file = file.path(outputDir, file_name), 
                  row.names = FALSE, quote = TRUE)
      }
      save_data_flatfile(formData())
    })
    
    # Show the previous responses
    # (update with current response when Submit is clicked)
    # output$responses <- DT::renderDataTable({
    # input$submit
    #  loadData()
         
  }
)