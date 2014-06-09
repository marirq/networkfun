###### Fazendo o banco das redes ######
# juntar redes de 2012 e 2013
redesA <- rbind(rede2012,rede2013) 
# ver estrutura de redeaA e transformar para character se preciso
str(redesA)
redesA$Out <- as.numeric(redesA$Out) 
str(redesA)
redesB <- redesA[which(redesA$Out == nchar(4300034000)),] 
redes2 <- redes1[which(redes1$In != ''),]

str(redesA$Out)
redesA$Out <- as.character(redesA$Out);redesA$In <- as.character(redesA$In);redesA$Weight <- as.character(redesA$Weight)
str(redesA)
names(redesA)


grep(patter='^43',byb$Out)


str(byb)
byb
byb <- redesA[1:5,]
byb$Out <- as.character(byb$Out)

redesA[which(redesA$Out == 513),]
redesA[1,]
View(redesA)
min(redesA$Out)
which(redesA$In==grep(patter='^0',redesA$In))



grep(patter='^',redesA$In)
