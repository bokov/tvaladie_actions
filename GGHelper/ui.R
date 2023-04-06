library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Select a dataset", choices = data_choices),
      uiOutput("column_selection_x"),
      uiOutput("column_selection_y")
    ),
    mainPanel(
      h3("Column Selection"),
      DT::DTOutput("table"),
      plotOutput('myplot')
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