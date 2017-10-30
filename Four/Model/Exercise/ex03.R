source("exercise04.R")
library(rstan)
library(ggmcmc)

data <- list(N1= length(Y1), N2= length(Y2), Y1= Y1, Y2= Y2)
fit <- stan(file="ex02.stan",data=data,seed=123)

save.image("ex03.RData")