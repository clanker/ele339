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

element_choices <- c("R", "C", "L", "none")

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("RLC Series Filter Bode Plots"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          "Define the RLC circuit parameters:",
          #"(in) #1 -- (#4 to gnd) -- #2 -- (#3 to gnd)\n",
          #"\nOutput node",
          radioButtons("output_node", "Output node:",
                       c("Between 1-2", "Between 2-3"),
                       inline = TRUE, selected = "Between 2-3"),
          "\nElement 1",
          radioButtons("type_s1", NULL, element_choices,
                       inline = TRUE, selected = "R"),
          numericInput("value_s1", "Value for element #1", value = 10),
          "\nSeries Element 2",
          radioButtons("type_s2", NULL, element_choices,
                       inline = TRUE, selected = "C"),
          numericInput("value_s2", "Value for element #2", value = 1e-8),
          "\nSeries Element 3",
          radioButtons("type_s3", NULL, element_choices,
                       inline = TRUE, selected = "L"),
          numericInput("value_s3", "Value for element #3", value = 0.01),
          "\nParallel Element 4",
          radioButtons("type_s4", NULL, element_choices,
                       inline = TRUE, selected = "none"),
          numericInput("value_s4", "Value for element #4", value = 10000),
          width = 4
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("bodePlot"),
        )
    )
)
