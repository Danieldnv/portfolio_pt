library(ggplot2)
library(lubridate)
library(GetBCBData)
library(tidyverse)
library(gganimate)
library(gifski)


############### EXTRAINDO DADOS DE INADIMPLêNCIA DO BCB #####################
serie_bcb2 <- c(pessoa_juridica = 21083, pessoa_fisica = 21084)
data_inicial<-'2011-03-01'

inadimplencia_bcb2<- gbcbd_get_series(id=serie_bcb2, first.date = data_inicial,
                                     last.date = Sys.Date(), use.memoise = F)

############### montando o dataframe a partir dos dados extraídos do bacen#########################
PJ<- inadimplencia_bcb2%>%
  filter(series.name == 'pessoa_juridica')%>%
  select(value)

PF <- inadimplencia_bcb2%>%
  filter(series.name == 'pessoa_fisica')%>%
  select(value)

df_inadimplencia <- data.frame(inadimplencia_bcb2$ref.date, PF, PJ)
colnames(df_inadimplencia)= c('Ano', 'tx_fisica', 'tx_juridica')

########################### PLOTANDO O GRÁFICO E FAZENDO A ANIMAÇÃO #######################
estatico <- ggplot(data= df_inadimplencia, aes(x=Ano))+
  theme_gray()+
  geom_line(aes(y= tx_fisica, colour='tx_fisica'), size=.9)+
  geom_line(aes(y= tx_juridica, colour='tx_juridica'), size=.9)+
  labs(x='Ano', y= 'Taxa de inadimplência (%)', title = 'Taxas de inadimplência - Pessoas físicas e jurídicas', 
       subtitle = '(2011-2024)', caption= 'Fonte: BCB', colour= '')+
  theme(plot.title = element_text(size = 17, face='bold', hjust = 0.5, 
                                  family='mono'))+
  theme(plot.subtitle =element_text(size = 16, face='bold', hjust = 0.5, 
                                    family='mono'))+
  theme(axis.text.x = element_text(size= 15, face ='bold', hjust=1 , family=
                                     'mono', angle= 45))+
  theme(axis.text.y = element_text(size= 15, face ='bold', colour= 'black', angle=1,
                                   hjust=1 , family='mono'))+
  theme(legend.position = 'bottom')+
  scale_x_date(date_labels = '%Y', breaks ='1 year')

estatico #visualizando o plot estático que criei

animated_plot <- estatico +  # aplicando ao plot estático a função transtion reveal
 transition_reveal(Ano) +    #colocar entre parênteses a variável que será animada
  ease_aes('linear')        #serve para manter a velocidade da animação entre os frames

# agora, usando 'animate' para animar 'animated_plot', criado anteriormente.
# especifico, respectivamente, num. de frames, frmaes por segundo e as dimensões do plot
# renderizo com o gifski par (talvez) aumentar a resolução
# é necessário criar um objeto para utilizar em 'anim_save', pois assim consigo salvar em
# qualidade muito maior
ap_better <- animate(animated_plot, nframes = 400, fps = 50,width = 600, height = 400, 
        renderer = gifski_renderer())

#salvando o gif animado 'animated_plot'
anim_save("animated_plot_better.gif", ap_better , path = 'C:/Users/nunes/Desktop/Trabalhos Prontos R')

