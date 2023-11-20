#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(Ryacas0)
library(tidyverse)

s <- Sym("s")
R <- Sym("R")
L <- Sym("L")
C <- Sym("C")

conv_to_phase <- function(x, max_dB, spread=60) {
  max_dB - spread + spread*(0.5 + x/360)
}

plot_bode <- function(f, x, f_lim = NULL) {

  # any NAs are likely 0/0 that are 0 according to l'Hopital's Rule
  x[is.na(x)] <- 0

  A = Mod(x)
  theta = Arg(x)*180/pi
  max_A <- max(1, max(A))
  max_dB <- ceiling(4*log10(max_A))*5
  A_dB <- 20*log10(A+1e-12)

  freq_range <- f[A_dB >= max_dB - 60]
  freq_range <- setdiff(freq_range, f[A > 0.999 & A < 1.001])
  if (length(freq_range) < 40) {
    f_min <- f[which.min(A)]
    freq_range <- f[A_dB >= max_dB - 60]
    freq_range <- setdiff(freq_range, f[f < f_min*0.05])
    freq_range <- setdiff(freq_range, f[f > f_min*20])
  }
  if (length(freq_range) < 40) {
    freq_range <- f[A_dB >= max_dB - 60]
  }

  ggplot(data = tibble(f = f, A = A_dB, theta = theta)) +
    geom_hline(yintercept = seq(max_dB-60, max_dB, by = 15), lwd = 1/5) +
    #geom_hline(yintercept = setdiff(seq(1/12, 11/12, by = 1/12), c(1/4, 1/2, 3/4)),
    #           col = 'red2', lty = 3, lwd = 1/8) +
    geom_line(mapping = aes(x = f, y = A_dB)) +
    geom_line(mapping = aes(x = f, y = conv_to_phase(theta, max_dB)), col = 'red2', lty = 2) +
    labs(x = "f (Hz)", y = "voltage gain (dB)") +
    scale_x_log10(breaks = matrix(c(1, 2, 5), , 1) %*% matrix(10^(0:8), 1) |> as.vector(),
                  labels = c("1", "2", "5", "10", "20", "50", "100", "200", "500",
                             "1k", "2k", "5k", "10k", "20k", "50k",
                             "100k", "200k", "500k", "1M", "2M", "5M",
                             "10M", "20M", "50M", "100M", "200M", "500M"),
                  minor_breaks = matrix(c(1 + 1:9/10, 3, 4, 6, 7, 8, 9), , 1) %*% matrix(10^(0:8), 1) |> as.vector(),
                  limits = range(freq_range),
                  expand = rep(0, 4)) +
    scale_y_continuous(breaks = seq(max_dB-60, max_dB, by = 5),
                       expand = rep(0.002, 4),
                       minor_breaks = NULL,
                       limits = c(max_dB-60, max_dB),
                       sec.axis = sec_axis(~ 6 * (. - max_dB + 30),
                                           name = "phase (deg.)",
                                           breaks = seq(-180, 180, by = 30))) +
    theme_bw(base_size = 16)
}

calc_s <- function(type, value) {
  if (type == "R") return (value)
  if (type == "C") return ((1 / value) / s)
  if (type == "L") return (value * s)
  if (type == "none") return (NA)
}

# Define server logic required to draw a histogram
function(input, output, session) {

  output$bodePlot <- renderPlot({
  #output$bodePlot <- renderText({

    s1 <- eval(parse(text = input$numerator))
    s2 <- eval(parse(text = input$denominator))
    fxn_H <- s1/s2

    f <- 10^seq(0, 8, by = 0.01)
    x <- Eval(fxn_H, list(s=f*2i*pi, R=input$val_R, L=input$val_L, C=input$val_C))

    plot_bode(f, x)
    #paste(s1, s2, fxn_H)
 })

}

# s1_string <- calc_s("L", "0.1")
# s4_string <- calc_s("R", "100")
# fxn_H <- as_function(eq_div(s4_string, eq_add(s1_string, s4_string)))
#
# f <- 10^seq(1, 6, by = 0.01)
# x <- sapply(f*2i*pi, function(x) 100/(100 + x))
#
# plot_bode(f, x)
