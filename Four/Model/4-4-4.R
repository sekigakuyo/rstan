library(ggplot2)
d <- read.csv("data/data-salary.txt")

#### mono regression
result <- lm(Y ~ X, data = d)
summary(result)
X_new <- data.frame(X=23:60)
conf_95 <- predict(result, X_new, interval='confidence', level=0.95)
conf_95 <- data.frame(X_new, conf_95)
pred_95 <- predict(result, X_new, interval='prediction', level=0.95)
pred_95 <- data.frame(X_new, pred_95)



#### scatter plot
gp <- ggplot()
gp <- gp + labs(x = "Age(age)", y = "Salary(yen)")
gp <- gp + ggtitle("Figure 4-3")
gp <- gp + theme_bw()
gp <- gp + theme(plot.title = element_text(hjust = 0.5))
gp <- gp + geom_point(data = d, aes(x = X, y = Y),size = 5)

gp <- gp + geom_abline(slope = 21.9, intercept = -119.7) # write a regression line
gp <- gp + geom_ribbon(data=conf_95, aes(x=X, ymin=lwr, ymax=upr), alpha=2/6) # wirte a 95% confidence range
gp <- gp + geom_ribbon(data=pred_95, aes(x=X, ymin=lwr, ymax=upr), alpha=1/6) # wirte a 95% prediction range

ggsave(file="../result/Figure.4-3.png",dpi = 300, w = 3, h = 4)

