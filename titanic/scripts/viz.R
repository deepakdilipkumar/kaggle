library(ggplot2)

input = read.csv("..//data//cleantrain.csv")

png("..//output//GenderSurvived.png",width=800,height=700)
ggplot(input,aes(x=Sex))+geom_bar(stat="count",aes(fill=factor(Survived)))
dev.off()