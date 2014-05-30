dir()
###### importando GTAs 2013 ######
gta2013 <- read.csv('baseGTAsuscetiveis2013.csv',header=T,sep=';')
names(gta2013)
# ver os nomes q estao nessa coluna
levels(gta2013[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2013a <- gta2013[which(gta2013$ESPECIE_ANIMAL == 'Suíno'),]
names(gta2013a)
View(gta2013a)
# tirando as colunas extras
gta.limp2013 <- subset(gta2013a, select=c(ANO,GTA, SERIE,FINALIDADE,TOTAL,COD_MUN_IBGE_ORI,MUNICIPIO_ORI,PRODUTOR_ORI,
                                          COD_PROP_ORI,COD_MUN_IBGE_DEST,PRODUTOR_DEST,COD_PROP_DEST)) 
View(gta.limp2013)
write.csv2(gta.limp2013,'gta2013_sui.csv',row.names=F)
head(gta.limp2013)


###### importando GTAs 2012 ######
gta2012 <- read.csv('baseGTAsuscetiveis2012.csv',header=T,sep=';')
names(gta2012)
# ver os nomes q estao nessa coluna
levels(gta2012[,'ESPECIE_ANIMAL'])
# para limpar o banco, deixando so as movimentacoes de suinos - eliminando as outras linhas
gta2012a <- gta2012[which(gta2012$ESPECIE_ANIMAL == 'Suíno'),]
names(gta2012)
# tirando as colunas extras
gta.limp2012 <- subset(gta2012a, select=c(ANO,GTA, SERIE,FINALIDADE,TOTAL,COD_MUN_IBGE_ORI,MUNICIPIO_ORI,PRODUTOR_ORI,
                                          COD_PROP_ORI,COD_MUN_IBGE_DEST,PRODUTOR_DEST,COD_PROP_DEST)) 
View(gta.limp2012)
write.csv2(gta.limp2012,'gta2012_sui.csv',row.names=F)


###### importando coordenadas ######
prod <- read.csv('produtores_07fev2014.csv',header=T,sep=';')
names(prod)
View(prod)
# limpando banco de coordenadas (maptools usa coordenadas decimais e primeiro LON depois LAT)
prod.limp <- subset(prod, select=c(MUNICIPIO_PROPRIEDADE,PROPRIEDADE,CODIGO_PROPRIEDADE,PRODUTOR,LONGITUDE_DECIMAL,
                                   LATITUDE_DECIMAL,TOT_SUINO))
View(prod.limp)
ncol(prod.limp)
class(prod.limp[,5])
# juntando as coordenadas com as GTAs pela origem
gta2012.coord <- merge(gta.limp2012,prod.limp,by.x='COD_PROP_ORI',by.y='CODIGO_PROPRIEDADE')
View(gta2012.coord)
write.csv2(gta2012.coord,'gta2012_coord.csv',row.names=F)
View(gta.limp2012)
# juntando GTAs de 2012 e 2013
# no arquivo joinDf.R


###### transformando de comma p/dot ######
# gta2012.coord col 15 e 16 'factor'
class(gta2012.coord[,15]);class(gta2012.coord[,16])
# transformar para character
gta2012.coord[,15] <- as.character(gta2012.coord[,15]);gta2012.coord[,16] <- as.character(gta2012.coord[,16])
class(gta2012.coord[,15]);class(gta2012.coord[,16])
# trocar virgula por ponto
gta2012.coord[,15] <- sub(',','.',gta2012.coord[,15]);gta2012.coord[,16] <- sub(',','.',gta2012.coord[,16])
View(gta2012.coord)
# tranformar para numero
gta2012.coord[,15] <- as.numeric(gta2012.coord[,15]);gta2012.coord[,16] <- as.numeric(gta2012.coord[,16])
class(gta2012.coord[,15]);class(gta2012.coord[,16])
gta2012.coord[1,15]


###### mapa com produtores ######
install.packages('maptools');install.packages('rgeos')
library(maptools)
shp <- readShapePoly('43mu500gc.shp')
plot(shp)
points(gta2012.coord[ 1:10000, 15:16],col='blue')