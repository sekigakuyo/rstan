library(ggplot2)
d <- read.csv("data/data-salary.txt")

gp <- ggplot(data = d, aes(x = X, y = Y))
gp <- gp + labs(x = "Age(age)", y = "Salary(yen)")
gp <- gp + ggtitle("Figure 4-2")
gp <- gp + theme_bw()
gp <- gp + theme(plot.title = element_text(hjust = 0.5))
gp <- gp + geom_point(size = 5)

ggsave(file = "../result/Figure4-2.png", plot = gp, dpi = 500, w = 4, h = 3)


