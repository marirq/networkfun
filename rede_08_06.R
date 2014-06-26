###### iniciando novamente - 05.06.2014 ######
###### importando GTAs 2013 ######
gta2013 <- read.csv('baseGTAsuscetiveis2013.csv',header=T,sep=';')
str(gta2013)
names(gta2013) # para saber quais colunas quero ver qdo usar o grep() - especie e cod produtor ori
gta2013$COD_PROP_ORI <- as.character(gta2013$COD_PROP_ORI)
a <- gta2013[which(gta2013 != grep('^4',gta2013$COD_PROP_ORI,value=TRUE)),c(8,27)]

gta2013[which(gta2013$COD_PROP_ORI == ''),]
gta2013$COD_PROP_ORI <- as.character(gta2013$COD_PROP_ORI)
#class(gta2013$COD_PROP_ORI)
#gta2013$COD_PROP_ORI[which(gta2013!=grep('^43',gta2013$COD_PROP_ORI))]# deu certo?

# na coluna COD_PROP_ORI quais as linhas em que no 'gta2013' a coluna COD_PRO_ORI comecam com 43
?subset
#head(gta2013)
#str(gta2013a$COD_PROP_ORI)
#gta2013a$COD_PROP_ORI <- as.character(gta2013a$COD_PROP_ORI)
#class(gta2013a$COD_PROP_ORI)
#gta2013b <- gta2013a[which(gta2013a$COD_PROP_ORI >= nchar(4321204023)),]

# ver os nomes q estao nessa coluna
levels(gta2013[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2013a <- gta2013[which(gta2013$ESPECIE_ANIMAL == 'Suíno'),]
names(gta2013a)
str(gta2013a)
# eliminar colunas excessivas
gta.limp2013 <- subset(gta2013a, select=c(GTA, SERIE, ANO, FINALIDADE, TOT_OUTROS, COD_MUN_IBGE_ORI, MUNICIPIO_ORI,
                                          PRODUTOR_ORI, COD_PROP_ORI, COD_MUN_IBGE_DEST, MUNICIPIO_DEST, 
                                          PRODUTOR_DEST, COD_PROP_DEST)) 
View(gta.limp2013)
str(gta.limp2013)
head(gta.limp2013)

# deixar 3 colunas (out, in, weight) para fazer a rede
rede2013 <- data.frame(gta.limp2013$COD_PROP_ORI ,gta.limp2013$COD_PROP_DEST, gta.limp2013$TOT_OUTROS)
names(rede2013)
str(rede2013)
# trocando nomes das colunas pra facilitar
library(plyr)
rede2013 <- rename(rede2013,c('gta.limp2013.COD_PROP_ORI'='Out','gta.limp2013.COD_PROP_DEST'='In','gta.limp2013.TOT_OUTROS'='Weight'))
View(rede2013)
str(rede2013)
# mudar para character para selecionar as linhas que me interessam
rede2013$Out <- as.character(rede2013$Out); rede2013$In <- as.character(rede2013$In)
str(rede2013)
rede2013A <- rede2013[which(rede2013$Out!=''),]
View(rede2013A)
rede2013B <- rede2013A[which(rede2013A$In!=''),]
View(rede2013B)
#rede2013A <- rede2013[which(rede2013$Out==grep('^4',rede2013$Out,value=T)),]
#rede2013B <- rede2013A[which(rede2013A$In==grep('^4',rede2013A$In,value=T)),]
View(rede2013A)
str(rede2013)
ma1 <- ma[which(ma$Out==grep('^4',ma$Out,value=T)),]

###### importando GTAs 2012 ######
gta2012 <- read.csv('baseGTAsuscetiveis2012.csv',header=T,sep=';')
# ver os nomes q estao nessa coluna
levels(gta2012[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2012a <- gta2012[which(gta2012$ESPECIE_ANIMAL == 'Suíno'),]
names(gta2012a)
# eliminar colunas excessivas
gta.limp2012 <- subset(gta2012a, select=c(GTA, SERIE, ANO, FINALIDADE, TOT_OUTROS, COD_MUN_IBGE_ORI, MUNICIPIO_ORI,
                                          PRODUTOR_ORI, COD_PROP_ORI, COD_MUN_IBGE_DEST, MUNICIPIO_DEST, 
                                          PRODUTOR_DEST, COD_PROP_DEST)) 
View(gta.limp2012)
# deixar 3 colunas (out, in, weight) para fazer banco REDES
rede2012 <- data.frame(gta.limp2012$COD_PROP_ORI ,gta.limp2012$COD_PROP_DEST, gta.limp2012$TOT_OUTROS)
names(rede2012)
# trocando nomes das colunas pra facilitar
rede2012 <- rename(rede2012,c('gta.limp2012.COD_PROP_ORI'='Out','gta.limp2012.COD_PROP_DEST'='In','gta.limp2012.TOT_OUTROS'='Weight'))
View(rede2012)
names(rede2012)
str(rede2012)
# mudar para character para selecionar as linhas que me interessam
rede2012$Out <- as.character(rede2012$Out); rede2012$In <- as.character(rede2012$In)
str(rede2012)
rede2012A <- rede2012[which(rede2012$Out!=''),]
rede2012B <- rede2012A[which(rede2012A$In!=''),]

###### Fazendo o banco das redes ######
# juntar redes de 2012 e 2013
redes0 <- rbind(rede2012,rede2013)
redes1 <- redes0[which(redes0$Out != ''),] # tirando as linhas com NAs na coluna Out 
View(redes1)
redes2 <- redes1[which(redes1$In != ''),] # tirando as linhas com NAs na coluna In
write.csv2(redes2,'redes2.csv',row.names=F)
View(redes2)
# tirando linhas inuteis pois nao estao com codigo
redes3 <- redes2[which(redes2$Out != 'L SÃO PAULO'),]
redes4 <- redes3[which(redes3$Out != 'GRANJA GRSC'),]
redes5 <- redes4[which(redes4$Out != 'CISPOA 432'),]
redes6 <- redes5[which(redes5$Out != 'CISPOA 861'),]
redes7 <- redes6[which(redes6$Out != 'CISPOA 821'),]
redes8 <- redes7[which(redes7$Out != 'GJ SCHOELER'),]
redes9 <- redes8[which(redes8$Out != 'SIM 003'),]
redes <- redes9[which(redes9$Out != 'WARMELING'),] # esse eh o banco das redes
# deixando as colunas Out e In como numeric
class(redes[,1]);class(redes[,2])
redes[,1] <- as.numeric(redes[,1]);redes[,2] <- as.numeric(redes[,2])
class(redes[,1]);class(redes[,2])

###### importando coordenadas ######
prod <- read.csv('produtores_07fev2014.csv',header=T,sep=';')
# limpando banco de coordenadas 
coord.limp <- subset(prod, select=c(CODIGO_PROPRIEDADE,LONGITUDE_DECIMAL,LATITUDE_DECIMAL))
View(coord.limp)
str(coord.limp)

###### transformando trocar virgula por ponto e lat e long em 'numeric' ######
# coord.limp col 2 e 3 'factor'
length(coord.limp)
class(coord.limp[,2]);class(coord.limp[,3])
# transformar para character
coord.limp[,2] <- as.character(coord.limp[,2]);coord.limp[,3] <- as.character(coord.limp[,3])
class(coord.limp[,2]);class(coord.limp[,3])
# trocar virgula por ponto
coord.limp[,2] <- sub(',','.',coord.limp[,2]);coord.limp[,3] <- sub(',','.',coord.limp[,3])
View(coord.limp)
# tranformar para numero
coord.limp[,2] <- as.numeric(coord.limp[,2]);coord.limp[,3] <- as.numeric(coord.limp[,3])
class(coord.limp[,2]);class(coord.limp[,3])
coord.limp[1,2] # confirmando
write.csv2(coord.limp,'coord_limp.csv',row.names=F)
teste <- cbind(redes[,1],redes[,2])
write.csv2(teste,'teste.csv',row.names=F)
View(teste)
head(redes[,1])
names(redes)
View(redes)

###### Montar grafo ######
library(igraph)
rede_circuitos <- graph.data.frame(redes,directed=T)
summary(rede_circuitos)
# verificando a ordem dos codigos no grafo 
ordem_cod_grafo <- get.vertex.attribute(graph=rede_circuitos,name='name')
ordem_cod_grafo[5552]
summary(ordem_cod_grafo)
#class(ordem_codigos_no_grafo) 
# transformar para numeric
#ordem_codigos_no_grafo <- as.numeric(ordem_codigos_no_grafo)
#summary(ordem_codigos_no_grafo)
#class(ordem_codigos_no_grafo)
# fazendo banco das coordenadas pela ordem que ta no grafo
length(ordem_cod_grafo)
nova_lat <- 1:length(ordem_cod_grafo)
View(nova_lat)
str(redes)
str(nova_lat)
str(ordem_cod_grafo)
str(rede_circuitos)
length(nova_lat)
nova_lat
length(ordem_cod_grafo)
View(ordem_cod_grafo)
View(nova_lat)
nova_lat <- NULL
for (i in 5555:5565)#1:14969 )
  if(ordem_cod_grafo[i] == nchar(43000340001))
  nova_lat[i] <- coord.limp$LATITUDE_DECIMAL[ which(coord.limp$CODIGO_PROPRIEDADE == ordem_cod_grafo[i] ) ]

nova_lat

# ver o q ta de problema dentro do for
mari <- NULL
for (w in 5555:5560)
  mari[w] <- coord.limp$LATITUDE_DECIMAL[which(coord.limp$CODIGO_PROPRIEDADE == ordem_cod_grafo[555])]
mari
w <- 5555
ordem_cod_grafo <- as.numeric(ordem_cod_grafo)

class(ordem_cod_grafo)
View(coord.limp)
View(nova_lat)
warnings()

rm(ls=i)
write.csv2(ordem_cod_grafo,'ordem_grafo.csv',row.names=F)
scan()
# deixar lat em uma coluna e long em uma