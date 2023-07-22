
calc_r_par <- function(x, y) {x*y/(x+y)}

calc_gain <- function(Ic, Va, beta, Rc, Re) {
  Vt <- 0.026
  gm <- Ic / Vt
  rpi <- beta / gm
  ro <- Va / Ic

  T1 <- (beta+1)/rpi
  T2A <- (1/Re + 1/ro + (beta+1)/rpi)
  T2B <- gm*ro/(1 + gm*ro)

  T3 <- 1/ro
  T4B <- (1+ro/Rc)/(1+gm*ro)
  cat(T1, T2A, T2B, T3, T4B, T2 <- T2A*T2B, T4 <- T2A*T4B, "\n")

  return((T1 - T2)/(T4 - T3))
}

calc_gain_2 <- function(Ic, Va, beta, Rc, Re) {
  Vt <- 0.026
  gm <- Ic / Vt
  rpi <- beta / gm
  ro <- Va / Ic

  T1 <- Re - beta*ro
  T2A <- rpi*Re/calc_r_par(calc_r_par(Rc, Re), rpi)
  T2B <- ro/Rc*(rpi + (beta+1)*Re)

  cat(T1, T2A, T2B, "\n")

  return(T1 / (T2A + T2B))
}

calc_claim <- function(Ic, Va, beta, Rc, Re) {
  Vt <- 0.026
  gm <- Ic / Vt
  rpi <- beta / gm
  ro <- Va / Ic

  T2 <- calc_r_par(Rc, ro*(1+gm*Re))
  T3 <- (1+gm*Re)

  cat(T2, T3, "\n")

  return(-gm*T2/T3)
}

calc_gain(Ic=0.005, Va=2.5, beta=10, Rc=2000, Re=2000)

calc_gain(Ic=0.010, Va=5, beta=20, Rc=500, Re=2000)

beta_est <- (Ic <- 0.009754)/0.0002637
calc_gain(Ic=Ic, Va=5, beta=beta_est, Rc=500, Re=2000)

Ic <- 0.0384383
Ib <- 0.0014299
calc_gain(Ic=Ic/(1+2.444/5), Va=5, beta=Ic/Ib, Rc=200, Re=1000)

Ic <- 0.037929
Ib <- 0.00189645
calc_gain(Ic=Ic, Va=999999, beta=Ic/Ib, Rc=200, Re=1000)
calc_claim(Ic=Ic, Va=999999, beta=Ic/Ib, Rc=200, Re=1000)
# 42.414364 - 42.413982 = 382
# 188.95 + 190 = 379
#
# 185.67 + 194.26 = 379.93
# 189.94 + 190.05 = 379.99
# 189.91 + 190.02 = 379.93

Ic <- 0.026
calc_gain(Ic=Ic, Va=5.2, beta=40, Rc=1600, Re=1600)
calc_claim(Ic=Ic, Va=5.2, beta=40, Rc=1600, Re=1600)

# V_CE = 2.444
# Ic' = Ic / (1 + V_CE/VA)
# V_b is 40.59275 - 40.59075 = 200mV p-p


# checking my simplifications
my.fun1 <- function(Ic, Va, beta, Rc, Re) {
  Vt <- 0.026
  gm <- Ic / Vt
  rpi <- beta / gm
  ro <- Va / Ic

  T1 <- (beta+1)/rpi
  T2A <- (1/Re + 1/ro + (beta+1)/rpi)
  T2B <- gm*ro/(1 + gm*ro)
  cat(T1 - T2A*T2B, "\n")

  #out <- -1/Re * (beta*ro - Re)/(beta*ro + rpi)
  #out <- (beta*ro - Re)/(rpi*Re*(1+gm*ro))
  out <- 1/rpi - gm*ro/Re
    out <- out /(1 + gm*ro)
  cat(out, "\n")
}

my.fun1(Ic=0.026, Va=5.2, beta=40, Rc=1600, Re=1600)

calc_gain(Ic=0.026, Va=5.2, beta=40, Rc=1600, Re=1600)
calc_gain_2(Ic=0.026, Va=5.2, beta=40, Rc=1600, Re=1600)
calc_gain_3(Ic=0.026, Va=5.2, beta=40, Rc=1600, Re=1600)


calc_gain_3 <- function(Ic, Va, beta, Rc, Re) {
  Vt <- 0.026
  gm <- Ic / Vt
  rpi <- beta / gm
  ro <- Va / Ic
  cat(glue::glue("rpi = {rpi}, gm = {gm}, ro = {ro}"), "\n")

  T1 <- -Rc * (beta - Re/ro)
  T2B <- 1 + Re/rpi + Re/Rc
  T2A <- rpi*(1+Rc/ro * T2B)
  T2C <- (beta+1)*Re

  cat(T1, T2A, T2B, T2C, "\n")

  return(T1 / (T2A + T2C))
}


calc_rin <- function(Ic, Va, beta, Rc, Re) {
  Vt <- 0.026
  gm <- Ic / Vt
  rpi <- beta / gm
  ro <- Va / Ic
  cat(glue::glue("rpi = {rpi}, gm = {gm}, ro = {ro}"), "\n")

  T1 <- rpi + (beta+1)*Re
  T2 <- (Rc*Re + rpi*(Rc+Re))/ro
  T3 <- 1 + (Rc+Re)/ro
  return((T1 + T2)/T3)

}
calc_rin(Ic=0.026, Va=5.2, beta=40, Rc=1600, Re=1600)
