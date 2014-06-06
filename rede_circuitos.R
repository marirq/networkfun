###### importando GTAs 2013 ######
gta2013 <- read.csv('baseGTAsuscetiveis2013.csv',header=T,sep=';')
# ver os nomes q estao nessa coluna
levels(gta2013[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2013a <- gta2013[which(gta2013$ESPECIE_ANIMAL == 'Suíno'),]
# eliminar colunas nao uteis
gta.limp2013 <- subset(gta2013a, select=c(COD_PROP_ORI,COD_PROP_DEST,TOTAL,ANO,GTA, SERIE,FINALIDADE,PRODUTOR_ORI,
                                          COD_MUN_IBGE_ORI,MUNICIPIO_ORI,PRODUTOR_DEST,COD_MUN_IBGE_DEST,
                                          MUNICIPIO_DEST)) 

###### importando GTAs 2012 ######
gta2012 <- read.csv('baseGTAsuscetiveis2012.csv',header=T,sep=';')
# ver os nomes q estao nessa coluna
levels(gta2012[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2012a <- gta2012[which(gta2012$ESPECIE_ANIMAL == 'Suíno'),]
# tirando as colunas extras
gta.limp2012 <- subset(gta2012a, select=c(COD_PROP_ORI,COD_PROP_DEST,TOTAL,ANO,GTA, SERIE,FINALIDADE,PRODUTOR_ORI,
                                          COD_MUN_IBGE_ORI,MUNICIPIO_ORI,PRODUTOR_DEST,COD_MUN_IBGE_DEST,
                                          MUNICIPIO_DEST)) 


###### importando coordenadas ######
prod <- read.csv('produtores_07fev2014.csv',header=T,sep=';')
# limpando banco de coordenadas 
coord.limp <- subset(prod, select=c(CODIGO_PROPRIEDADE,LONGITUDE_DECIMAL,LATITUDE_DECIMAL))
View(coord.limp)


##### transformando de virgula p/ponto #####
# gta2012.coord col 15 e 16 'factor'
length(coord.limp)
class(coord.limp[,2]);class(coord.limp[,3])
# transformar para character
coord.limp[,2] <- as.character(coord.limp[,2]);coord.limp[,3] <- as.character(coord.limp[,3])
class(coord.limp[,2]);class(coord.limp[,3])
# trocarvirgula por ponto
coord.limp[,2] <- sub(',','.',coord.limp[,2]);coord.limp[,3] <- sub(',','.',coord.limp[,3])
View(coord.limp)
# tranformar para numero
coord.limp[,2] <- as.numeric(coord.limp[,2]);coord.limp[,3] <- as.numeric(coord.limp[,3])
class(coord.limp[,2]);class(coord.limp[,3])
coord.limp[1,2]


##### juntando GTAs 2012, 2013 e coordenadas #####
gtas <- rbind(gta.limp2012,gta.limp2013)
# renomeando as colunas COD_PROP_ORI=out, COD_PROP_DEST=In, TOTAL=weight
library('plyr')
gtas <- rename(gtas,c('COD_PROP_ORI'='Out','COD_PROP_DEST'='In','TOTAL'='weight'))
names(gtas)
# juntando gtas com coordenadas da origem=Out
coord.ori <- merge(gtas,coord.limp,by.x='Out',by.y='CODIGO_PROPRIEDADE')
View(coord.ori)
# juntando coord.ori c/ as coordenadas de destino=In
gtas.coords <- merge(coord.ori,coord.limp,by.x='In',by.y='CODIGO_PROPRIEDADE')
View(gtas.coords)
# renomear LONGITUDE_DECIMAL.x=long_out, LATITUDE_DECIMAL.x=lat_out, LONGITUDE_DECIMAL.y=long_in e LATITUDE_DECIMAL.y=lat_in
gtas.coords <- rename(gtas.coords,c('LONGITUDE_DECIMAL.x'='long_out','LATITUDE_DECIMAL.x'='lat_out',
                                    'LONGITUDE_DECIMAL.y'='long_in','LATITUDE_DECIMAL.y'='lat_in'))
names(gtas.coords)
# limpando as coordenadas que nao fazem sentido ou não existem
gtas.coords <- gtas.coords[which(gtas.coords$lat_out != ''),]
gtas.coords <- gtas.coords[which(gtas.coords$lat_in != ''),]
write.csv2(gtas.coords,'gtas.coords.csv',row.names=F)


# library("igraph", lib.loc="C:/Users/Mariana/Documents/R/win-library/3.0")
##### montar rede ##### 
rede_circuitos <- graph.data.frame(gtas.coords,directed=T)
# colocando coordenadas como atributos dos vertices
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='lat.out', value=gtas.coords$lat_out)
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='long.out', value=gtas.coords$long_out)
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='lat.in', value=gtas.coords$lat_in)
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='long.in', value=gtas.coords$long_in)
summary(rede_circuitos)
write.graph(graph=rede_circuitos,file='circuitos.graphml', format= 'graphml')

plot(rede_circuitos,as.list(E(rede_circuitos)$weight))
class(E(rede_circuitos)$weight)
warnings()
plot(rede_circuitos)
