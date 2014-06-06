


rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='latitude', value=prod.limp$LATITUDE_DECIMAL)
rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='longitude', value=prod.limp$LONGITUDE_DECIMAL)
summary(rede_circuitos)
write.graph(graph=rede_circuitos,file='circuitos.graphml', format= 'graphml')

ordem_codigos_no_grafo <- get.vertex.attribute(graph=rede_circuitos, name='Out')

str(gtas.limp2)
for (i in 1:length(gtas.limp2$Out)[1:10] )
  nova_laitude[i] <- prod.limp$LATITUDE_DECIMAL[ which(prod.limp$CODIGO_PROPRIEDADE == ordem_codigos_no_grafo[i] ) ]

rede_circuitos <- set.vertex.attribute(graph=rede_circuitos, name='latitude', value=NOVA_latitude)

### mari.lock codigo
rede_circuitos <- graph.data.frame(gtas,directed=T)


b <- E(rede_circ)
class(b)
?igraph.es
str(b)
