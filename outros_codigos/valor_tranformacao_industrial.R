library(tidyverse)
library(ggplot2)
library(forcats)

setwd("C:/Users/nunes/Desktop/DocumentsR")

vti<-read.csv2('tabela1849.csv', header= TRUE)

vti %>%
  ggplot(aes(x=uff, y=factor(pe2,levels=unique(pe2)), group=1))+
  geom_line()+
  geom_point(col='blue', shape=17)+
  labs(x='Ano' , y= 'VTI (Mil reais)' , caption = 'Fonte: IBGE - Pesquisa Industrial 
       Anual - Empresa', title='VTI (Mil reais) de Pernambuco, de 2007 a 2021*',
       subtitle='*Em valores nominais')+
  theme(plot.subtitle=element_text(size=5, hjust=0.14), 
        plot.title= element_text(hjust= 0.5), axis.title.x = 
          element_text(vjust=-2), axis.title.y = element_text(vjust =
                                                                1))+
  scale_x_continuous(breaks = seq(2005,2021,1), guide=
                       guide_axis(angle=50)) #sempre colocar por último


#factor(pe2,levels=unique(pe2))

#heme(plot.subtitle=element_text(size=5)) muda o tamanho da fonte do respectivo local
#theme(axis.title.x = element_text()) muda a distância do título dos eixos
#ggplot(aes(x=uff, y=factor(pee,levels=unique(pee)), group=1)) factor obriga a ordemd os dados a serem das informações a seguir

#uff=as.numeric(levels(uff))[uff] transforma dados
#mutate(pe= fct_reorder(pee,uff))%>%  ordena de aguma forma

#a<- c('2007-12-31','2008-12-31','2009-12-31','2010-12-31','2011-12-31',
#        '2012-12-31','2013-12-31','2014-12-31','2015-12-31','2016-12-31',
#        '2017-12-31','2018-12-31','2019-12-31','2020-12-31','2021-12-31')
#yrs <- as.Date(as.character(a), format= '%Y')
#yy <- year(yrs)

#vti[2] opens second column from database vti

#factor(pe, level=c('6.933.081,00','8.246.293,00',
#                   '10.107.459,00', '12.327.542,00',
#                   '13.663.362,00','17.124.421,00',
#                   '16.718.308,00','18.405.235,00',
#                   '20.372.554,00',' 20.999.141,00',
#                   '23.402.583,00','27.170.884,00',
#                   '29.223.468,00','29.090.283,00',
#                   '37.798.721,00'))

#factor(pe, level=c('6.933.081,00','8.246.293,00',
#                   '10.107.459,00', '12.327.542,00',
 #                  '13.663.362,00','17.124.421,00',
  #                 '16.718.308,00'))
#vv<-data.frame(uf=c('2007','2008','2009','2010','2011','2012
#                 ','2013','2014','2015','2016','2017','2018','2019','2020
#                ','2021'), pe= c('6.933.081,00','8.246.293,00
#', ''

