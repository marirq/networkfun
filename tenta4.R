###### Fazendo o banco das redes ######
# juntar redes de 2012 e 2013
redes00 <- rbind(rede2012B,rede2013B)
#redes1 <- redes0[which(redes0$Out != ''),] # tirando as linhas com NAs na coluna Out 
View(redes00)
str(redes00)
#redes2 <- redes1[which(redes1$In != ''),] # tirando as linhas com NAs na coluna In
write.csv2(redes2,'redes2.csv',row.names=F)
View(redes2)
# tirando linhas inuteis pois nao estao com codigo # rede2012 que tem character no OUT
redes3 <- redes00[which(redes2$Out == 'L SÃO PAULO'),]
redes4 <- redes3[which(redes3$Out != 'GRANJA GRSC'),]
redes5 <- redes4[which(redes4$Out != 'CISPOA 432'),]
redes6 <- redes5[which(redes5$Out != 'CISPOA 861'),]
redes7 <- redes6[which(redes6$Out != 'CISPOA 821'),]
redes8 <- redes7[which(redes7$Out != 'GJ SCHOELER'),]
redes9 <- redes8[which(redes8$Out != 'SIM 003'),]
redes <- redes9[which(redes9$Out != 'WARMELING'),] # esse eh o banco das redes
# deixando as colunas Out e In como numeric
class(redes00[,1]);class(redes00[,2])
redes00[,1] <- as.numeric(redes00[,1]);redes00[,2] <- as.numeric(redes00[,2])
class(redes[,1]);class(redes[,2])