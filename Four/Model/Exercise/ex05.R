source("exercise04.R")
library(rstan)
library(ggmcmc)

data <- list(N1= length(Y1), N2= length(Y2), Y1= Y1, Y2= Y2)
fit <- stan(file="ex05.stan",data=data,seed=123)

ggmcmc(ggs(fit), plot= c("traceplot","density"), file= "../../result/Ex05.pdf")
ms <- rstan::extract(fit)

dif <- ms$mu[,1] - ms$mu[,2]
p_value <- length(dif[dif>0])/length(dif)