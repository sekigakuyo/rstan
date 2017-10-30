set.seed(123)
N1 <- 30
N2 <- 20
Y1 <- rnorm(n= N1, mean= 0, sd= 5)
Y2 <- rnorm(n= N2, mean= 0, sd= 4)


###################################
library(ggplot2)

png("../../result/Ex01-1.png",height=500, width=400)
boxplot(Y1,Y2)
dev.off()

variance <- as.character(c(rep(1,N1),rep(2,N2)))
dataset <- data.frame(value= c(Y1,Y2), variance= variance)

gp <- ggplot(data= dataset,aes(x= value, fill= variance))
gp <- gp + geom_histogram(alpha=0.4, position="identity")
gp <- gp + theme_bw()
gp <- gp + ggtitle("Exercise 02")
gp <- gp + theme(plot.title= element_text(hjust= 0.5))
ggsave(file= "../../result/Ex-02.png",plot= gp, dpi= 300, h= 3, w= 4)
