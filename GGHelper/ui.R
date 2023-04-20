library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      #How to create a button that is dependent on some condition
      if (file.exists('debug')) actionButton('debug','debug') else '',
      selectInput("dataset", "Select a dataset", choices = data_choices),
      uiOutput("column_selection_x"),
      uiOutput("column_selection_y"),
      #uiOutput("plot_selection"),
      uiOutput("plot_color"),
      selectInput("geoms", "Select plot", choices = c('geom_point()','geom_line()'))
    ),
    mainPanel(
      h3("Column Selection"),
      plotOutput('myplot'),
      textOutput('GGPlotCode'),
      DT::DTOutput("table")
    )
  )
)

# All current datasets
# data()
#
# All current datasets, but gives results so can be coded
# data()$results
#
# All available datasets
# data(package = .packages(all.available = TRUE))