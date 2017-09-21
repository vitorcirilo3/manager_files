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
  observeEvent(input$uploadFilesBtn, {
    
    if(!is.null(input$uploadDataFiles)){
      dataFiles <- input$uploadDataFiles %>% fixUploadedFilesNames
      
      list_files = list()
      
      for(i in 1:length(input$uploadDataFiles[,1])){
        # file_name_input <- list_files[[i]]
        # file_name_input2 <- list_2[i]
        
        Sys.sleep(0.1)
        print(dataFiles$name[i])
        
        kaiju_taxonpath_input <- paste0(dataFiles$datapath[i])
        
        taxon <- read.delim2(kaiju_taxonpath_input, sep="\t", header = FALSE, stringsAsFactors=F)
        
        
        
        
      }
    }
    
  })
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)