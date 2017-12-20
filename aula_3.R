##=====================================
##    Aula 3 - Datas e Strings 
##=====================================

# comando para limpar a memória

rm(list = ls())


## Antes de começar ===================================

# Como mudar somente um valor de uma determinada 
# variável??

library(haven)
library(tidyverse)
library(janitor)

base_qualquer %>% 
  mutate(nomevariavel = ifelse(nomevariavel))


setwd("~/Library/Mobile Documents/com~apple~CloudDocs")


# abrir base

base_wvs <- read_sav("wvs_2014.sav")


# renomear variaveis 

base_wvs <- base_wvs %>% 
  rename(sexo = V240, 
         homo = V203)


# tabular os resultados 

base_wvs %>% 
  tabyl(homo)


# modificar somente um valor (prefira "ifelse")

base_wvs %>% 
  mutate(homo = ifelse(homo == 3, 2, homo)) %>% 
  tabyl(homo)


# modificar somente dois valores (prefira "case_when")

base_wvs %>% 
  mutate(homo = case_when(homo == 4 ~ 2, 
                          homo == 3 ~ 2, 
                          TRUE ~ as.double(homo))) %>% 
  tabyl(homo)
  

base_wvs %>% 
  mutate(homo = case_when(homo == 3 ~ 2, 
                          homo == 4 ~ 2,
                          TRUE == homo)) %>% 
  tabyl(homo)


## Instalar pacotes lubridate e stringr ================

install.packages(c("lubridate", "stringr"))


## Abrir pacotes =======================================

library(lubridate)
library(stringr)
library(tidyverse)


## Começando pelas datas ===============================

hoje <- today()

hoje

## Extrair partes da data ==============================

year(hoje)
month(hoje)
day(hoje)

glimpse(hoje)


# Mas e se não estive configurado como "Date"? Ex:

data_qualquer <- "2017-09-13"

glimpse(data_qualquer)

data_qualquer <- ymd("2017-09-13")

glimpse(data_qualquer)

# http://www.statmethods.net/input/dates.html


## Mudar configuração da data ===================================

x <- c(1,2) 
y <- c("Sim", "Não")
data_qualquer <- c("2017-09-13", "2017-09-14")

base_datas_teste <- data.frame(x, y, data_qualquer)

glimpse(base_datas_teste)


## Transformar y factor em character ===============================

base_datas_teste <- base_datas_teste %>% 
  mutate(x = as.character(as.integer(x)))

base_datas_teste <- base_datas_teste %>% 
  dplyr::mutate(y = as.character(as.integer(y)))

# Usar factor somente com poucas categorias. Do contrário, usar 
# character.

glimpse(base_datas_teste)

## mostrar para o R que a data é data mesmo ======================

base_datas_teste <- base_datas_teste %>% 
  mutate(data_qualquer = ymd(data_qualquer))

glimpse(base_datas_teste)


# Se estivesse escrito = "13-09-2017", usar:
# base_datas_teste <- base_datas_teste %>% 
#   mutate(data_qualquer = dmy(data_qualquer))


# Se estivesse escrito = "09-13-2017", usar:
# base_datas_teste <- base_datas_teste %>% 
#   mutate(data_qualquer = mdy(data_qualquer))




## mudar formato da data ==========================================

base_datas_teste %>% 
  mutate(data_qualquer = format(data_qualquer, 
                                format = "%d %m %Y")) %>% 
  select(data_qualquer)

base_datas_teste %>% 
  mutate(data_qualquer = format(data_qualquer, 
                                format = "%d-%m-%Y"))

base_datas_teste %>% 
  mutate(data_qualquer = format(data_qualquer, 
                                format = "%d/%m/%Y"))

base_datas_teste %>% 
  mutate(data_qualquer = format(data_qualquer, 
                                format = "%d/%b/%Y"))

base_datas_teste %>% 
  mutate(data_qualquer = format(data_qualquer, 
                                format = "%d/%B/%Y"))

# vou adotar o mais convencional 

base_datas_teste <- base_datas_teste %>% 
  mutate(data_qualquer = format(data_qualquer,
                                format = "%d/%m/%Y"))

# para as configurações acima, ver: 
# http://www.statmethods.net/input/dates.html

glimpse(base_datas_teste)


## extrair o ano, o mês e o dia em novas variável =======================

base_datas_teste %>% 
  mutate(data_qualquer = dmy(data_qualquer)) %>% 
  mutate(Ano_novo = year(data_qualquer))

base_datas_teste %>% 
  mutate(data_qualquer = dmy(data_qualquer)) %>% 
  mutate(Mes_novo = month(data_qualquer))

base_datas_teste %>% 
  mutate(data_qualquer = dmy(data_qualquer)) %>% 
  mutate(Dia_novo = day(data_qualquer))


##========================================================
##          Strings (palavras)
##========================================================

rm(list = ls())

library(tidyverse) 
library(stringr) # pacote para lidar com palavras
library(rvest) # rvest para raspar dados

# install.packages("rvest") # para instalar o "rvest"

## Fazer uma raspagem de dados rápida no IMDB

url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'

webpage <- read_html(url)

rank_data_html <- html_nodes(webpage,'.text-primary')
posicao <- html_text(rank_data_html)
posicao <-  as.numeric(posicao)

titulo_data_html <- html_nodes(webpage,'.lister-item-header a')
titulo <- html_text(titulo_data_html)

descricao_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')
descricao <- html_text(descricao_data_html)
descricao <- gsub("\n","",descricao)

base_filmes <- data.frame(posicao, titulo, descricao)


# Mudar todos os títulos para caixa baixa

base_filmes %>% 
  mutate(titulo = str_to_lower(titulo)) %>% 
  select(titulo)
  
# Mudar todos os títulos para caixa alta

base_filmes %>% 
  mutate(titulo = str_to_upper(titulo)) %>% 
  select(titulo)

# Mudar todos os títulos para caixa alta seguido de caixa baixa

base_filmes %>% 
  mutate(titulo = str_to_title(titulo)) %>% 
  select(titulo)

# Tirar sinal agudo de cima do "o"

base_filmes %>% 
  mutate(titulo = str_replace_all(titulo, "ó", "o")) %>% 
  select(titulo)

# Tirar sinal circunflexo de cima do "o"

base_filmes %>% 
  mutate(titulo = str_replace_all(titulo, "ô", "o")) %>% 
  select(titulo)

# aconselho sempre a tirar todos os sinais!!!!

# Detectar palavras na base
base_filmes %>% 
  filter(str_detect(titulo, "Homem")) %>% 
  select(titulo)
  
# selecionar somente o último caso 
base_filmes %>% 
  filter(str_detect(titulo, "Homem$")) %>% 
  select(titulo)

# selecionar todos os filmes com a letra "A"
base_filmes %>% 
  filter(str_detect(titulo, "A")) %>% 
  select(titulo)

# selecionar todos os filmes que comecem com a letra "A"
base_filmes %>% 
  filter(str_detect(titulo, "^A")) %>% 
  select(titulo)

# incluir qualquer coisa antes das palavras
base_filmes %>% 
  mutate(titulo = str_pad(titulo, 40, side = "left", 
                          pad = "-")) %>% 
  select(titulo)

# criar variável com datas aleatórias
  
base_filmes <- base_filmes %>% 
  mutate(Data_mudar = seq(as.Date("1910/1/1"), as.Date("1999/1/1"), length.out = 100))

write_csv(base_filmes, "base_filmes_iesp.csv")


# Exercícios do dia (passo o script amanhã (14/09/2017)!

# Qualquer dúvida, mandem email: moreiradasilvathiago@gmail.com ou 
# thiagomoreira@iesp.uerj.br.






