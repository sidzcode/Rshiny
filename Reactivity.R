library(shiny)


ui <- fluidPage(
  
  
  titlePanel("Reactivity"),
  
  
  sidebarLayout(
    sidebarPanel(
      
      
      textInput(inputId = "caption",
                label = "Caption:",
                value = "Data Summary"),
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("rock", "pressure", "cars")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 10)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      h3(textOutput("caption", container = span)),
      
      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary"),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
      
    )
  )
)

# Define server logic to summarize and view selected dataset ----
server <- function(input, output) {
  
 
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  
  output$caption <- renderText({
    input$caption
  })
  
  
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
