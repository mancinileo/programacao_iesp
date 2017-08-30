##==========================================================
##
##   AULA 1: APRESENTAÇÃO DO RSTUDIO - COMANDOS BÁSICOS 
##
##==========================================================

## Comandos básicos ========================================

# Ctrl(Command) + Enter para rodar comandos no script

1 + 1

# Detalhe: hashtag para comentar

### Criar bases 

x <- c(1, 2, 3, 4, 5, 6, 7)
y <- c("Sim", "Nao", "Sim", "Nao", "Sim", "Nao", "Sim")

dados <- data.frame(x, y)

# Detalhe: "c" de "combine", usado para se referir a mais de um valor. 
# Detalhe 2: palavras devem ser envoltas por aspas. 


### Saber o nome das variáveis ==================================

names(dados)

### Saber a categoria das variáveis (numéricas ou categóricas) ==

str(dados)

### Sumarizar os dados (melhor para contínuas) ==================

summary(dados)

# Outra forma: 

mean(dados$x)
median(dados$x)
sd(dados$x)
quantile(dados$x)

# Pergunta: alguém sabe o que é desvio-padrão?


### Tabular os dados (usado para categóricas) ================

# números absolutos
table(dados$y)

# porcentagens
prop.table(table(dados$y))


### Pacotes ===================================================

# install.packages("nome_do_pacote")

# library(nome_do_pacote)

# Exemplo 

install.packages("car", dependencies = TRUE) # basta instalar uma vez. 

library(car) # tem que rodar o pacote toda vez

update.packages() # atualizar pacotes (fazer de vez em quando)


### Atalhos importantes ========================================

# ctrl(cmd) + shift + C = comentários

# alt + - = criar objeto

# ctrl(cmd) + shift + H = setwd() = acertar o diretório

# ctrl(cmd) + D = apaga a linha

# ctrl(cmd) + shift + m = pipe (importante para tidyverse)

# tab = completar o nome sugerido pelo Rstudio 


### Exemplos de análise ======================================

# Como o R performa

getwd() # saber o diretório de trabalho

dir() # para saber o que tem no diretório 

setwd() # ou ctrl + shift + H

file.choose()


### Aprovação do aborto no WVS ======================================

# site: http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp

# nome da variável no banco: V204

# install.packages(c("tidyverse", "haven", "janitor", "formattable",
#                    "hrbrthemes", "ggthemes"))

library(tidyverse) # pacote base para mexer no R
library(haven) # pacote para importar outros formatos
library(janitor) # pacote para tirar tabulações 
library(formattable) # colocar em porcentagens
library(hrbrthemes) # tema para o gráfico
library(ggthemes) # tema para o gráfico

getwd()

setwd()

dir()

wvs_aborto <- read_spss("WV6_Data_Brasil_2014_spss_v_2016-01-01.sav")

names(wvs_aborto) # saber os nomes das variáveis

# Frequências simples
wvs_aborto %>% 
  rename(aborto = V204) %>% 
  tabyl(aborto) 

# Frequências divididas em 4 categorias
wvs_aborto %>% 
  rename(Aborto = V204) %>% 
  mutate(Aborto = case_when(Aborto <= 4 ~ "contra",
                            Aborto %in% c(5, 6) ~ "tanto faz",
                            Aborto >= 6 ~ "favorável",
                            TRUE ~ "NS")) %>% 
  tabyl(Aborto) %>% 
  rename(Número = n,
         Porcentagem = percent) %>% 
  mutate(Porcentagem = percent(Porcentagem))

  
# Frequências em gráfico  
wvs_aborto %>% 
  rename(Aborto = V204) %>% 
  mutate(Aborto = case_when(Aborto <= 4 ~ "Contra",
                            Aborto %in% c(5, 6) ~ "Tanto Faz",
                            Aborto >= 6 ~ "Favorável",
                            TRUE ~ "NS")) %>% 
  tabyl(Aborto) %>% 
  rename(Número = n,
         Porcentagem = percent) %>% 
  mutate(Porcentagem = percent(Porcentagem)) %>% 
  ggplot(aes(Aborto, Porcentagem)) + geom_bar(stat = "identity") + 
  theme_fivethirtyeight() + scale_y_percent() +  
  labs(x = "", y = "", title = "Posicionamentos sobre o Aborto (2014)")

# https://fivethirtyeight.com/features/the-job-market-is-having-a-goldilocks-moment/

# https://github.com/jrnold/ggthemes
  

### Gráficos dinâmicos ==============================================

# install.packages("leaflet", dependencies = T)

library(leaflet) # fazer mapas dinâmicos

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng=174.768, lat=-36.852, popup="The birthplace of R")
m  # Print the map


library(plotly) # para fazer gráficos interativos (no caso, linhas)
library(reshape2)

teste <- data_frame(Ano = c(1989, 1991, 1993, 1995, 1997, 1998, 2000,
                            2002, 2003, 2004, 2005, 2006, 2007, 2008,
                            2009, 2010, 2011, 2012, 2013, 2014),
                    Left = c(22, 26, 27, 22, 26, 19, 25, 20, 20, 22, 32, 26, 
                             26, 25, 28, 25, 23, 23, 27, 29),
                    Center = c(19, 33, 23, 23, 24, 29, 25, 23, 22, 22, 24, 35, 
                               24, 26, 27, 24, 26, 31, 24, 26),
                    Right = c(35, 26, 44, 30, 33, 26, 35, 30, 29,26, 30,
                              27,28, 27, 26, 27, 26, 26, 29, 29),
                    DK = c(24, 8, 26, 20, 22, 27, 26, 19, 22, 27, 26, 22, 
                           22, 23, 19, 25, 26, 16, 19, 17))


mdata <- melt(teste, id=c("Ano"))

g <- ggplot(mdata, aes(x = Ano, y=value, colour = variable)) + geom_line(size=1) +
  scale_y_continuous(limits = c(0,50), breaks = c(0, 5, 10, 15, 20, 25, 30, 35, 40,
                                                  45, 50)) + theme_bw() + 
  theme(legend.title = element_blank()) + labs(y = "%", x = "Ano") + 
  scale_color_manual(values=c("#FF0000", "#336600", "blue", "#996666")) 

ggplotly(g)

