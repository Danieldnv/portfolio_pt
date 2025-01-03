####################### Microdados-Desemprego ###########################


rm(list=ls(all=TRUE))
install.packages('PNADcIBGE')
install.packages('survey')
install.packages('convey')
library(PNADcIBGE)
library(survey)
library(convey)

#selecionando as variaveis a serem pesquisadas

variaveis<-c('UF','Capital','RM_RIDE', 'VD4001', "VD4002", 'VD4004A')

#fazendo a raspagem dos dados das variáveis
####pnadcbr<-get_pnadc(year=2024,quarter=3,vars=variaveis)

##BAIXEI OS DADOS PARA LIVRAR O ENVIRONMENT
pnadcbr<-readRDS('C:/Users/nunes/rsetwd/pnadc3tri24.rds')

#calculando a taxa de desemprego do brasil
txdbr<-svyratio(~VD4002=="Pessoas desocupadas",
                ~VD4001=='Pessoas na força de trabalho', pnadcbr, na.rm=T)

txdbr
#calculando a taxa de desemprego de Pernambuco

pnadcpe<- subset(pnadcbr, UF=='Pernambuco')
txdpe<-svyratio(~VD4002=='Pessoas desocupadas',
                ~VD4001=='Pessoas na força de trabalho', pnadcpe, na.rm=T)

txdpe

#taxa de desemprego da RMR
pnadcrmrec<-subset(pnadcpe, RM_RIDE=='Região Metropolitana de Recife (PE)')

txdrmrec<-svyratio(~VD4002=='Pessoas desocupadas',
                   ~VD4001=='Pessoas na força de trabalho', pnadcrmrec,na.rm=T)
txdrmrec

############# Microdados-Explorando dados da PNADc ####################
variaveis_selecionadas<- c('UF', 'Capital','RM_RIDE','V2007','V2009', 'V2010',
                           "VD3004", "VD4001", "VD4002", "VD4004A", 
                           "VD4005", "VD4010","VD4012", "VD4020")

################## salvei isso em RDS!
#pnadcbr324<- get_pnadc(year=2024, quarter=3, vars=variaveis_selecionadas)

pnadcbr324<- readRDS('C:/Users/nunes/rsetwd/pnadcommaisvariaveis.rds')
##########Calculando a renda total brasil
totalrenda <- svytotal(~VD4020, pnadcbr324, na.rm=T)
totalrenda

##########total de habitantes por sexo
totalsexo<-svytotal(~V2007, pnadcbr324, nar.rm=T)
totalsexo

##########total de habitantes divididos por sexo e raça
totalsexoeraca<- svytotal(~interaction(V2007, V2010), pnadcbr324, na.rm=T)
totalsexoeraca

########## proporção de habitantes por sexo

porsexo<- svymean(~V2007, pnadcbr324, na.rm=T)
porsexo

########## Renda média do Brasil
mediarenda <- svymean(~VD4020, pnadcbr324, na.rm = T)
mediarenda

########## Proporção de habitantes por raça
propraca<- svymean(~V2010, pnadcbr324, na.rm = T)
propraca

########## Quantis de renda
quantisrenda<- svyquantile(~VD4020, pnadcbr324 , quantiles = c(.1,.25,.5,.75,.9,
                                                               .99), na.rm=T)
quantisrenda

#################### trabalhando com a função subset

########## renda média de mulheres no Brasil

rendamediaM<- svymean(~VD4020, subset(pnadcbr324, V2007=='Mulher'), na.rm=T)
rendamediaM

rendamediaH<- svymean(~VD4020, subset(pnadcbr324, V2007=='Homem'), na.rm=T)
rendamediaH

########## taxa de desocupação por sexo
txdesmul<- svyratio(~VD4002=='Pessoas desocupadas', ~VD4001=='Pessoas na força de trabalho',
                    subset(pnadcbr324, V2007=='Mulher'), na.rm=T)
txdesmul

txdeshom<- svyratio(~VD4002=='Pessoas desocupadas', ~VD4001=='Pessoas na força de trabalho', 
                    subset(pnadcbr324, V2007=='Homem'), na.rm=T)
txdeshom

########## Quantis de renda de homens
quantisrendahom<- svyquantile(~VD4020, subset(pnadcbr324, V2007=='Homem'),
                              quantiles=c(.1,.25,.5,.75,.9,.99), na.rm=T)
quantisrendahom

quantisrendamul<- svyquantile(~VD4020, subset(pnadcbr324, V2007=='Mulher'),
                              quantiles=c(.1,.25,.50,.75,.9,.99) ,na.rm=T)
quantisrendamul

########## taxa de desocupação de pessoas com 20 a 30 anos no Brasil

desocup25mais<- svyratio(~VD4002=='Pessoas desocupadas', 
                         ~VD4001=='Pessoas na força de trabalho', 
                         subset(pnadcbr324, V2009>=20&V2009<=30), na.rm=T)
desocup25mais

###### adicionei agora: taxa de desocupação de pessoas de mais de 40 anos

desocup40mais<- svyratio(~VD4002=='Pessoas desocupadas', 
                         ~VD4001=='Pessoas na força de trabalho', 
                         subset(pnadcbr324, V2009>=40), na.rm=T)

######### taxa de desocupação de mulheres pretas entre 20 e 30 anos
txmulpreta<- svyratio(~VD4002=='Pessoas desocupadas',
                      ~VD4001=='Pessoas na força de trabalho',
                      subset(pnadcbr324, V2007=='Mulher' & V2010=='Preta'&
                               V2009>=20 & V2009<=30), na.rm=T)
txmulpreta

######### taxa de desocupação mulheres brancas entre 20 e 30 anos

txmulbranca <- svyratio(~VD4002=='Pessoas desocupadas',
                        ~VD4001=='Pessoas na força de trabalho',
                        subset(pnadcbr324, V2007=='Mulher' & V2010 == 'Branca' &
                                 V2009>=20 & V2009<=30), na.rm=T)
txmulbranca

######## renda media do homem branco e preto

rendahombranco<- svymean(~VD4020, subset(pnadcbr324, V2007=='Homem' & V2010=='Branca'), na.rm=T)
rendahombranco

rendahompreto<- svymean(~VD4020, subset(pnadcbr324, V2007=='Homem' & V2010=='Preta'),
                        na.rm=T)
rendahompreto

############### Renda média da mulher preta em Pernambuco

pnadcpe2<- subset(pnadcbr324, UF=='Pernambuco')
rendamediamulppe<- svymean(~VD4020, subset(pnadcpe2, V2007=='Mulher', V2010=='Preta'),
                           na.rm=T)
rendamediamulppe
