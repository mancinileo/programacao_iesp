##==================================
##   Aula 2 - Ambiente Tidyverse
##==================================

# comando para limpar memória
rm(list = ls())

# instalar pacotes

# install.packages("tidyverse")
# install.packages("haven")


install.packages(c("tidyverse", "haven", "janitor",
                   "formattable"))


library(haven) # pacote para importar dados
library(tidyverse) # pacote para mexer nos dados
library(janitor) # pacote para sumarizar dados
library(formattable) # mudar valores para porcentagens


## Abrir base do World Values Survey (2014) ========================

# download em http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp,
# baixar o arquivo SPSS no final do site.

# saber qual é o diretório 

getwd()

# mudar diretório para achar base

setwd("C:/Users/thiagomoreira/Documents") # primeira forma

# ctrl(também no mac) + shift + H 

# dir() # saber como está o nome do arquivo no diretório
dir()

wvs_2014 <- read_spss("wvs2014.sav")

names(wvs_2014) # saber nomes das variáveis


## Analisar os dados =========================================

# processo de seleção das variáveis 

# Variáveis de interesse: V203 (homossexualidade), 
# V240 (sexo)
base_nova <- wvs_2014 %>%
  select(V203, V240)


# Mudar nome das variáveis
base_nova <- base_nova %>% 
  rename(homo = V203, 
         sexo = V240)


# Tabular homossexualidade
base_nova %>% 
  tabyl(homo)


# Organizar pelo maior número de casos
base_nova %>% 
  tabyl(homo) %>% 
  arrange(-n)
  

# Tirar médias e desvio-padrão 
base_nova %>% 
  summarise(media = mean(homo))

base_nova %>% 
  summarise(media = mean(homo, na.rm = TRUE))

base_nova %>% 
  summarise(desvio_padrao = sd(homo, na.rm = TRUE))


# Tabular quantidade de mulheres e homens
base_nova %>% 
  tabyl(sexo)

base_nova %>% 
  tabyl(sexo)*100 # qual o problema disso?


# Ver se existe diferença entre mulheres e homens
base_nova %>% 
  group_by(sexo) %>% 
  summarise(media = mean(homo, na.rm = T))


# Filtrar somente as mulheres
base_mulheres <- base_nova %>% 
  filter(sexo == 2) # ATENCAO AO IGUAL IGUAL


# Filtrar os missings (NA)
base_sem_missing <- base_nova %>% 
  filter(!is.na(homo))


# modificar variável homo 

base_sem_missing <- base_sem_missing %>% 
  mutate(homo = case_when(homo <= 4 ~ "direita", 
                          homo == 5 | homo == 6 ~ "centro",
                          homo >= 7 ~ "esquerda")) 

  
base_sem_missing %>% 
  tabyl(homo)
  

# base_nova %>% 
#   mutate(homo = case_when(homo %in% c(1,2,3,4) ~ "direita", 
#                           homo %in% c(5,6) ~ "centro",
#                           homo %in% c(7,8,9,10) ~ "esquerda")) %>% 
#   tabyl(homo)


# modificar variável sexo (binária)
# melhor como o comando "ifelse"
base_sem_missing <- base_sem_missing %>% 
  mutate(sexo = ifelse(sexo == 1, "homem", "mulher")) 

base_sem_missing %>% 
  tabyl(sexo)

# Melhor forma: usar o comando "percent" do pacote
# "formattable"

base_sem_missing %>% 
  tabyl(sexo) %>% 
  mutate(percent = percent(percent))


# e se eu quisesse renomear essas variaveis?

# comparar homens e mulheres em relacao homossexualidade
base_sem_missing %>% 
  crosstab(sexo, homo)


# melhor forma: 
base_sem_missing %>% 
  crosstab(sexo, homo) %>% 
  adorn_crosstab()

# salvar analise em csv
base_csv <- base_sem_missing %>% 
  crosstab(sexo, homo) %>% 
  adorn_crosstab()

write_csv(base_csv, "predilecoes_homossexualidade.csv")  




