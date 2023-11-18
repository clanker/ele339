#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

element_choices <- c("R", "C")

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("R-C Filter Bode Plots"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            radioButtons("type_s1", "Type for element #1", element_choices,
                         inline = TRUE, selected = "R"),
            numericInput("value_s1", "Value for element #1", value = 1000),
            #radioButtons("type_s2", "Type for series #2", element_choices,
            #             inline = TRUE, selected = "C"),
            numericInput("value_s2", "Value for element #2", value = 1e-6),
            width = 3
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("magPlot"),
            plotOutput("phasePlot")
        )
    )
)
