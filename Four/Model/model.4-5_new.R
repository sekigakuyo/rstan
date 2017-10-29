library(ggplot2)
library(rstan)
library(ggmcmc)

d <- read.csv("data/data-salary.txt")
X_new = 23:60
data <- list(N= nrow(d), X= d$X, Y= d$Y, X_new= X_new, N_new= length(X_new))

rstan_options(auto_write=TRUE)
options(mc.cores=parallel::detectCores())

fit <- stan(file="model.4-4.stan",data=data,seed=111) #Conduct MCMC sampling
ggmcmc(ggs(fit,inc_warmup=T,stan_include_auxiliar=F),file = "../result/model.4-4.pdf",plot=c("traceplot,","density","running"))

#######################################################################################

ms <- rstan::extract(fit)
dataset <- data.frame(X= X_new,
                      Y= apply(ms$y_base_new,2,median),
                      conf_lwr= apply(ms$y_base_new,2,quantile,probs=0.025),
                      conf_upr= apply(ms$y_base_new,2,quantile,probs=0.975),
                      pred_lwr= apply(ms$y_new,2,quantile,probs=0.025),
                      pred_upr= apply(ms$y_new,2,quantile,probs=0.975)
                      )

gp <- ggplot()
gp <- gp + geom_point(data=d, aes(x = X, y = Y),size = 3)
gp <- gp + geom_ribbon(data=dataset, aes(x=X, ymin=pred_lwr, ymax=pred_upr), alpha=1/6)
gp <- gp + geom_ribbon(data=dataset, aes(x=X, ymin=conf_lwr, ymax=conf_upr), alpha=2/6)
gp <- gp + geom_line(data=dataset, aes(x=X, y=Y), size = 1)
gp <- gp + geom_point(data = d, aes(x = X, y = Y),size = 5)

gp <- gp + labs(x= "Age(age)", y= "Salary(yen)")
gp <- gp + ggtitle("Figure 4-8")
gp <- gp + theme_bw()
gp <- gp + theme(plot.title = element_text(hjust = 0.5))
ggsave(file="../result/Figure.4-8_new.png",plot=gp,dpi=300,w=4,h=3)

