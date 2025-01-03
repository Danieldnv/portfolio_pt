library(GGally)
library(tidyverse)
library(ggplot2)
library(ggrepel)
setwd("C:/Users/nunes/Desktop/DocumentsR")
disp<-read.csv2("dispersaonor.csv", header = T)

disp %>%
  ggplot(aes(x=PIBpercapita1961 , y=taxacresc1961a2021))+
  geom_point(col="darkblue")+
  geom_smooth(method = "lm", col="blue")+
  geom_text_repel(aes(label=paises), size= 3)+
  labs(x="PIB per capita em 1961 em Dólares", y= "Taxa de média de crescimento 1961-2021"
       ,title= "Taxa média de crescimento 1961-2021 x PIB per capita 1961")+
  theme(plot.title= element_text(hjust= 0.5))+
  scale_x_continuous(breaks = seq(0,3500,500))+
  scale_y_continuous(breaks = seq(0,10,1))



  
  
 
  


  
  

       
     

