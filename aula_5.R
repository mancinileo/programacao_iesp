##===========================================
##              Aula 5 - Mapas
##===========================================

rm(list = ls())

## Antes, alguns macetes:

## Abrir vários pacotes de uma vez só =======================

install.packages("pacman")

library(pacman)

p_load(tidyverse, janitor, haven, forcats, 
       formattable,
               knitr,stringr, hrbrthemes, 
               rgdal, mapproj)

install.packages("installr")

library(installr)

updateR()

## Incluir %in% no atalho ====================================

install.packages("devtools")

library(devtools)

install_github("rstudio/addinexamples", 
               type = "source")

# Ir até a aba "Addins" > "Browse Addins".


## 2) Incluir c("", "", "") =====================================

devtools::install_github("hrbrmstr/hrbraddins")

tidyverse, 

c("tidyverse", "janitor")
# Ir até a aba "Addins" > "Browse Addins".


## Dplyr 0.7 (dentro do Tidyverse) ===============================

library(dplyr)

update.packages()

my_var <- quo(homeworld)


## Mutações dos verbos tradicionais: "at", "if"

## Em vez disso...

starwars %>% 
  summarise(Media = mean(height, na.rm = TRUE))

starwars %>% 
  summarise(Media = mean(mass, na.rm = TRUE))


## Fazer isso...

starwars %>%
  summarise_at(vars(height, mass), mean,
               na.rm = TRUE)


## Outro exemplo: 

starwars %>% 
  select(mass, height) %>% 
  summary(.)


# Pra que serve essa função abaixo?

range01 <- function(x){
  (x-min(x, na.rm = T))/(max(x, na.rm = T)-min(x,na.rm = T))
  }


## Em vez disso...

starwars %>% 
  mutate(mass = range01(mass))

starwars %>% 
  mutate(height = range01(height))


## Isso...

starwars %>% 
  mutate_at(vars(mass, height), range01) %>% 
  select(mass, height) %>% 
  summary(.)


## Selecionar com "if"

glimpse(starwars)

starwars %>% 
  select_if(is.character)


starwars %>% 
  select_if(is.double)


## Graficar apertando botões =====================================

install.packages("ggedit")

library(ggedit)
library(tidyverse)

p <- ggplot(mtcars, aes(x = hp, y = wt)) + 
  geom_point() + 
  geom_smooth()

p2 <- ggedit(p)


## Gráficos interativos ===========================================

install.packages("plotly")

library(plotly)
library(gapminder)
library(tidyverse)

# Filtrar Brasil e Cuba, plotar as duas linhas, mudar cores para
# verde e grená, fundo para branco, escala centralizada e tornar
# a visualização interativa.


gapminder <- data.frame(gapminder)


##================================
##          MAPAS 
##================================

options(scipen = 999) # PRA QUE SERVE?
options(digits = 2) # PRA QUE SERVE?

rm(list = ls())

library(tidyverse) # PRA QUE SERVE?
library(janitor) # PRA QUE SERVE?
library(haven) # PRA QUE SERVE?
library(stringr) # PRA QUE SERVE?
library(hrbrthemes) # PRA QUE SERVE?
library(rgdal) # Pacote para ler shape dos gráficos
library(mapproj) # Pacote para ler shape dos gráficos


## Antes de fazer os mapas, é preciso baixar os dados
## com os contornos do Brasil no IBGE. Anexei estados
## e municípios no meu git.

mapa_mun_geral <- read_csv("mapa_mun_geral.csv")

mapa_mun_geral %>% 
  ggplot(aes(longmun, latmun, group = group, fill = idhm_2010)) + 
  geom_polygon() 


# Inverter escala contínua

mapa_mun_geral %>% 
  ggplot(aes(longmun, latmun, group = group, fill = idhm_2010)) + 
  geom_polygon() +   
  scale_fill_distiller(direction = 1)


# Mapa com variável categórica

mapa_mun_geral %>% 
  mutate(idhm_cat = as.factor(idhm_cat)) %>%
  ggplot(aes(longmun, latmun, group = group, fill = idhm_cat)) + geom_polygon()


# Cola para melhorar mapa 

g1 <- mapa_mun_geral %>% 
  mutate(idhm_cat = as.factor(idhm_cat)) %>%
  ggplot() + geom_polygon(aes(longmun, latmun, group = group, fill = idhm_cat),
                          color = NA, size = 0.25) + coord_map() +
  scale_fill_manual(name = "", 
                    labels = c("0,000-0,499", "0,500-0,599", "0,600-0,699", 
                               "0,700-0,799", "0,800-1"),
                    values = c("#d7191c", "#fdae61", "#ffffbf",
                               "#abdda4", "#2b83ba")) + 
  theme_void() 




# colocar linhas dos estados no mapa final de idhm 
g1 + geom_path(data = mapa_est_geral, aes(longest, latest, group=group), 
                     color = "black", size = 0.1) + 
  labs(title = "IDHM (2010)")


## E se eu quiser cortar só o RJ?

# https://ww2.ibge.gov.br/home/geociencias/areaterritorial/principal.shtm

mapa_mun_geral %>% 
  mutate(rio_mapa = str_sub(codigo_ibg, start = 1, end = 2)) %>% 
  filter(rio_mapa == "33") %>% 
  mutate(idhm_cat = as.factor(idhm_cat)) %>%
  ggplot(aes(longmun, latmun, group = group, fill = idhm_cat)) + geom_polygon(color = NA, size = 0.25)

  
  
### EXTRA, EXTRA!!!!

# Exemplo 1)

# http://sharpsightlabs.com/blog/map-european-cities-large-population/


# Exemplo 2)

# http://sharpsightlabs.com/blog/mapping-large-asian-cities-r/


## Exemplo 3)

# http://sharpsightlabs.com/blog/mapping-france-night/


## Exemplo 4)

# http://sharpsightlabs.com/blog/map-talent-competitiveness/


## Exemplo 5)

# http://sharpsightlabs.com/blog/human-capital-map/


## Exemplo 6)

# https://www.kaggle.com/ctlente/3d-interactive-globe-tutorial


## Exemplo 7)
# http://ggobi.github.io/ggally/#example_us_airports


## Exemplo 8)
# https://www.r-bloggers.com/when-are-citi-bikes-faster-than-taxis-in-new-york-city/


## Exemplo 9)
# https://www.r-bloggers.com/mapping-paris-bikes-stands/


## Exercício do dia

# 1) Com a base "mapa_mun_geral.csv", categorizar o pib em 
# 4 percentis, mapear o Brasil primeiro e depois mapear os
# estados de MG e PA (segundo classificação do IBGE). Mapas
# não devem ter fundo e apresentar uma combinação de cores
# que não seja cafona.










