install.packages('GetBCBData')
install.packages('PNADcIBGE')
install.packages('convey')
install.packages('survey')
install.packages('tidyverse')

library(GetBCBData)
library(PNADcIBGE)
library(convey)
library(survey)
library(tidyverse)

############################################### Questão 1

# Coletando os dados de inadimplência total do Brasil, com a data inicial sendo 01/01/2011
inadimp<- gbcbd_get_series(id=21082, first.date = '2011-01-01', last.date=Sys.Date())

#Construindo o gráfico, incluindo, na função, "inadimp" (Os dados utilizados no gráfico), "ref.date" (os dados do eixo x)
ggplot(inadimp, aes(x=ref.date))+
  # adicionando ao eixo y os valores de inadimplência 
  geom_line(aes(y=value))+
  labs(y='Taxa de inadimplência (%)', x='Data', title='Taxa de inadimplência do Brasil', subtitle='(2011-2024)' )


############################################### Questão 2
#determinando as variáveis que serão obtidas do IBGE pelo pacote PNADcIBGE
variaveis<- c('VD3004', 'VD4001', 'VD4002', 'VD4004A', 'VD4005', 'VD4010', 'VD4012', 'VD4020')

#Coletando os dados da PNAD do 3 trimestre de 2024
pnadcbr<- get_pnadc(year=2024, quarter=3, vars= variaveis) 

#Calculando a taxa de desemprego pela razão (feita pela função svyratio) entre Pessoas desocupadas e pessoas na força de trabalho
#excluindo os valores nulos com "na.rm=T".
txdbr<- svyratio(~VD4002=='Pessoas desocupadas', ~VD4001=='Pessoas na força de trabalho', pnadcbr, na.rm=T)

#resultado: aprox. 6,3% de pessoas desempregadas
txdbr


############################################### Questão 3

#Usando a função svyquantile para calcular os quantis de renda dos 10% mais pobres e dos 1% mais ricos,
#sendo VD4020 a variável que trata da renda da população
rendabrasil<- svyquantile(~VD4020, pnadcbr, quantiles= c(.1,.99), na.rm=T)

#resultado:
rendabrasil
