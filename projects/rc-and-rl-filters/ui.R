#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# ===============
# ===  NOTES  ===
# ===============
#
# See `two-elements.Rmd` in ele339/filters for Bode plot code.
#
# Future work:
# Add 95% intervals for Monte Carlo analyses
#

library(shiny)
library(tidyverse)

element_choices <- c("R", "C", "L") #, "none")

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("RLC Series Filter Bode Plots"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          "Define the parameters of the RLC circuit:\n",
          "\nElement 1",
          radioButtons("type_s1", "Type for element #1", element_choices,
                       inline = TRUE, selected = "R"),
          numericInput("value_s1", "Value for element #1", value = 100),
          # "\nElement 2",
          # radioButtons("type_s2", "Type for element #2", element_choices,
          #              inline = TRUE, selected = "R"),
          # numericInput("value_s2", "Value for element #2", value = 1000000),
          "\nElement 2",
          radioButtons("type_s2", "Type for element #2", element_choices,
                       inline = TRUE, selected = "C"),
          numericInput("value_s2", "Value for element #2", value = 1e-8),
          "\nElement 3",
          radioButtons("type_s3", "Type for element #3", element_choices,
                       inline = TRUE, selected = "L"),
          numericInput("value_s3", "Value for element #3", value = 0.001),
          "\nOutput node",
          radioButtons("output_node", "Output node:",
                       c("Between 1-2", "Between 2-3"),
                       inline = TRUE, selected = "Between 1-2"),
          width = 3
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("bodePlot"),
        )
    )
)
