#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$decol <- renderUI({
    yvals <- input$yvals
    ylabels <- paste0('ycol_',yvals)
    sapply(yvals,function(ii){
      colourInput(paste0('ycol_',ii),paste0(ii,' color'),
                  value = '#000000',allowTransparent = TRUE)},
      simplify=FALSE)
    })

  output$DT1 <- DT::renderDataTable(
    {data1$myselection <- FALSE
    selection <- unique(event_data('plotly_selected')$pointNumber)
    data1$myselection[selection] <- TRUE
    data1 <- relocate(data1,myselection)
    datatable(data1,
              options = list(scrollX = TRUE,
                             scrollY = "400px",
                             scrollCollapse = TRUE,
                             paging = FALSE,
                             dom = 'Bfrtip',
                             buttons = c('copy', 'csv', 'excel', 'pdf', 'print', 'colvis')
              ),
              selection = list(mode = 'multiple', target = 'row',
                               selected = selection),
              extensions = 'Buttons',
              filter = 'top')})

    output$distPlot <- renderPlotly({

      yvals <- input$yvals
      #browser()
      ycols <- names(input) %>% grep('^ycol_',.,val=TRUE) %>%
       sapply(function(ii){input[[ii]]});
      #browser()
      ggplotly(ggplot(data1,aes(x=reporting_date))+
                 mapply(makegeomline,yvals,ycols)+
                 mapply(makegeompoint,yvals))%>%
        layout(dragmode = 'select') %>%
        event_register('plotly_selected')
    })
    #observeEvent(event_data('plotly_selected'),{browser()})
})

#renderUI for matching number of variables to colors#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#renderUI for matching number of variables to colors