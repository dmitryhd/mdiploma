converge_number <- read.csv("~/GitHub/mdiploma/diplom_code/data/converge_number.csv")
#boxplot(converge_number)
library(ggplot2)
library(reshape2)

converge_number.m <- melt(converge_number)
p <- ggplot(converge_number.m, aes(x=variable,y=value)) + xlab("Скорость обучения") + ylab("") + geom_boxplot( ) + ylab("Количество итераций для сходимости")
p
