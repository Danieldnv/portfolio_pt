library(sidrar)
library(tidyverse)

#Passo 1: Abrindo a tabela baixada do SIDRA
tabela1<-read.csv2('tabelaprova.csv',header=T) 

#Passo 2: Usando Pipe para, primeiramente, criar uma nova coluna usando os dados da tabela
#baixada. essa nova coluna representará o Valor de transformação industrial (VBP- COPI).
#Agora, uso select para separar da tabela do sidra: o VBP, os custos, anos e adicionar
#o VTI que calculei na linha 21.
#depois, nomeio cada coluna de maneira mais apresentável com 'colnames'
dataframe1<-tabela1%>%
  mutate(VTI=VBP-COPI)%>%
  select(Ano,VBP,COPI,VTI)
colnames(dataframe1)=c('Ano','VBP', 'Custos das O.I.', 'VTI')

#observando o resultado:
dataframe1 

#agora, verificando o VTI de 2010, que corresponde a 4ª linha da 4ª coluna
#para isso, digitei o dataframe e usei [linha, coluna] para acessar o valor
Vti_2010<- dataframe1[4,4]
#VTI de 2010:
Vti_2010

###############################################################################
########################## SEGUNDA QUESTÃO: ###################################

# Usando o o get_sidra, do sidrar, para raspar os dados que serão
# utilizados diretamete do SIDRA, sem precisar baixar e manipular tabelas no excel
pib_ibge22<-get_sidra(api='/t/6784/n1/all/v/9808,9809,9811/p/all/d/v9811%201')

#Agora, separo o valor do PIB nominal da tabela que baixei. Para isso, crio a variável
#pibn, e seleciono, atravez de filter, a coluna que quero filtrar (Váriável). Dessa coluna ,
#separarei todas as linhas que possuem 'PIB - valores correntes', após isso, o resultado são todas as colunas do
#dataframe apenas para o PIB em valores correntes. 
#adiciono à variável pibn, a coluna 'valor', atravez de select, isso deixa apenas valor como coluna em 'pibn'
pibn<-pib_ibge22%>%
  filter(Variável == 'PIB - valores correntes')%>%
  select(Valor)

#Fazendo a mesma coisa para o PIB real,
# serão obtidas todas as colunas e linhas do PIB real (utiliza-se filter()), e dessas,
# será separada apenas a coluna que corresponde ao valor (utiliza-se select())
pibr<-pib_ibge22%>%
  filter(Variável == 'PIB - preços do ano anterior')%>%
  select(Valor)

#Agora, seleciono os anos do dataframe extraído do SIDRA, para incluir no df que criarei
anos<- pib_ibge22%>%
  select(Ano)

#calculando o deflator do PIB
deflator<- (pibn/pibr -1)*100

#Montando o dataframe com todos os dados até então trabalhados.
#É utilizado 'data.frame' e, em seguida, digitado as variáveis que desejo incluir
PIBBB<- data.frame(anos,pibn,pibr,deflator)
#nomeio de maneira mais apresentável com colnames
colnames(PIBBB) = c('Anos', 'PIB nominal', 'PIB real', 'Defaltor')

#resultado final:
PIBBB
# O deflator do PIB é uma medida que permite verificar a variação de preços 
# como um todo na economia. Ao contrário de outros índices, não se resume a uma cesta
# de bens, mas trata de todo o PIB. Com o número que encontramos, 
# temos a variação percentual da inflação que ocorreu em relação aos preços do ano anterior.
