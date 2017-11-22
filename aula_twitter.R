##================================================
##     Aula Redes Sociais (Twitter)
##================================================

rm(list = ls())

pacman::p_load(twitteR, tm, topicmodels, 
               igraph, networkD3,
               tidyverse, stringr)

library(twitteR) # principal pacote
library(tm) # mineracao de texto
library(topicmodels) # mineracao de texto
library(igraph) # principal para analise de redes
library(networkD3) # visualizacao interativa
library(stringr) # mexer com palavras
library(tidyverse)
library(tidytext) # mexer com texto

##================================================
##           Análise de redes 
##================================================

## falar ainda de transformacoes, como no pdf aberto. 

library(igraph) # principal pacote 

quartz()

## Formas simples para escrever matrizes 

# com ligações diretas

g1 <- graph(edges=c(1,2, 2,3, 3, 1), n=3) 

g1

plot(g1)

## prestar atencao nisso: grafos nao sao plotados
## em data frames comuns. para lidar com analise 
## de redes temos que transformar os data frames 
## em listas de arestas (de preferência) 
## ou sociomatriz.

plot(g1)

# sem ligações diretas

g2 <- graph(edges=c(1,2, 2,3, 3, 1), n=3, 
            directed = F) 

plot(g2)

## com mais elementos

g3 <- graph(edges=c(1,2, 2,3, 3, 1), n=10) 

plot(g3)

# com nomes

g4 <- graph(edges=c("Maria","Joao", "Joao","Jose", 
                    "Jose", "Maria"), n=3) 

plot(g4)

# outra forma para escrever

g5 <- graph_from_literal(A--B, B-+C, C-+A)

g5

plot(g5)

g6 <- graph_from_literal("Joao"--"Natália", "Natalia"-+"Andres", 
                        "Andres"-+"Joao")

plot(g6)

## Abrir bases já prontas ================================================

nodes <- read.csv("Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

nodes
links

class(nodes)
class(links)

# links <- aggregate(links[,3], links[,-3], sum)
# links <- links[order(links$from, links$to),]
# colnames(links)[4] <- "weight"
# rownames(links) <- NULL

analise_midia <- graph.data.frame(links, nodes, 
                                  directed=T)

analise_midia

class(analise_midia)

## O que são esses v/c, v/n....???

glimpse(nodes)

## número de arestas (edges)

E(analise_midia)

## número de vértices/nós (nodes)

V(analise_midia)

## plotar os gráficos

plot(analise_midia)

plot(analise_midia, edge.arrow.size=.2, edge.color="orange",
     vertex.color="orange", vertex.frame.color="#ffffff",
     vertex.label=V(analise_midia)$media, vertex.label.color="black") 

plot(analise_midia, vertex.shape="none", vertex.label=V(analise_midia)$media, 
     vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.7, edge.color="gray85")


## mudar layouts

plot(analise_midia, layout = layout.random)

plot(analise_midia, layout = layout.circle)

plot(analise_midia, layout = layout.sphere)

## layout mais tradicional

plot(analise_midia, layout = layout.fruchterman.reingold)

analise_midia


## Grafo interativo 

head(links)

el <- links %>%
  mutate(from = as.numeric(as.factor(from))) %>% 
  mutate(from = from-1) %>% 
  mutate(to = as.numeric(as.factor(to))) %>% 
  mutate(to = to-1)  

# el <- data.frame(from=as.numeric(factor(links$from))-1, 
#                  to=as.numeric(factor(links$to))-1 )
# el
# head(nodes)


# nl <- cbind(idn=factor(nodes$media, levels=nodes$media), nodes) 
# 
# nl

head(nodes)

nl <- nodes %>% 
  mutate(idn = factor(media, levels(media)))

nl

forceNetwork(Links = el, Nodes = nl, Source="from", Target="to",
             NodeID = "idn", Group = "type.label",linkWidth = 1,
             linkColour = "#afafaf", fontSize=12, zoom=T, legend=T,
             Nodesize=6, opacity = 0.8, charge=-300, 
             width = 600, height = 400)


## onde aprender mais customizações?
## https://rpubs.com/kateto/netviz


## Algumas estatísticas =========================================

## 3 Medidas de proximidade 

## centralidade (centrality)
## por conexões diretas
## Quanto maior, mais importante

igraph::degree(analise_midia, mode="in")

nodes %>% 
  select(id, media) ## Wall Street

## proximidade (closeness)
## centralidade baseada na distância de outros nós
## Quanto maior, mais importante

igraph::closeness(analise_midia, mode="all", weights=NA) 

centr_clo(analise_midia, mode="all", normalized=T) 

## Intercessão (Betweenness)
## o quanto o nó se posiciona entre outros nós
## Quanto maior, mais importante

igraph::betweenness(analise_midia, directed=T, weights=NA)

## Onde aprender mais sobre essas medidas?
## Luke, Douglas. A User`s Guide to Network Analysis in R.


## Criar conta na API do Twitter ======================================

## 1) Entrar no site da API do Twitter:
## https://apps.twitter.com/

## 2) Entrar em "Create New App", preencher o formulário e apertar o
## botão "Create your Twitter application" no final da página. 

## 3) Uma vez criado, clique no seu novo perfil e vá em "Permissions".
## Mude o acesso de "Read and Write" para "Read, Write and Access
## direct messages" e confirme em "Update Settings". 
## Esse passo nos autoriza a usar todas as funções do pacote "TwitteR.

## 4) Em "Keys and Access Tokens", clique em "Create my Access Token".

## 5) Agora temos 4 informações relevantes para conectar na API do
## Twitter: "Consumer Key", "Consumer Secret", "Access Token", 
## "Access Token Secret". 

## 6) Copiar tudo no excel e salvar em ".csv".

## 7) Abrir o arquivo em que salvei os acessos ao Twitter. 

twitter_auth <- read_csv2("twitter_tokens.csv")

## 8) Pedir autorização para entrar no Twitter

my_Outh <- setup_twitter_oauth(twitter_auth$consumer_key, twitter_auth$consumer_secret,
                    twitter_auth$access_token, twitter_auth$access_secret)


## Tendências ======================================================

availableTrendLocations() 

head(availableTrendLocations())

availableTrendLocations() %>% 
  filter(name == "Brazil")

# importante saber o número do "woeid"

getTrends(23424768) 

tendencias_brasil <- getTrends(23424768) %>% 
  mutate(query = str_replace_all(query, "%22", "")) %>% 
  mutate(query = str_replace_all(query, "%23", "")) %>% 
  mutate(query = str_to_lower(query)) %>% 
  mutate(query = str_replace_all(query, "\\+", " "))  

names(tendencias_brasil)


## Olhar perfis dos usuários =======================================

## olhar timeline do Bolsonaro.

bolsonaro <- userTimeline("jairbolsonaro", n=110)

bolsonaro

class(bolsonaro)

## passar para data frame

bolsonaro <- twListToDF(bolsonaro)

names(bolsonaro)

bolsonaro %>% 
  select(text, retweetCount) %>% 
  arrange(-retweetCount)


## Olhar rede de amizades ===========================================

user <- getUser("jairbolsonaro")

friends <- user$getFriends()

## passar para data frame

friends <- twListToDF(friends)

names(friends)

friends %>% 
  select(screenName)

nome_amigos <- friends %>% 
  select(screenName)


## Olhar rede de seguidores

seguidores <- user$getFollowers()


## Bolsonaro neste momento ================================================== 

# estou pedindo 200 mensagens
bolso_trend <- searchTwitter("bolsonaro", 
                          n=200, lang = "pt") 

head(bolso_trend)
class(bolso_trend)

## problema: número limitado de tweets.

## mudar para data.frame 

bolso_trend <- twListToDF(bolso_trend)

library(stringi)

bolso_trend %>% 
  select(text)

bolso_str <- stri_trans_general(bolso_trend$text,"Latin-ASCII") 

bolso_str[10]

bolso_transf <- as.data.frame(dados_str)

library(tm)
corpus <- Corpus(VectorSource(bolso_str))

## realizar tratamento de múltiplos espaços
corpus <- tm_map(corpus, stripWhitespace) 

## transformar em letra minúsucula
corpus <- tm_map(corpus, tolower) 

## remover pontuação
corpus <- tm_map(corpus, removePunctuation)

## remover números
corpus <- tm_map(corpus, removeNumbers) 

## remover “stopwords”
corpus <- tm_map(corpus, removeWords, 
                 c(stopwords("portuguese"), "rt")) 

# corpus_text <- tm_map(corpus, PlainTextDocument)

# corpus_text[10]

Corpus_bolso <- Corpus(VectorSource(corpus)) 

library(wordcloud)
wordcloud(Corpus_bolso, max.words = 100)



## Nuvens de palavras =======================================================

bolso_trend <- str_extract_all(bolso_trend$text,
                               "@\\w+")

class(bolso_trend)

library(wordcloud)
library(tm)

Corpus_bolso <- Corpus(VectorSource(bolso_trend)) 

wordcloud(words = Corpus_bolso,
          scale=c(3,0.5),
          max.words=100,
          random.order=FALSE,
          rot.per=0.10,
          use.r.layout=TRUE)


## Análise de redes =====================================

bolsonaro <- searchTwitter("Bolsonaro", n=50)

bolsonaro <- twListToDF(bolsonaro)

names(bolsonaro)
head(bolsonaro, 3)

library(janitor)

## olhar primeiro quem mais falou o nome dele

bolsonaro %>% 
  tabyl(screenName) %>% 
  arrange(-n)

## plotar

bolsonaro %>% 
  tabyl(screenName) %>% 
  arrange(-n) %>% 
  slice(1:10) %>% 
  ggplot(aes(reorder(screenName,-n), n)) + 
  geom_bar(stat="identity") + coord_flip()

## agora entrar em análise de redes mesmo

## com o comando abaixo, filtrei os retweets, 
## e criou uma variável "emissor" tirando tudo que
## havia depois dos ":".

library(stringi)

bolsonaro %>% 
  tabyl(isRetweet)

e_bolso <- bolsonaro %>% 
  filter(isRetweet == "TRUE") %>% 
  mutate(text = str_replace_all(text, "RT", "")) %>% 
  mutate(emissor = stri_extract_first(text, regex="\\w+")) 

e_bolso

## em seguida, criei uma base final com os receptores 
## dessas mensagens + o número de vezes que emissores 
## e receptores interagiram. 

bolso_final <- e_bolso %>% 
  mutate(receptor = str_to_lower(screenName)) %>% 
  mutate(emissor = str_to_lower(emissor)) %>% 
  count(emissor, receptor)

write_csv(bolso_final, "Teste_gephi.csv")

class(bolso_final)

## passei essa base de data_frame para grafo. 

rt_graph <- graph_from_data_frame(d=bolso_final, directed=T)
write_csv(rt_graph, "Teste_gephi.csv")
plot(rt_graph)

## clusterizar para localizar melhor os padrões e 
## depois passar para d3.network.

wc <- cluster_walktrap(rt_graph)

members <- membership(wc)

members

d3_rt <- igraph_to_networkD3(rt_graph, group = members)

forceNetwork(Links = d3_rt$links, Nodes = d3_rt$nodes, 
             Source = 'source', Target = 'target', 
             NodeID = 'name', Group = 'group')

# #create an edge-list for retweet network
# sp = split(bolsonaro, bolsonaro$isRetweet)
# rt = mutate(sp[['TRUE']], sender = substr(text, 5, regexpr(':', text) - 1))
# el = as.data.frame(cbind(sender = tolower(rt$sender), receiver = tolower(rt$screenName)))
# el = count(el, sender, receiver) 
# el[1:5,] #show the first 5 edges in the edgelist
# 
# rt_graph <- graph_from_data_frame(d=el, directed=T)
# 
# glay = layout.fruchterman.reingold(rt_graph) 
# plot(rt_graph)
# 
# wc <- cluster_walktrap(rt_graph)
# 
# wc
# 
# members <- membership(wc)
# 
# d3_rt <- igraph_to_networkD3(rt_graph, group = members)
# 
# forceNetwork(Links = d3_rt$links, Nodes = d3_rt$nodes, 
#              Source = 'source', Target = 'target', 
#              NodeID = 'name', Group = 'group')


## Mapas ===========================================
## Complicado!!
library(stringr)


## Exercício do dia

# Entrar na página de algumx personagem famosx, 
# criar uma nuvem de palavras com os termos 
# mais vinculados a essa pessoa e fazer uma mini
# análise de redes. Tudo em 100 tweets.


library(igraph)
links = (BASEBALL_lM)





