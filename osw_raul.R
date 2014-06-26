install.packages('maptools')
install.packages('rgeos')
read
library(maptools)
shp <- readShapePoly('43mu500gc.shp')

plot(shp)
ncol(coord)
points(coord[1:500 , 15:16])

View(coord)
library(igraph)
plot.igraph(rede_circuitos)

# Ze me passou para fazer o grafo
rede_circuitos <- graph.data.frame(gtas)
rede_circuitos <- graph.adjacency(adjmatrix=rede, diag=F, weighted=T)
head(rede_circuitos)
# graph.adjlist
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='latitude', value=prod.limp$LATITUDE_DECIMAL)
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='longitude', value=prod.limp$LONGITUDE_DECIMAL)
summary(rede_circuitos)
write.graph(graph=rede_circuitos,file='circuitos.graphml', format= 'graphml')

ordem_codigos_no_grafo <- get.vertex.attribute(graph=rede_circuitos, name='ID')

for (i in 1:length(banco$id) )
  nova_laitude[i] <- banco$latitude[ which(banco$cadastro == ordem_codigos_no_grafo[i] ) ]

rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='latitude', value=NOVA_latitude)