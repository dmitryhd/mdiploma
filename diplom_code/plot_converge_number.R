setwd('D:/study/mdiploma/')

converge_number <- read.csv("data/l3pn3NvsTsync.csv")

converge_number <- read.csv("data/l3pn3NvsTsync_100.csv")

#converge_number <- read.csv("data/n100pn3LvsTsync.csv")

#converge_number <- read.csv("data/n100L3_pn_vs_Tsync.csv")


#boxplot(converge_number)
library(ggplot2)
library(reshape2)

converge_number.m <- melt(converge_number)
p <- ggplot(converge_number.m, aes(x=variable,y=value)) + xlab("N") + geom_boxplot( ) + ylab("Скорость сходимости нейросети")
#p <- ggplot(converge_number.m, aes(x=variable,y=value)) + xlab("L") + geom_boxplot( ) + ylab("Скорость сходимости нейросети")
#p <- ggplot(converge_number.m, aes(x=variable,y=value)) + xlab("Количество нейронов на 2м слое") + geom_boxplot( ) + ylab("Скорость сходимости нейросети")
ggsave(filename="plots/l3pn3N_vs_tsync_100.png", plot=p)
#ggsave(filename="plots/n100pn3LvsTsync.png", plot=p)
#ggsave(filename="plots/n100L3_pn_vs_Tsync.png", plot=p)

p
