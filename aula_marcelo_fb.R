############# Marcelo Alves
########## TESE
######### Script - Get Likes


setwd("C:/Users/Marcelo Alves/Dropbox/TESE/scripts")
rm(list=ls(all=TRUE))


# ler banco de dados
congresso_seed <- read.csv("congresso_seed.csv")
congresso_seed$id <- as.character(congresso_seed$id)

# subset para teste
congresso_seed <- congresso_seed[c(1:5),]

# coleta 
library('Rfacebook')


#autorizar

token <- "EAACEdEose0cBAChM2kUBtIlKtvsMaR7clOlBUm9z9FFr9vCA2LrVCGdmE3WvZAWR9ej0IhNL6uBStBaEq4M7V8N6TLroNRWZB2MIAaiRXfINZC1UZANoVtw14DEIrOStyoNhkoA3jpXCmg6okbLJ7ZACPG25ZChVW9QfL6uLt130Ed4PLhDWdJOLSSbyJpyTUZD"

#repeticao
l <- length(congresso_seed$id)
congresso_retorno_seed_final_ok <- data.frame()
for (z in 1:l) {
  try({
    congresso_retorno_seed_final_ok <- rbind(congresso_retorno_seed_final_ok, cbind(cbind(congresso_seed$id[z], getLikes(congresso_seed$id[z], token, n=10000))))
  })
}
write.csv2(congresso_retorno_seed_final_ok, "Congresso_Coleta_Final_Retorno_Bruto.csv")



################# pós-processamento

## contagem do retorno 

c <- as.data.frame(table(congresso_retorno_seed_final_ok$id))
names(c) <- c("id", "contagem")


# eliminar duplicatas
congresso_retorno_nodes <- subset(congresso_retorno_seed_final_ok,!duplicated(congresso_retorno_seed_final_ok$id))

# mesclar banco de dados
congresso_retorno_nodes <- merge(congresso_retorno_nodes, c)

rm(c)

########## Exportar lista de nós retorno

# limpar aresta para nodes

congresso_retorno_nodes[,2] <- NULL

# exportar nodes

write.csv2(congresso_retorno_nodes, "Congresso_Nodes_Final.csv")

########## Exportar lista de arestas retorno

Source <- congresso_retorno_seed_final_ok[,1]
Target <- congresso_retorno_seed_final_ok$id
arestas <- data.frame(Source, Target, row.names = NULL)
write.csv2(arestas, "Congresso_Arestas_Final.csv")
