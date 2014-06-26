# juntando GTAs 2012 e 2013
gtas <- rbind(gta.limp2012,gta.limp2013)
View(gtas)
gtas1 <- gtas[which(gtas$COD_PROP_ORI != ''),]
gtas2 <- gtas[which(gtas$COD_PROP_DEST != ''),]
head(gtas)
tail(gtas)
names(gtas)

write.csv2(gtas,'gtas.csv',row.names=F,col.names=T)# pra ver o banco
setwd('C:/Users/Mariana/Desktop')

# juntando gtas com coordenadas
a1 <- merge(gtas,prod.limp,by.x='COD_PROP_ORI',by.y='CODIGO_PROPRIEDADE')
names(prod.limp)
plimp <- subset(prod.limp,select=c(CODIGO_PROPRIEDADE,LONGITUDE_DECIMAL,LATITUDE_DECIMAL))
names(plimp)
gtas.coord <- merge(a1,plimp,by.x='COD_PROP_DEST',by.y='CODIGO_PROPRIEDADE')
names(a1)
names(gtas.coord)
write.csv2(a1,'gtas.coord.ori.csv',col.names=T,row.names=F)
write.csv2(gtas.coord,'gtas.coord.csv',col.names=T,row.names=F)
View(gtas.coord)
setwd('C:/Users/Mariana/Desktop')
match_df(gtas,prod.limp)

names(gtas)
names(prod.limp)

x <- data.frame(k1 = c(NA,NA,3,4,5), k2 = c(1,NA,NA,4,5), data = 1:5)
y <- data.frame(k1 = c(NA,2,NA,4,5), k2 = c(NA,NA,3,4,5), data = 1:5)
merge(x, y, by = c("k1","k2")) # NA's match
merge(x, y, by = "k1") # NA's match, so 6 rows
merge(x, y, by = "k2", incomparables = NA) # 2 rows

