###### iniciando novamente - 05.06.2014 ######
###### importando GTAs 2013 ######
gta2013 <- read.csv('baseGTAsuscetiveis2013.csv',header=T,sep=';')
# ver os nomes q estao nessa coluna
levels(gta2013[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2013a <- gta2013[which(gta2013$ESPECIE_ANIMAL == 'Suíno'),]
names(gta2013a)
# eliminar colunas excessivas
gta.limp2013 <- subset(gta2013a, select=c(GTA, SERIE, ANO, FINALIDADE, TOT_OUTROS, COD_MUN_IBGE_ORI, MUNICIPIO_ORI,
                                          PRODUTOR_ORI, COD_PROP_ORI, COD_MUN_IBGE_DEST, MUNICIPIO_DEST, 
                                          PRODUTOR_DEST, COD_PROP_DEST)) 
View(gta.limp2013)
# deixar 3 colunas (out, in, weight) para fazer a rede
rede2013 <- data.frame(gta.limp2013$COD_PROP_ORI ,gta.limp2013$COD_PROP_DEST, gta.limp2013$TOT_OUTROS)
names(rede2013)
# trocando nomes das colunas pra facilitar
rede2013 <- rename(rede2013,c('gta.limp2013.COD_PROP_ORI'='Out','gta.limp2013.COD_PROP_DEST'='In','gta.limp2013.TOT_OUTROS'='Weight'))
View(rede2013)

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

###### Montar grafo ######
library(igraph)
rede_circuitos <- graph.data.frame(redes,directed=T)
summary(rede_circuitos)
# verificando a ordem dos codigos no grafo 
ordem_codigos_no_grafo <- get.vertex.attribute(graph=rede_circuitos,name='name')
summary(ordem_codigos_no_grafo)
#class(ordem_codigos_no_grafo) 
# transformar para numeric
#ordem_codigos_no_grafo <- as.numeric(ordem_codigos_no_grafo)
#summary(ordem_codigos_no_grafo)
#class(ordem_codigos_no_grafo)
# fazendo banco das coordenadas pela ordem que ta no grafo
nova_lat <- length(ordem_codigos_no_grafo)
str(nova_lat)
str(ordem_codigos_no_grafo)
length(nova_lat)
length(ordem_codigos_no_grafo)
head(nova_lat)
tail(nova_lat)
for (i in 1:length(ordem_codigos_no_grafo) )
  nova_lat[i] <- coord.limp$LATITUDE_DECIMAL[ which(redes2$Out == ordem_codigos_no_grafo[i] ) ]
class(redes2[,1])
# deixar lat em uma coluna e long em uma

warnings()
View(gta.limp2012)
View(gtas.coords)
