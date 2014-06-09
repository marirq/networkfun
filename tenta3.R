ma <- rede2013[1:1000,]
str(ma)
ma$In <- as.character(ma$In)
View(ma)
ma1 <- ma[which(ma$Out==grep('^4',ma$Out,value=T)),]
ma2 <- ma[which(ma$In==grep('^4',ma$In,value=T)),]
View(ma)
View(ma1)
View(ma2)
grepl() # responde quais tem um padrao igual com logica TRUE ou FALSE
grep(...,value=TRUE) # responde quais tem um padrao igual com o numero da linha em que ele esta, o value=T faz mostrar o valor da cedula

aggdata[aggdata[,"Group.1"]==6 & aggdata[,"Group.2"]==0.05,"x"]
ma[which(ma$Out==grep('^4',ma$Out,value=T)),] # & ma$In==grep('^4',ma$In,value=T)),]
ma <- ma[which(ma$Out != ''),]
ma <- ma[which(ma$In != ''),]
gta2013a <- gta2013[which(gta2013$ESPECIE_ANIMAL == 'Suíno'),]