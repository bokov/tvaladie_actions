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

    output$distPlot <- renderPlotly({
      #browser();
      yvals<-input$yvals;
      ycols<-c(input$color_1,defaultpalette)[seq_along(yvals)];
      ggplotly(ggplot(data1,aes(x=reporting_date))+
                 mapply(makegeomline,input$yvals,input$ycols)) %>%
        layout(dragmode = 'select') %>%
        event_register('plotly_click')
    })

})


#Can add some text and elements to the UI and see what it all does
#Can try and insert additional objects and things