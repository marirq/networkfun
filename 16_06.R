###### testanto limpar o gte.limp2012, ver se e ai que o erro aparece
names(gta.limp.2012)
library(plyr)
# tocando os nomes das colunas COD_PROP_ORI por Out, COD_PROP_DEST por In e TOT_OUTROS por Weight
gta.limp.2012 <- rename(gta.limp2012,c('COD_PROP_ORI'='Out','COD_PROP_DEST'='In','TOT_OUTROS'='Weight'))
names(gta.limp.2012)

# tirando linhas inuteis pois nao estao com codigo
gta.limp2012.X <- gta.limp.2012[which(gta.limp.2012$Out > '100000000'),]
class(gta.limp.2012$Out)
gta.limp2012.y <- as.numeric(gta.limp.2012$Out)
class(gta.limp.2012$Out)
gta.limp2012.y <- gta.limp2012.X[which(gta.limp2012.X$In != ''),]
View(gta.limp2012.y)
write.csv2(gta.limp2012.X,'gta_xy.csv',col.names=TRUE,row.names=FALSE,sep=';')
redes4 <- redes3[which(redes3$Out != ''),]
redes5 <- redes4[which(redes4$Out != 'CISPOA 432'),]
redes6 <- redes5[which(redes5$Out != 'CISPOA 861'),]
redes7 <- redes6[which(redes6$Out != 'CISPOA 821'),]
redes8 <- redes7[which(redes7$Out != 'GJ SCHOELER'),]
redes9 <- redes8[which(redes8$Out != 'SIM 003'),]
redes <- redes9[which(redes9$Out != 'WARMELING'),] # esse eh o banco das redes