library(shiny)
library(ggplot2)
library(DT)
library(plotly)
library(dplyr)

server <- function(input, output) {
  dataset <- reactive({
    #selected_data <- data_list[as.integer(input$dataset),]
    sprintf("data('%s', package='%s', envir = data_catch)",ChosenData()$Item,ChosenData()$Package) %>% parse(text = .) %>% eval
    #as.data.frame(get(selected_data['Item'], paste0('package:',selected_data['Package'])))
    as.list(data_catch)[[ChosenData()$Item]]
  })

  output$column_selection_x <- renderUI({
    if (is.null(dataset())) return()
    selectInput("x_var", "Select X variable", choices = names(dataset()))
  })

  output$column_selection_y <- renderUI({
    if (is.null(dataset())) return()
    selectInput("y_var", "Select Y variable", choices = names(dataset()))
  })

  output$table <- DT::renderDT({
    req(data <- dataset(), x_var <- input$x_var, y_var <- input$y_var, !all(c(x_var,y_var) %in% data))
    # req(!is.null(dataset()),all(c(input$x_var, input$y_var) %in% names(dataset())))
    DT::datatable(data[, c(x_var,y_var)])
  })

  plotcode <- reactive({
    req(data <- ChosenData()$Item, x_var <- input$x_var, y_var <- input$y_var,
        color_var <- input$color_var, geoms <- input$geoms)
    code <- sprintf('ggplot(%s,aes(x=%s,y=%s,col=%s))'
                    ,data, x_var, y_var, color_var);
    paste(code,'+',geoms);
  });

  ChosenData <- reactive({
    data_list[as.integer(input$dataset),]
  })

  output$plot_color <- renderUI({
    if (is.null(dataset())) return()
    selectInput("color_var", "Plot_color", choices = names(dataset()))
  })

  observe({req(input$debug); if(input$debug>0) browser()
    })

  output$GGPlotCode <- renderText({req(code<-plotcode()); code})

  output$myplot <- renderPlot({
    req(code<-plotcode());
    eval(parse(text=code),envir = data_catch);
  })
}


#For next week also add a ui.R output and server.R for selecting color, and other aes() functions
#May want to create additional geom menu that allows you to select point, line, etc
#Later Analyze what geometry has been chosen and automatically override selections that
#won't function within the specific visualization
#Also put in process such that when you push changes to Git it automatically updates Shiny App

# 4/20 class - for next week, add size as one of the dimensions (hopefully will break geom line or
# it will ignore it)