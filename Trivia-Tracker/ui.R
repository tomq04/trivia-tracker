#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

## Only run examples in interactive R sessions
if (interactive()) {
  
  ui <- fluidPage(
    textInput("caption", "Caption", "Data Summary"),
    verbatimTextOutput("value")
  )
  server <- function(input, output) {
    output$value <- renderText({ input$caption })
  }
  shinyApp(ui, server)
}
