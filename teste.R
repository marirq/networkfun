names(gtas)
length(gtas)
library('igraph')
# reordenando para usar graph.data.frame
# gtas <- gtas[,c(9,)]
# tirando os produtores que nao tem codigo
gtas.limp <- gtas[which(gtas$Out != ''),]
gtas.limp2 <- gtas.limp[which(gtas.limp$In != '' ),]
gtas.limp3 <- gtas.limp2[which(gtas.limp2$Out != '0'),]
names(gtas.limp3)
gtas.limp4 <- gtas.limp3[which(gtas.limp3$Out!= 'string'),]
class(gtas.limp2$Out)
gtas.limp2$Out[18727]
View(gtas[18077:18097,])
write.csv2(gtas,'gtas2.csv',row.names=F,col.names=T)
write.csv2(gtas.limp3,'gtas3.csv',row.names=F,col.names=T)

# renomeando as colunas COD_PROP_ORI=out, COD_PROP_DEST=In, TOTAL=weight
library('plyr')
gtas <- rename(gtas,c('COD_PROP_ORI'='Out','COD_PROP_DEST'='In','TOTAL'='weight'))

rede_circuitos <- graph.data.frame(gtas.limp2,directed=T)

plot(rede_circuitos,edge.width=E(rede_circuitos)$weight)
summary(rede_circuitos)

graph.adjlist(rede_circuitos[])
write.csv2(gtas.limp2,'gtas22.csv',row.names=F,col.names=T)
