banco_teste <- read.csv('baseGTAsuscetiveis2013.csv',header=T,sep=';')

banco_teste0 <- banco_teste[c(1:100,422479,422480,422495),] # selecionando algumas linhas para ficar mais facil de trabalhar
View(banco_teste0)
banco_teste0
#vendo str do banco_teste0
str(banco_teste0) # COD_PROP_ORI eh factor
# selecionar algumas colunas
names(banco_teste0)
banco_teste1 <- subset(banco_teste0,select=c(GTA, SERIE, ANO, FINALIDADE, TOT_OUTROS, COD_MUN_IBGE_ORI, MUNICIPIO_ORI,
                                                    PRODUTOR_ORI, COD_PROP_ORI, COD_MUN_IBGE_DEST, MUNICIPIO_DEST, 
                                                    PRODUTOR_DEST, COD_PROP_DEST))
View(banco_teste1)
