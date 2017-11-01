##============================================
##   Resposta (incompleta) Exercício Aula 9
##============================================

## Exercício:

## 1) Baixar os dados eleitores de 1998 e 2006. 

## 2) Selecionar os estados, os candidatos, os partidos, 
## e o campo de votacao do candidato (número de votos). 

## 3) Criar uma nova variável com a votação do candidato
## por estado. 

## 2) Colar as bases.

## 3) Mapear os dados de votação no segundo turno
## das eleições presidenciais. 

rm(list = ls())
options(scipen = 999) # tirar notação científica

pacman::p_load(electionsBR, tidyverse, haven, janitor)

eleicoes_2006 <- president_mun_vote(year = 2006, prop = F)

## limpar nomes (caixa baixa e _ entre as palavras)
## "clean_names()" é um comando do pacote "janitor"

eleicoes_2006 <- eleicoes_2006 %>% 
  clean_names()


## comando para conferir as alterações

names(eleicoes_2006)

## Vcs notaram bem: na base de 2006 temos duplicados.
## Isso pq tem um "BR" maluco na variável "codigo_municipio".
## Olhem só: 

eleicoes_2006 %>% 
  tabyl(sigla_uf)

## Logo, vou filtrar esse "BR".

eleicoes_2006 <- eleicoes_2006 %>% 
  filter(sigla_uf != "BR")

## Ok, problema resolvido. Agora vou fazer a contagem dos 
## votos por estado. Lembrando que a variável "total_votos"
## mostra os votos por município. Com efeito, temos que agrupar
## a soma por UF e por sigla_partido (já que temos dois 
## partidos diferentes concorrendo) e depois somar o total
## de votos por munícipio.
## Em seguida, vamos tirar a proporção dos votos recebidos nos 
## estados (e não por partido em cada estado!!!!). 
## Por isso, como o Felipe mostrou, temos que 
## usar o "ungroup" entre as duas operações para reagrupar
## só por estado depois.

eleicoes_2006 <- eleicoes_2006 %>% 
  group_by(sigla_uf, sigla_partido) %>% 
  mutate(votacao_partido = sum(total_votos)) %>% 
  ungroup() %>% 
  group_by(sigla_uf) %>% 
  mutate(votacao_total = votacao_partido/sum(total_votos))  


## Ok, tiramos a proporção dos votos dados aos dois partidos. 
## Mas, se olharmos para o realinhamento, só precisamos
## saber a votação do PT nos 27 estados. Fora isso, se filtrarmos
## a votação dos dois partidos, a gente vai duplicar o mapa dos 
## estados na hora de dar o join. Vou tirar o "ZZ" também (exterior).
## Logo, temos:

eleicoes_2006 <- eleicoes_2006 %>% 
  filter(sigla_partido == "PT") %>% 
  select(sigla_uf, sigla_partido, votacao_partido, votacao_total) %>% 
  filter(!duplicated(sigla_uf) & sigla_uf != "ZZ") 

## vamos salvar?

write_csv(eleicoes_2006, "eleicoes_2006.csv")

## Vamos abrir agora a base dos mapas dos estados 

pacman::p_load(tidyverse, janitor, haven, forcats, formattable,
               knitr,stringr, hrbrthemes, forcats, readxl, 
               rgdal, mapproj)

mapa_est_geral <- read_csv("mapa_est_geral.csv")

## Nas duas bases, temos em comum a sigla dos estados. 
## No entanto, o nome da variável não é o mesmo:

names(mapa_est_geral)
names(eleicoes_2006)

## Assim, temos que renomear uma das variáveis para que
## ambas fiquem com nomes iguais:

mapa_est_geral <- mapa_est_geral %>% 
  rename(sigla_uf = sigla) 

## Agora, sim, dá para dar um join tranquilo:

mapa_teste <- mapa_est_geral %>% 
  left_join(eleicoes_2006, by = "sigla_uf")  

## E que tal, o mapa? Querem incrementar?

mapa_teste %>% 
  ggplot(aes(longest, latest, group = group, fill = votacao_total)) + 
  geom_polygon() 

















