#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(Ryacas)
library(tidyverse)

as_function <- function(expr) {
  as.function(alist(x =, eval(parse(text = expr))))
}

# redefine D function
D <- function(eq, order = 1) {
  yac_str(paste("D(x,", order, ")", eq))
}

eq_add <- function(str1, str2, str3 = NULL) {
  out <- paste("(", str1, "+", str2)
  if (!is.null(str3))  out <- paste(out, "+", str3)
  paste(out, ")")
}

eq_mult <- function(str1, str2, str3 = NULL) {
  out <- paste(str1, "*", str2)
  if (!is.null(str3))  out <- paste(out, "*", str3)
  out
}

eq_div <- function(str1, str2, str3 = NULL) {
  out <- paste(str1, "/", str2)
  if (!is.null(str3))  out <- paste(out, "/", str3)
  out
}

eq_parallel <- function(str1, str2) {
  out <- paste(str1, "*", str2, "/ (", str1, "+", str2, ")")
}

conv_to_phase <- function(x) { 0.5 + x/360 }

plot_bode <- function(f, x, f_lim = NULL) {

  A = Mod(x)
  theta = Arg(x)*180/pi
  max_A <- ceiling(max(1, max(A)))

  ggplot(data = tibble(f = f, A = A, theta = theta)) +
    geom_hline(yintercept = seq(0, max_A, by = max_A/4), lwd = 1/5) +
    #geom_hline(yintercept = setdiff(seq(1/12, 11/12, by = 1/12), c(1/4, 1/2, 3/4)),
    #           col = 'red2', lty = 3, lwd = 1/8) +
    geom_line(mapping = aes(x = f, y = A)) +
    geom_line(mapping = aes(x = f, y = max_A*conv_to_phase(theta)), col = 'red2', lty = 2) +
    labs(x = "f (Hz)", y = "voltage gain") +
    scale_x_log10(breaks = 10^(1:8),
                  labels = c("10", "100", "1k", "10k", "100k", "1M", "10M", "100M"),
                  minor_breaks = c(10^(1:8)*5, 10^(1:8)*2),
                  limits = f_lim,
                  expand = rep(0, 4)) +
    scale_y_continuous(breaks = seq(0, max_A, by = ceiling(max_A*10)/200),
                       expand = rep(0.002, 4),
                       minor_breaks = NULL,
                       sec.axis = sec_axis(~ 360 * ((. / max_A) - 0.5),
                                           name = "phase (deg.)",
                                           breaks = seq(-180, 180, by = 30))) +
    theme_bw(base_size = 16)
}

calc_s <- function(type, value) {
  if (type == "R") return (as.character(value))
  if (type == "C") return (sprintf("%s / x", as.character(1/value)))
  if (type == "L") return (sprintf("%s * x", as.character(value)))
  #if (type == "none") return (NA_character_)
}

# Define server logic required to draw a histogram
function(input, output, session) {

  output$bodePlot <- renderPlot({

    s1_string <- calc_s(input$type_s1, input$value_s1)
    #s2_string <- calc_s(input$type_s2, input$value_s2)
    s3_string <- calc_s(input$type_s3, input$value_s3)
    s4_string <- calc_s(input$type_s4, input$value_s4)
    fxn_H <- as_function(eq_div(
      s4_string,
      #eq_add(s1_string, eq_parallel(s2_string, eq_add(s3_string, s4_string)))
      eq_add(s1_string, s3_string, s4_string)
    ))

    f <- 10^seq(1, 6, by = 0.01)
    x <- sapply(f*2i*pi, fxn_H)

    plot_bode(f, x)

 })

}

# s1_string <- calc_s("L", "0.1")
# s4_string <- calc_s("R", "100")
# fxn_H <- as_function(eq_div(s4_string, eq_add(s1_string, s4_string)))
#
# f <- 10^seq(1, 6, by = 0.01)
# x <- sapply(f*2i*pi, fxn_H)
#
# plot_bode(f, x)
