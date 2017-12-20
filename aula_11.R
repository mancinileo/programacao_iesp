##============================================
##
##  Aula 11: raspagem de dados (webscraping)
##
##============================================

rm(list = ls())
gc()

pacman::p_load(stringr, tidyverse, rvest,
               XML)

library(tidyverse)
library(stringr) # manipular caracteres
library(XML) # manipular sites
library(rvest) # raspar dados

##===================================
##        Raspagens simples 
##===================================

url <- "http://www.imdb.com/chart/top"

## Ler a url 

ranking_imdb <- read_html(url)

## "Parsear" a url

htmlParse(url, encoding = "UTF-8")

# 244 - A Criada

## Pegar os títulos dos filmes

titulos <- ranking_imdb %>% 
  html_nodes(".titleColumn a") %>% 
  html_text() 

class(titulos)

## Salvar em data frame

titulos_imdb <- data_frame(titulos)

## Pegar notas dos filmes

notas_imdb <- ranking_imdb %>% 
  html_nodes("strong") %>% 
  html_text()

## Salvar em data frame

notas_imdb <- data_frame(notas_imdb)

## Juntar as duas colunas numa base só

base_final_imdb <- bind_cols(notas_imdb, titulos_imdb)


## Exemplo 2: Grupos Pesquisa IESP =======================

url <- "https://pt.wikipedia.org/wiki/Instituto_de_Estudos_Sociais_e_Pol%C3%ADticos_da_Universidade_do_Estado_do_Rio_de_Janeiro"
  
grupos_iesp <- read_html(url)  
  
nomes_grupos <- grupos_iesp %>% 
  html_nodes("p+ p b") %>% 
  html_text()

nomes_grupos <- data_frame(nomes_grupos)
  
email_grupos <- grupos_iesp %>% 
  html_nodes(".free") %>% 
  html_text()

email_grupos <- data_frame(email_grupos)  

base_final_iesp <- bind_cols(nomes_grupos, email_grupos)


## Exemplo 3: Premier League ==========================

url <- "http://www.espn.com/soccer/table/_/league/eng.1"

premier_league <- read_html(url)

tabela_pl <- html_table(premier_league, fill = TRUE)[[1]]


## Exemplo 4: Presidentes do Brasil ===================

url <- "https://pt.wikipedia.org/wiki/Lista_de_presidentes_do_Brasil"

pres_brasil <- read_html(url)

tabela_pres <- html_table(pres_brasil, fill = TRUE)[[1]]


## Exemplo 5: Scielo: Revista Dados ===================

url <- "http://www.scielo.br/scielo.php?script=sci_issuetoc&pid=0011-525820170002&lng=en&nrm=iso"

pagina_dados <- read_html(url)

titulos <- pagina_dados %>% 
  html_nodes("b") %>% 
  html_text()

autores <- pagina_dados %>% 
  html_nodes(".normal a") %>%
  html_text()
  
autores_data <- data.frame(autores)


##=====================================
##    Raspagens mais complexas
##=====================================

# http://www.scielo.br/scielo.php?script=sci_issues&pid=0011-5258&lng=en&nrm=iso

# Analisar padroes de 2016

http://www.scielo.br/scielo.php?script=sci_issuetoc&pid=0011-525820160001&lng=en&nrm=iso
http://www.scielo.br/scielo.php?script=sci_issuetoc&pid=0011-525820160002&lng=en&nrm=iso
http://www.scielo.br/scielo.php?script=sci_issuetoc&pid=0011-525820160003&lng=en&nrm=iso
http://www.scielo.br/scielo.php?script=sci_issuetoc&pid=0011-525820160004&lng=en&nrm=iso

## Criar nomes das bases

base_site <- "http://www.scielo.br/scielo.php?script=sci_issuetoc&pid=0011-52582016"

complemento <- paste0(sprintf('%0.4d', 1:4), "&lng=en&nrm=iso")

urls <- paste0(base_site, complemento)

## Criar funcao para extrair titulos das bases

## funcao simples

funcao_teste <- function(x) {
  # comando para abrir as páginas
  paginas <- read_html(x)
  # comando para ler os títulos da revista
  
  # usar os titulos que busquei e salvar em data frame
  data.frame(
    titulos <- paginas %>% 
      html_nodes("b") %>% 
      html_text()
    # renomear a variável
  )
}

dados_2016 <- map_df(urls, funcao_teste)

## funcao mais caprichada

funcao_final <- function(file) {
  # comando para mostrar o progresso da função
  cat(".")
  # comando para abrir as páginas
  page <- read_html(file)
  # comando para ler os títulos da revista
  titulos <- page %>% 
    html_nodes("b") %>% 
    html_text() 
  # usar os titulos que busquei e salvar em data frame
  data.frame(
    # renomear a variável
    Titulos = titulos  
  )
}

dados_2016 <- map_df(urls, funcao_final)

