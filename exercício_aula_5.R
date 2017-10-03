##================================
##     Exercícios da aula 5
##================================


# 1) Com a base "mapa_mun_geral.csv", categorizar o pib em 
# 4 percentis, mapear o Brasil primeiro e depois mapear os
# estados de MG e PA (segundo classificação do IBGE). Mapas
# não devem ter fundo e apresentar uma combinação de cores
# que não seja cafona.


## Limpar memória

rm(list = ls())


## Acertar diretório ========================================

setwd("C:/Users/thiagomoreira/iCloudDrive")

## Abrir pacotes do jeito bacana ============================

pacman::p_load(tidyverse, haven, janitor, plotly,
                rgdal, mapproj)


## Abrir pacotes do jeito ruim ==============================

library(tidyverse)
library(haven)
library(janitor)
library(plotly)
library(rgdal) # pacote para gráficos
library(mapproj) # pacote para gráficos


## Abrir base ===============================================

mapa_mun_geral <- read_csv("mapa_mun_geral.csv")


##===========================================================
## Saber os quantis da distribuição do PIB. 
## - Como eu pedi para cortar a variável em 4. Vale um cálculo
## simples: 100/4 = 25. Logo, vou segmentar a variável de 0
## a 25%, 25% a 50%, 50% a 75% e 75% a 100%. 
##===========================================================

quantile(mapa_mun_geral$pib)

## Detalhe: como o "$" eu digo para o R qual a variável eu quero
## (pib, no caso) dentro da base mapa_mun_geral.

##===========================================================
## Cortar PIB em quatro 
## - Gente, o case_when é complicado, eu sei. Por isso, vale
## testar o comando antes. Para isso, eu uso o comando 
## "tabyl", do pacote "janitor", depois de segmentar o PIB. 
## Tudo, claro, ligado pelo pipe (%>%).
##===========================================================

mapa_mun_geral %>% 
  mutate(pib_cat = case_when(pib <= 64527 ~ "Categoria 1",
                             pib >= 64528 & pib <= 136381 ~ "Categoria 2",
                             pib >= 136382 & pib <= 353027 ~ "Categoria 3",
                             pib >= 353028 ~ "Categoria 4")) %>% 
  tabyl(pib_cat)


## Detalhe: EU NÃO ALTEREI A BASE. PARA ALTERAR A BASE EU TENHO 
## QUE DIZER PARA O R QUE EU VOU SALVAR UMA NOVA CONFIGURAÇÃO
## EM CIMA DA ANTIGA. EXEMPLO ABAIXO:

mapa_mun_geral <- mapa_mun_geral %>% 
  mutate(pib_cat = case_when(pib <= 64527 ~ "Categoria 1",
                             pib >= 64528 & pib <= 136381 ~ "Categoria 2",
                             pib >= 136382 & pib <= 353027 ~ "Categoria 3",
                             pib >= 353028 ~ "Categoria 4"))  


## DETALHE: ACIMA EU MODIFIQUEI A BASE, POIS INCLUÍ O COMANDO 
## "mapa_mun_geral <-" ANTES DO NOME DA BASE, MOSTRANDO PRO 
## R QUE, NA BASE TRABALHADA, EU QUERO ACRESCENTAR UMA VARIÁVEL
## CHAMADA "pib_cat", CODIFICADA A PARTIR DA VARIÁVEL NATIVA
## (ALÔ, ANTROPOLOGIA!!!) "pib".


## Mapas ==========================================================

## Aqui, vamos do mais simples ao mais complexo. 

## Parte 1) Configuração mais simples.

mapa_mun_geral %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(x = longmun, y = latmun, group = group, fill = pib_cat)) + 
  geom_polygon()

## Detalhe: nos mapas, devemos incluir a longitude no eixo x, 
## a latitude no eixo y, o grupo e uma variável para completar 
## nossa visualização. Essa variável deve ser categórica, de
## preferência. Por isso, cortamos a variável "pib" em 4
## categorias. 

## Parte 2) Acertar o "esgarçamento". 
## Por padrão, o R nos mostra um mapa meio "esgarçado". Para 
## ajustar isso, usamos o comando "coord_map". 

mapa_mun_geral %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(longmun, latmun, group = group, fill = pib_cat)) + 
  geom_polygon() + coord_map()


## Parte 3) Linhas divisórias
## Sempre é interessante colocar linhas dividindo as unidades
## de análise - sejam elas distritos, bairros, condados, estados, 
## etc. Para tanto, incluímos a cor e o tamanho das linhas dentro
## do comando "geom_polygon".

mapa_mun_geral %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(longmun, latmun, group = group, fill = pib_cat)) + 
  geom_polygon(color = "black", size = 0.25) + coord_map()


## Parte 4) Tirar tema
## Para deixar o gráfico menos "poluído", podemos usar o comando
## "theme_void()"

mapa_mun_geral %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(longmun, latmun, group = group, fill = pib_cat)) + 
  geom_polygon(color = "black", size = 0.25) + coord_map() + theme_void()  


## Parte 5) Acertar cores
## Com o "scale_fill_manual" acertamos as cores do mapa. Lembrando que
## este comando difere do "scale_color_manual" em um sentido: o primeiro
## colore nossos índices por dentro, enquanto o segundo acerta as cores 
## do contorno dos índices. Sobre cores, ver:
## http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/

mapa_mun_geral %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(longmun, latmun, group = group, fill = pib_cat)) + 
  geom_polygon(color = "black", size = 0.25) + coord_map() + theme_void() +   
  scale_fill_manual(name = "", 
                    labels = c("Categoria 1", "Categoria 2",
                               "Categoria 3", "Categoria 4"),
                    values = c("#d7191c", "#fdae61", "#ffffbf",
                               "#abdda4"))


## Mapas do RJ e do PA ==============================================

## Basta filtrar os estados pela variável UF. 

## Mapa do RJ

mapa_mun_geral %>% 
  filter(uf == "RJ") %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(longmun, latmun, group = group, fill = pib_cat)) + 
  geom_polygon(color = "black", size = 0.25) + coord_map() + theme_void() + 
  scale_fill_manual(name = "", 
                    labels = c("Categoria 1", "Categoria 2",
                               "Categoria 3", "Categoria 4"),
                    values = c("#d7191c", "#fdae61", "#ffffbf",
                               "#abdda4"))


## Mapa do PA

mapa_mun_geral %>% 
  filter(uf == "PA") %>% 
  mutate(pib_cat = factor(pib_cat)) %>% 
  ggplot(aes(longmun, latmun, group = group, fill = pib_cat)) + 
  geom_polygon(color = "black", size = 0.25) + coord_map() + theme_void() + 
  scale_fill_manual(name = "", 
                    labels = c("Categoria 1", "Categoria 2",
                               "Categoria 3", "Categoria 4"),
                    values = c("#d7191c", "#fdae61", "#ffffbf",
                               "#abdda4"))

##===========================================================
## P.S: tive um problema com "coord_map" aqui no meu PC. 
## Acho que é pq atualizei o R e o pacote ainda não foi
## atualizado para a nova versão. Logo, se não estiverem
## conseguindo rodar os gráficos, experimentem tirar
## o comando. 
##===========================================================

## É isso. Qq dúvida, email. 


