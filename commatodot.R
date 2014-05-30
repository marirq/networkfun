# gta2012.coord col 15 e 16 'factor'
class(gta2012.coord[,15]);class(gta2012.coord[,16])

# transformar para character
gta2012.coord[,15] <- as.character(gta2012.coord[,15]);gta2012.coord[,16] <- as.character(gta2012.coord[,16])
class(gta2012.coord[,15]);class(gta2012.coord[,16])

# trocarvirgula por ponto
gta2012.coord[,15] <- sub(',','.',gta2012.coord[,15]);gta2012.coord[,16] <- sub(',','.',gta2012.coord[,16])
View(gta2012.coord)

# tranformar para numero
gta2012.coord[,15] <- as.numeric(gta2012.coord[,15]);gta2012.coord[,16] <- as.numeric(gta2012.coord[,16])
class(gta2012.coord[,15]);class(gta2012.coord[,16])
gta2012.coord[1,15]
