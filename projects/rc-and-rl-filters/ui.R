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

# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Bode Plots from Transfer Functions"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
          "Define the transfer function:",
          #"(in) #1 -- (#4 to gnd) -- #2 -- (#3 to gnd)\n",
          #"\nOutput node",
          textInput("numerator", "H(s) numerator:", value = "s/R/C"),
          textInput("denominator", "H(s) demoninator:", value = "s^2 + s/R/C + 1/L/C"),
          numericInput("val_R", "R:", min=0.1, max=1e8, value = 100),
          numericInput("val_L", "L:", min=1e-12, max=10, value = 0.001),
          numericInput("val_C", "C:", min=1e-12, max=10, value = 1e-6),
          width = 4
        ),

        # Show a plot of the generated distribution
        mainPanel(
          #textOutput("bodePlot")
          plotOutput("bodePlot"),
        )
    )
)
