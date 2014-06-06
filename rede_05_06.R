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
class(redes2[,1]);class(redes2[,2])
redes2[,1] <- as.numeric(redes2[,1]);redes2[,2] <- as.numeric(redes2[,2])
class(redes2[,1]);class(redes2[,2])

###### importando coordenadas ######
prod <- read.csv('produtores_07fev2014.csv',header=T,sep=';')
# limpando banco de coordenadas 
coord.limp <- subset(prod, select=c(CODIGO_PROPRIEDADE,LONGITUDE_DECIMAL,LATITUDE_DECIMAL))
View(coord.limp)

###### Montar grafo ######
rede_circuitos <- graph.data.frame(redes2,directed=T)
summary(rede_circuitos)
# verificando a ordem dos codigos no grafo 
ordem_codigos_no_grafo <- get.vertex.attribute(graph=rede_circuitos,name='name')
ordem_codigos_no_grafo <- as.numeric(ordem_codigos_no_grafo)
summary(ordem_codigos_no_grafo)
class(ordem_codigos_no_grafo)
# fazendo banco das coordenadas pela ordem que ta no grafo
nova_lat <- rep(0.1,length(ordem_codigos_no_grafo))
str(nova_lat)
str(ordem_codigos_no_grafo)
head(nova_lat)
tail(nova_lat)
for (i in 1:length(ordem_codigos_no_grafo) )
  nova_lat[i] <- coord.limp$LATITUDE_DECIMAL[ which(redes2$Out == ordem_codigos_no_grafo[i] ) ]
class(redes2[,1])
# deixar lat em uma coluna e long em uma

warnings()
View(gta.limp2012)
View(gtas.coords)
