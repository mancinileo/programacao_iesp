##=============================================
##      Resposta exercicio 2
##=============================================

# comando para limpar a memória
rm(list = ls())

# instalar pacotes, caso não tenham feito
install.packages(c("tidyverse", "haven", "janitor",
                   "formatabble"))

# abrir pacotes
library(tidyverse)
library(haven)
library(janitor)
library(formattable)

# comando para ajustar o diretório
# setwd(caminho_no_computador) ou ctrl + shift + H
setwd("~/Dropbox/Banco de dados/WVS/WVS 2014")

# comando para abrir a base
wvs_2014 <- read_spss("wvs2014.sav")

# selecionar variáveis V144 e V100
resposta_exercicio <- wvs_2014 %>% 
  select(V144, V100)

# renomear variáveis 
resposta_exercicio <- resposta_exercicio %>% 
  rename(religiao = V144, 
         meritocracia = V100)

# filtrar valores 25 e 64 da religiao
resposta_exercicio <- resposta_exercicio %>% 
  filter(religiao %in% c(25, 64))

# mesma coisa que o comando abaixo:
# resposta_exercicio <- resposta_exercicio %>% 
#   filter(religiao == 25 | religiao == 64)

# transformar 25 e 64 em 'evangelicos' e 'catolicos', 
# respectivamente (também pode ser usado o "case_when")
resposta_exercicio <- resposta_exercicio %>% 
  mutate(religiao = ifelse(religiao == 25, "evangelicos", 
                           "catolicos")) 

# tricotomizar a variável meritocracia
resposta_exercicio <- resposta_exercicio %>% 
  mutate(meritocracia = case_when(meritocracia <= 4 ~ "favor", 
                                  meritocracia %in% c(5,6) ~ "meio",
                                  meritocracia >= 7 ~ "contra")) 

# cruzar as variáveis
resposta_exercicio %>% 
  crosstab(religiao, meritocracia) %>% 
  adorn_crosstab()

  

