install.packages('maptools')
install.packages('rgeos')
read
library(maptools)
shp <- readShapePoly('43mu500gc.shp')

plot(shp)
ncol(coord)
points(coord[1:500 , 15:16])

View(coord)
