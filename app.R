library(shiny)
library(shinyjs)
library(googlesheets4)

vasSheetUrl <- "your_sheet_URL"

# Define UI ----
ui <- fluidPage(
    
    # for disabling the action buttons need useShinyjs()
    useShinyjs(),
    
    fluidRow(
        column(10, offset = 1,
               titlePanel("VAS pain")
        )
    ),
    
    fluidRow(
        column(4, offset = 1,
               textInput(inputId = "studyID", label = "Researcher to enter Study ID:",
                         value = "")
        )
    ),
    
    fluidRow(
        column(10, offset = 1,
               tags$br(),
               tags$br(),
               tags$br(),
               strong("Use the scale below to indicate your usual pain for the last week."),
               tags$br(),
               tags$br(),
               strong("0 being no pain and 10 being the worst pain imaginable."),
               tags$br(),
               tags$br()
        )
    ),
    
    wellPanel(
        fluidRow(
            column(1, offset = 1,
                   tags$br(),
                   strong("No Pain")),
            column(6,tags$br(),
                   sliderInput(
                       inputId = "vas_score",
                       label = NULL,
                       min = 0,
                       max = 10,
                       value = 5,
                       step = 0.1,
                       width = '420px'
                   )
            ),
            column(1, tags$br(),
                   strong("Worst Pain"))
        )
    ), 
    
    fluidRow(
        column(10, offset = 1,
               tags$br(),
               tags$br(),
               tags$br(),
               disabled(actionButton("confirmButton", "Confirm")),
        )
    ),
    
    fluidRow(
        column(10, offset = 1,
               tags$br(),
               tags$br(),
               tags$br(),
               tableOutput("tableValues")
        )
    ),
    
    fluidRow(
        column(10, offset = 1,
               tags$br(),
               tags$br(),
               tags$br(),
               disabled(actionButton("submitButton", "Submit")),
        )
    )
)

# Define server logic ----
server <- function(input, output) {
    
    studyID <- reactive(input$studyID)
    submitReady <- reactiveValues(ok = FALSE)
    
    # Reactive expression to create data frame of all input values ----
    inputVals <- eventReactive(input$confirmButton, {
        data.frame(
                    studyID = studyID(),
                    VASscore = input$vas_score,
                    # date string will always have length 24
                    # e.g., "Fri Aug 20 11:11:00 1999"
                    Date = date(),
                    stringsAsFactors = FALSE)
    })
    
    # studyID input, if empty disable all buttons, if changes, disable submit button
    observeEvent(input$studyID, {
        if (nchar(trimws(studyID())) != 0 ) {
            enable("confirmButton")
            disable("submitButton")
            submitReady$ok <- TRUE
        }
        else{
            disable("confirmButton")
            disable("submitButton")
            submitReady$ok <- FALSE
        }
    })
    
    # if slider input changes, disable submit button ----
    observeEvent(input$vas_score, {
        disable("submitButton")
    })
    
    # Show the values in an HTML table ----
    output$tableValues <- renderTable({
        inputVals()
    })
    
    # enable submit button after confirm button is pressed
    observeEvent(input$confirmButton, {
        output$showTable <- renderTable({
            inputVals()
        })
        toggleState(id = "submitButton", condition = submitReady$ok == TRUE)
    })

    # append to the Googlesheet
    observeEvent(input$submitButton, {
        vasSheetUrl %>%
            sheet_append(inputVals(), sheet = 1)
    })
}

shinyApp(ui, server)