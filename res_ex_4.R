##==========================================
##        Exercícios Aula 4
##==========================================

rm(list = ls()) # comando para limpar memória

install.packages("gapminder") # se ainda não tiver instalado o pacote

library(gapminder) # pacote com os dados do exercício
library(tidyverse) # pacote para mexer nos dados
library(janitor) # pacote para tabular os dados
library(haven) # pacote para abrir bases de outros softwares


##============================================
##     1) Abrir base do "gapminder" 
##============================================

gapminder <- data.frame(gapminder)


##============================================
##     2) Selecionar o Afeganistão
##============================================

base_afeganistao <- gapminder %>% 
  filter(country == "Afghanistan")


##============================================
## 3) Graficar a expectativa de vida do país 
## ao longo dos anos, com uma curva vermelha. 
##============================================

base_afeganistao %>% 
  ggplot(aes(year, lifeExp)) + geom_line(color = "red") + 
  theme_light()


##=============================================
## Extra: 
## - melhorar gráfico centralizando a curva, 
## colocando pontos nas intercessões, ajeitando
## os eixos e colocando o fundo branco
##==============================================

base_afeganistao %>% 
  ggplot(aes(year, lifeExp)) + geom_line(color = "red", size = 1) + 
  geom_point(size = 1.5) + scale_y_continuous(limits = c(20, 55)) + 
  theme_light() + labs(x = "", y = "Expectativa de Vida (em anos)")


##========================================================
## Detalhe: 
## - além do comando anterior, alterei a grossura
## da linha ao acrescentar o "size = 1" dentro do 
## comando "geom_line"; fiz a mesma coisa no 
## "geom_point"; mudei a escala com o "scale_y_continuous",
## acertando o limite com o "limits = c(20, 55)" - lembrando
## que o 20 é o valor mínimo e o 55 o máximo. Tirei o tema
## cinza do fundo com o "theme_light". Mudei as legendas
## do eixo x ao não colocar nada dentro das aspas de 
## "labs(x = "")" e coloquei "Expectativa de Vida (em anos)"
## no eixo y também por dentro do comando "labs". 
##========================================================


# Gente, isso tudo o que fiz dá para colocar num bloco só. 
# Roda do mesmo jeito. Exemplo abaixo:

gapminder %>% 
  filter(country == "Afghanistan") %>% 
  ggplot(aes(year, lifeExp)) + geom_line(color = "red", size = 1) + 
  geom_point(size = 1.5) + scale_y_continuous(limits = c(20, 55)) + 
  theme_light() + labs(x = "", y = "Expectativa de Vida (em anos)")


##===========================================================
## 4) Abrir base do WVS 2014, selecionar a variável "V144", 
## renomear para "Religião", 
## transformar os números "25" e "64" em "evangélicos" 
## e "católicos" (respectivamente) e o restante em "outros".
##===========================================================


## Acertar o diretório (pasta) em que está a base ==================

setwd("C:/Users/thiagomoreira/iCloudDrive")


## Abrir a base do WVS 2014 =========================================

wvs_2014 <- read_spss("wvs_2014.sav")


## Selecionar variável V144 =========================================

wvs_2014_cortado <- wvs_2014 %>% 
  select(V144)


## Renomear variável ================================================

wvs_2014_cortado <- wvs_2014_cortado %>% 
  rename(religiao = V144) # escrevam AS VARIÁVEIS sem sinais e maiúsculas 


## Mudar categorias e tabular =======================================

wvs_2014_cortado <- wvs_2014_cortado %>% 
  mutate(religiao = case_when(religiao == 25 ~ "Evangélicos", # aqui pode
                              religiao == 64 ~ "Católicos",
                              TRUE ~ "Outros")) %>% 
  tabyl(religiao)


## Fazer gráfico =====================================================

wvs_2014_cortado %>% 
  ggplot(aes(religiao, percent)) + 
  geom_bar(stat = "identity", fill = "blue") + 
  theme_light()

## O que dá no mesmo do que o comando unificado abaixo ==============

wvs_2014 %>% 
  select(V144) %>% 
  rename(religiao = V144) %>% # escrevam AS VARIÁVEIS sem sinais e maiúsculas 
  mutate(religiao = case_when(religiao == 25 ~ "Evangélicos", # aqui pode
                              religiao == 64 ~ "Católicos",
                              TRUE ~ "Outros")) %>% 
  tabyl(religiao) %>% 
  ggplot(aes(religiao, percent)) + 
  geom_bar(stat = "identity", fill = "blue") + 
  theme_light()


##=======================================================
## Extra:
## - A melhor forma de passar o eixo y para porcentagem
## é usando o comando "scale_y_percent", do pacote 
## "hrbrthemes". Exemplo abaixo:
##========================================================

install.packages("hrbrthemes")

library(hrbrthemes)

wvs_2014 %>% 
  select(V144) %>% 
  rename(religiao = V144) %>% # escrevam AS VARIÁVEIS sem sinais e maiúsculas 
  mutate(religiao = case_when(religiao == 25 ~ "Evangélicos", # aqui pode
                              religiao == 64 ~ "Católicos",
                              TRUE ~ "Outros")) %>% 
  tabyl(religiao) %>% 
  ggplot(aes(religiao, percent)) + 
  geom_bar(stat = "identity", fill = "blue") + 
  theme_light() + scale_y_percent(limits = c(0,0.6))


## É isso, abs. Qq dúvida, email. 









