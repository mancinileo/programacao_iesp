##====================================
##  AULA 8 - Programação funcional
##====================================


## A programação funcional nos ajuda a ganhar tempo
## quando mexemos no R. Aqui, vou tratar de 2 tipos:
## as funções e os loops. Como disse em sala de aula, 
## com as funções indicamos várias tarefas para um
## mesmo objeto (variável, coluna, como preferirem) e
## com os loops a gente designa uma mesma tarefa para
## vários objetos. 

## limpar memória

rm(list = ls())


## tirar a notação científica

options(scipen = 999)


# abrir pacotes

# install.packages("pacman")

pacman::p_load(tidyverse, haven, janitor, readxl)

# library(tidyverse)
# library(haven)
# library(janitor)
# library(readxl)


## Abrir base =========================================================
## Notem que é uma base ".xlsx". O "sheet" é a designação para que
## possamos abrir somente a planilha 2 do documento (que é onde se 
## encontram os dados que nos interessam).

idhm_2010 <- read_excel("atlas2013_dadosbrutos_pt.xlsx", sheet = 2)


## Saber o nome das variáveis =========================================

names(idhm_2010)


## Saber os anos disponíveis =========================================

idhm_2010 %>% 
  tabyl(ANO)


## filtrar 2010 e selecionar apenas 6 variaveis ======================

idhm_menor <- idhm_2010 %>% 
  filter(ANO == 2010) %>% 
  select(ESPVIDA, MORT5, E_ANOSESTUDO, GINI, POP, IDHM)


## Tirar a média, desvio-padrão e mediana de todas as variáveis =======
## Aqui temos um bom exemplo de como a programação 
## funcional pode facilitar a nossa vida. Ao tirar 
## algumas estatísticas descritivas de todas as 
## variáveis, temos que copiar e colar uma série
## de comandos. Vejam abaixo:

## Saber as classes das variáveis. 

glimpse(idhm_menor)

## Do jeito tidyverse
 
idhm_menor %>% 
  summarise(media_vida = mean(ESPVIDA),
            sd = sd(ESPVIDA),
            mediana = median(ESPVIDA))

idhm_menor %>%
  summarise(media_vida = mean(MORT5),
            sd = sd(MORT5),
            mediana = median(MORT5))

idhm_menor %>%
  summarise(media_vida = mean(E_ANOSESTUDO),
            sd = sd(E_ANOSESTUDO),
            mediana = median(E_ANOSESTUDO))

idhm_menor %>%
  summarise(media_vida = mean(GINI),
            sd = sd(GINI),
            mediana = median(GINI))

idhm_menor %>%
  summarise(media_vida = mean(POP),
            sd = sd(POP),
            mediana = median(POP))

idhm_menor %>% 
  summarise(media_vida = mean(IDHM),
            sd = sd(IDHM),
            mediana = median(IDHM))


## Do jeito antigo

mean(idhm_2010$ESPVIDA)
sd(idhm_2010$ESPVIDA)
median(idhm_2010$ESPVIDA)

mean(idhm_2010$MORT5)
sd(idhm_2010$MORT5)
median(idhm_2010$MORT5)

mean(idhm_2010$E_ANOSESTUDO)
sd(idhm_2010$E_ANOSESTUDO)
median(idhm_2010$E_ANOSESTUDO)

mean(idhm_2010$GINI)
sd(idhm_2010$GINI)
median(idhm_2010$GINI)

mean(idhm_2010$POP)
sd(idhm_2010$POP)
median(idhm_2010$POP)

mean(idhm_2010$IDHM)
sd(idhm_2010$IDHM)
median(idhm_2010$IDHM)


## Agora com função =========================================
## Viram?! É infernal ficar copiando e modificando todos
## os comandos em sequência. Perdemos um tempo precioso 
## nas nossas vidas que não vai mais voltar. Puxado.
## Então vamos otimizar esse processo. O primeiro jeito
## para lidar com isso é com o uso de uma função específica, 
## criada para tirar a média, o desvio-padrão e a mediana
## ao mesmo tempo (a tal das múltiplas atividades), para um
## só objeto (variável, coluna, como preferirem).

## A sintaxe é fácil e tem que ter 1) um nome para a função
## (no caso, "media_dp_mediana"), o "function" com a
## especificação da variável que modificaremos e os comandos
## desejados para determinar alguma tarefa (aqui: média, sd e 
## mediana). Na última linha, temos o retorno que queremos, 
## uma combinação das 3 medidas. Tudo envolto por "{}". OK?

media_dp_mediana <- function(x){ 
  media <- mean(x)
  desvio_padrao <- sd(x) 
  mediana <- median(x) 
  c(media, desvio_padrao, mediana)
}

## Depois, podemos tirar as estatísticas economizando várias
## linhas. 

media_dp_mediana(idhm_2010$ESPVIDA)
media_dp_mediana(idhm_2010$MORT5)
media_dp_mediana(idhm_2010$E_ANOSESTUDO)
media_dp_mediana(idhm_2010$GINI)
media_dp_mediana(idhm_2010$POP)
media_dp_mediana(idhm_2010$IDHM)


## Ou assim, em lista. 

media_dp_mediana <- function(x){
  media <- mean(x)
  desvio_padrao <- sd(x) 
  mediana <- median(x) 
  c(list(media, desvio_padrao, mediana))
}

media_dp_mediana(idhm_2010$IDHM)

## Podemos alterar os numeros no enunciado

numero_maior <- function(x, Y = 1){
  x + Y
}

numero_maior(14)


## Funcao com ... 

pergunta_minha <- function(...){
  paste("Títulos do Botafogo?:", ...)
}

pergunta_minha("Nem 1!!!")


## Funcao com dplyr(tidyverse)

idhm_2010 %>% 
  mutate(IDHM = pergunta_minha(IDHM)) %>% 
  select(IDHM)


## Melhorou, mas ainda dá para ficar melhor...LOOP!!!

mean(idhm_2010$ESPVIDA)
mean(idhm_2010$MORT5)
mean(idhm_2010$E_ANOSESTUDO)
mean(idhm_2010$GINI)
mean(idhm_2010$POP)
mean(idhm_2010$IDHM)

## precisamos delimitar o resultado 

output <- vector("double", ncol(idhm_menor)) # 1. output

for(i in seq_along(idhm_menor)) { # 2. sequence
  output[[i]] <- mean(idhm_menor[[i]])# 3. body
}

output


## Exemplo bom de uso dos loops: downloads na internet. 
## Agradeço ao Saulo, por ter trazido essa questão. 

library(stringr)

##  Página onde se encontram os arquivos:
url <-  'http://brazil.crl.edu/bsd/bsd/u1331/'


## Download com loop
## Com o comando "sprintf" criamos uma sequência de 1 a 267
## e acrescentamos o sufixo ".tiff" (usado para coletar figuras)

tiff_saulo <- paste0(sprintf('%0.6d', 1:267), ".tiff")

## Fazer o loop

for (i in seq_along(tiff_saulo))
{
  download.file(url=paste0(url, tiff_saulo[i]), 
                destfile = paste("C:/Users/thiagomoreira/Downloads", 
                                 tiff_saulo[i]))
}  



## Para ficar tudo ainda melhor...PURRR !!!
## O Purrr é mais um pacote maravilhoso criado pelo
## Hadley Wickham, nosso mentor. O pacote automatiza
## os loops, fazendo que a gente prescinda do "for i in
## seq_along(blabla). Lembrando: Wickham > Foucault.

library(purrr)

## Função principal > "map"

## map(.x, .f)

map_dbl(idhm_menor, mean)
map_dbl(idhm_menor, sd)
map_dbl(idhm_menor, median)


## E como juntar a função que eu fiz e aplicá-la
## a todas as minhas variáveis??

idhm_2010 %>% 
  map_if(is.double, media_dp_mediana)


## Exercício para hoje:

## Criar uma função calculando a média (sem usar o comando "mean")
## e aplicar em todas as variáveis contínuas da base do idhm. 

## Resposta: 


media <- function(x){
  sum(x)/length(x)
}


output <- vector("double", ncol(idhm_menor))

for(i in seq_along(idhm_menor)) { 
  
  output[[i]] <- media(idhm_menor[[i]])
  
}

output

  
## Exercício: 

## 1) Peguem todos os dados de votação por município,
## de todas as eleições presidenciais. 

## 2) Acertem os nomes de todas as variáveis para minúscula, 
## tirem os espaços nos nomes das variáveis (se houver).

## 3) Criem uma variável com a votação final por estado. 

## 4) Juntem os resultados de votação por estado, em todos
## os anos considerados, numa mesma base. 

## 5) Colem essas informações na nossa base de mapas 
## estaduais (mapa_mun_est). 

## 6) Criem mapas de votação interativos em cada ano considerado
## para que possamos ver de perto o suposto realinhamento eleitoral
## a partir de 2006. 


## Lembrando, a Argelina e a Natalia Maciel vão eleger o vencedor
## do concurso de mapas. A(O) campeã(o), além de uma bebida que pisca, 
## vai ganhar também um outro brinde qualquer que ainda não sei qual. 
## Logo, façam um trabalho bem bonito e posem de rainhas do camarote. 

## É isso. QQ coisa, email. abs; 






