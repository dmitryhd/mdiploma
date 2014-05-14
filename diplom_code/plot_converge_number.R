converge_number <- read.csv("../data/converge_number.csv")
#boxplot(converge_number)
library(ggplot2)
library(reshape2)

converge_number.m <- melt(converge_number)
p <- ggplot(converge_number.m, aes(x=variable,y=value)) + xlab("Коеффициент скорости обучения") + geom_boxplot( ) + ylab("Скорость сходимости нейросети")
ggsave(filename="../plots/eta_vs_speed.png", plot=p)
p
