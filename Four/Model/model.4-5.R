library(ggplot2)
library(rstan)
library(ggmcmc)

d <- read.csv("data/data-salary.txt")
data <- list(N = nrow(d), X <- d$X, Y <- d$Y)

fit <- stan(file="model.4-5.stan",data=data,seed=111) #Conduct MCMC sampling
png("../result/traceplot_model_4-5.png") # To see and judge that each chain weather converged or not
traceplot(fit)
dev.off()

ggmcmc(ggs(fit,inc_warmup=T,stan_include_auxiliar=F),file = "../result/evidence_model.4-5.pdf",plot=c("traceplot,","density","running"))

#######################################################################################

ms <- rstan::extract(fit)
X_new <- 23:60
fmlr <- function(x){
  set.seed(123) # To keep the reproductivity
  y_base = ms$b[,1] + ms$b[,2]*x
  y_dis = rnorm(n=length(ms$lp__), mean = y_base, sd = ms$sigma)
  conf_95prb <- quantile(y_base,probs=c(0.025,0.975),names=F)
  pred_95prb <- quantile(y_dis,probs=c(0.025,0.975),names=F)
  return(c(         X = x,
                    Y = median(y_base), 
		    conf_lwr=conf_95prb[1],
                    conf_upr=conf_95prb[2],
                    pred_lwr=pred_95prb[1],
                    pred_upr=pred_95prb[2]
                    )
         )
}

dataset <- as.data.frame(t(sapply(X_new,fmlr)))
gp <- ggplot()
gp <- gp + geom_point(data=d, aes(x = X, y = Y),size = 3)
gp <- gp + geom_ribbon(data=dataset, aes(x=X, ymin=pred_lwr, ymax=pred_upr), alpha=1/6)
gp <- gp + geom_ribbon(data=dataset, aes(x=X, ymin=conf_lwr, ymax=conf_upr), alpha=2/6)
gp <- gp + geom_line(data=dataset, aes(x=X, y=Y), size = 1)
gp <- gp + geom_point(data = d, aes(x = X, y = Y),size = 5)

gp <- gp + labs(x= "Age(age)", y= "Salary(yen)")
gp <- gp + ggtitle("Figure 4-3")
gp <- gp + theme_bw()
gp <- gp + theme(plot.title = element_text(hjust = 0.5))
ggsave(file="../result/Figure.4-8.png",plot=gp,dpi=300,w=4,h=3)

