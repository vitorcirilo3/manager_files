##instalation
#install.packages("shinydashboard")
#install.packages("shinyjs")





## app.R ##
library(shinydashboard)
library(rsconnect)
library(shiny)
library(shinyjs)



ui <- dashboardPage(
  dashboardHeader(title = "Manager Files"),
  dashboardSidebar(
    sidebarMenu(
      #menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("out_final to matrix", tabName = "widgets", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              )
      ),
      
      # Second tab content
      tabItem(tabName = "widgets",
              h2("Select files to convert to matrix"),
              div(id = "div_uploadDataFiles",
                  fileInput(
                    "uploadDataFiles", 
                    div("Taxonomic files"),
                    multiple = TRUE,
                    accept = c(
                      'names.out'
                    )
              )),
                actionButton(
                  "uploadFilesBtn",
                  "Upload data",
                  class = "btn-primary"
                ),
                actionButton(
                  "GoSampleBtn",
                  "Go",
                  class = "btn-primary"
                )

      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)