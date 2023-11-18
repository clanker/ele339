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
function(input, output, session) {

  output$magPlot <- renderPlot({

    xs <- 10^seq(0, 6, by=0.01)
    tau <- input$value_s1 * input$value_s2

    if (input$type_s1 == "C") {
      ys <- (1/tau) / (1i * 2*pi * xs + (1/tau))
    } else {
      ys <- (1i * 2*pi * xs) / (1i * 2*pi * xs + (1/tau))
    }

    # draw the histogram with the specified number of bins
    plot(xs, log10(Mod(ys))*20,
         type = 'l',
         xlab = 'frequency',
         ylab = 'gain (dB)',
         log = 'x',
         las = 1)
    grid()
  })

  output$phasePlot <- renderPlot({

    xs <- 10^seq(0, 6, by=0.01)
    tau <- input$value_s1 * input$value_s2

    if (input$type_s1 == "C") {
      ys <- (1/tau) / (1i * 2*pi * xs + (1/tau))
    } else {
      ys <- (1i * 2*pi * xs) / (1i * 2*pi * xs + (1/tau))
    }

    # draw the histogram with the specified number of bins
    plot(xs, Arg(ys)*180/pi,
         type = 'l',
         xlab = 'frequency',
         ylab = 'phase (deg)',
         log = 'x',
         las = 1)
    grid()
  })

}
