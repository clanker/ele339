# Script to generate two plots, one for NFETs and one for PFETs
library(tidyverse)
library(latex2exp)
library(ggpubr)

Vds <- 3

calc_Id <- function(Vgs, k, W, L, Ld, Vth, Vds, lambda) {
  out <- 0
  if (Vgs > Vth) {
    out <- 0.5*k*W/(L-2*Ld)*(Vgs-Vth)^2*(1+lambda*Vds)
  }
  return(out)
}

X <- tibble(Vgs = 0:300/100,
            Id = sapply(Vgs, calc_Id,
                        k=134.2e-6,
                         W=50,
                         L=0.5,
                         Ld=0.08,
                         Vth=0.7,
                         Vds=3,
                         lambda=0.1))

p1 <- ggplot(X, aes(x=Vgs, y=1000*Id)) +
  geom_line() +
  labs(x = TeX(r"($V_{GS}$ (V))"),
       y = TeX(r"($I_D$ (mA))"),
       title = "NFET drain current vs. Gate-source voltage",
       subtitle = "with drain/source diffusion and channel-length modulation") +
  theme_bw(base_size = 16)

X2 <- tibble(Vgs = 0:300/100,
            Id = sapply(Vgs, calc_Id,
                        k=38.3e-6,
                        W=50,
                        L=0.5,
                        Ld=0.09,
                        Vth=0.8,
                        Vds=3,
                        lambda=0.2))

p2 <- ggplot(X2, aes(x=Vgs, y=1000*Id)) +
  geom_line() +
  labs(x = TeX(r"($-V_{GS}$ (V))"), y = TeX(r"($-I_D$ (mA))"),
       title = "PFET drain current vs. Gate-source voltage",
       subtitle = "with drain/source diffusion and channel-length modulation") +
  theme_bw(base_size = 16)

ggarrange(p1, p2, nrow=2)
ggsave("projects/analog-cmos/pr2-1.pdf")
