#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(shinyBS)
library(colourpicker)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Theme
    theme = bs_theme(primary = "#000000", secondary = "#F54913",
                     font_scale = NULL, bootswatch = "flatly"),

    # Application title
    titlePanel("Bexar County COVID cases"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("yvals",
                        "Plot Values",
                        choices = names(data1)[-(1:3)],
                        selected = names(data1)[4],
                        multiple = TRUE
                        ),
            uiOutput('decol')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("distPlot"),
            DT::dataTableOutput(outputId = 'DT1', width = '90%')
        )
    )
))

#outputUI to match renderUI and select number of colors to match number of variables