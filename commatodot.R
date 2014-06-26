# coord col 2 e 3 'factor'
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
