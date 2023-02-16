#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$decol <- renderUI({
    yvals <- input$yvals
    ylabels <- paste0('ycol_',yvals)
    selectInput("ycols4",
                    " Colors",
                    choices = defaultpalette,
                    selected = defaultpalette[1],
                    multiple = TRUE)})

    output$distPlot <- renderPlotly({

      yvals<-input$yvals;
      ycols<-names(input) %>% grep('^ycol',.,val=TRUE) %>%
        sapply(function(ii){input[[ii]]});
      if(length(yvals) == 3) browser();
      ggplotly(ggplot(data1,aes(x=reporting_date))+
                 mapply(makegeomline,yvals,ycols)) %>%
        layout(dragmode = 'select') %>%
        event_register('plotly_click')
    })

})


#renderUI for matching number of variables to colors

#ChatGPT output
#defaultpalette <- c("red", "green", "blue")
#selected <- defaultpalette[1]

#uiOutput("ycols3_ui")

#server <- function(input, output, session) {
  #output$ycols3_ui <- renderUI({
    #selectInput("ycols3",
#                "Plot Colors",
#                choices = defaultpalette,
#                selected = selected,
#                multiple = TRUE
#    )
#  })
#}

#shinyApp(ui, server)