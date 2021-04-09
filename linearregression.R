#code written by Nishitha Paidimukkala to perform statistical analysis and plot sample data
require(ggplot2)
require(dplyr)
require(ddply)
require(plyr)

drugA <- read.csv("~/Desktop/toy_dataset_comp-biol-2.csv")
head(drugA)

drugA2=drugA %>% group_by(concentration) %>% summarise_all(mean)
colnames(drugA2) <- c("concentration", "Signal")
drugA3=ddply(drugA,"concentration",numcolwise(sd))
colnames(drugA3) <- c("concentration", "Std_Dev")
drugA4=merge.data.frame(drugA2,drugA3)



drug4= mutate(drug4,ActivityAdj = (`Signal` - first(x = `Signal`)))
drug4 = mutate(drug4, Normalizeddata= (ActivityAdj/`Signal`)*100)
drug4=drugA3 %>% add_column(sample_id= c("Negative control", "S1", "S2", "S3","S4","S5","S6","Posisitve Control","S7","S8","S9","S10", "S11"))


#code to plot linear regression with concentration and signal
t=drug4 %>% 
  ggplot(aes(x=log10(concentration), y=Normalizeddata))+ geom_line()+ geom_smooth(method = "lm") +
  geom_point() +
  geom_point(data= drug4[8,], 
             aes(x=log10(concentration),y=Normalizeddata), 
             color='red',
             size=3, label=drug4$sample_id)
print(t)
t = t + ggtitle("Drug response Curve") 
t + ylab("Normalized fluroscence Signal")
t=t+ geom_hline(yintercept=0, 
                color = "black", size=1)
t + geom_text(aes(color = positive control))

t + scale_x_continuous(name="log10(concentration)", limits=c(0, 5)) +
  scale_y_continuous(name="Normalized fluroscence Signal", limits=c(-150, 150))



#code to plot the concentration and signal graph
x=drug4 %>% 
  ggplot(aes(x=log10(concentration), y=Normalizeddata))+ geom_line()+
  geom_point() +
  geom_point(data= drug4[8,], 
             aes(x=log10(concentration),y=Normalizeddata), 
             color='red',
             size=3)
print(x)
