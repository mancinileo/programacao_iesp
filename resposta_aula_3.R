##====================================
##   Respostas exercício aula 3
##====================================

# instalar pacotes (para quem já instalou, não precisa mais) =====

install.packages("tidyverse", dependencies = T)
install.packages("stringr", dependencies = T)
install.packages("lubridate", dependencies = T)

## abrir pacotes ==================================================

library(tidyverse) # pacote com nossos verbos principais
library(stringr) # pacote para lidar com strings (palavras)
library(lubridate) # pacote para lidar com datas

## acertar o diretório antes ======================================

# ctrl(cmd para usuários de mac) + shift + H ou
# setwd("caminho para o arquivo")

# No meu caso, exemplo:
setwd("C:/Users/thiagomoreira/iCloudDrive")

# Para saber o que tem na pasta:
dir()


## abrir base ("base_filmes_iesp.csv", no meu github) ============

base_filmes_iesp <- read_csv("base_filmes_iesp.csv")

# base com 100 observações e 4 variáveis


## saber nome das variáveis =======================================

names(base_filmes_iesp)

## saber classe das variáveis =====================================

glimpse(base_filmes_iesp)

# posicao = integer, titulo = character, descricao = character, 
# Data_mudar = date. 


##=======================================================================
## Resposta 1: Mudar as datas e salvar na nossa convenção (01/01/2001)
##=======================================================================

# Fazer um teste antes para saber se os comandos estão certos.
# Detalhe: estou usando o "select" depois do último pipe (%>%)
# somente para visualizar se fiz a coisa correta

base_filmes_iesp %>% 
  mutate(Data_mudar = ymd(Data_mudar)) %>%  
  mutate(Data_mudar = format(Data_mudar, format = "%d/%m/%Y")) %>%
  select(Data_mudar)

##====================================================================
## Detalhadamente:
## - a primeira linha ("base_filmes_iesp") é o nome da base criada.
## - "mutate(Data_mudar = ymd(Data_mudar))" diz ao R que a configuração 
## está com year, month, day (Ano, mês e dia).
## - "mutate(Data_mudar = format(Data_mudar, format = "%d/%m/%Y"))" diz
## que para o R que a gente quer mudar a data para a nossa convenção
## - "select(Data_mudar)" seleciona somente a variável "Data_mudar" para
## que a gente veja se os comandos utilizados rodaram corretamente. 
## - Com os comandos utilizados, a gente NÃO está sobrescrevendo a base, 
## só conferindo se o script está correto. 
##=========================================================================

# Para mudar a base:

base_filmes_iesp <- base_filmes_iesp %>% 
  mutate(Data_mudar = ymd(Data_mudar)) %>%  
  mutate(Data_mudar = format(Data_mudar, format = "%d/%m/%Y"))

##======================================================================
## Detalhadamente:
## - Acrescentamos um "base_filmes_iesp" e um "tab" (<-) antes do 
## "base_filmes_iesp" para sobrescrever a base. Sempre que quisermos 
## modificar a base, temos que ter a primeira linha de comando assim:
## "nome_da_base <- nome_da_base %>%". Antes, no entanto, aconselho que
## confiram o comando para ver se está tudo correto. 
## - Tirei o "select(Data_mudar)" pois era o comando que servia ao nosso 
## "confere". Não precisamos mais dele, certo? Por isso, tirei.
##======================================================================


##============================================================================
## Resposta 2: Passar todos os títulos e todas as descrições para caixa baixa 
##============================================================================

# Aqui vocês já vão usar os comandos do pacote "stringr" como verbos 
# suplementares. Lembrando: os verbos principais são: "rename", "select", 
# "filter", "mutate", "group_by" e "arrange". Como exemplos de verbos 
# suplementares, temos: "case_when", "ifelse", "str_to_title", "ymd". 
# Lembrando que os verbos suplementares sempre aparecem depois dos verbos
# principais. Isso vai aparecer como exemplo aqui embaixo, quando a gente
# for modificar os títulos e fizer as demais operações. 

# Mesma coisa, vamos testar as alterações antes de sobrescrever a base. 
# Dica: os comandos do pacote "stringr" estão no sítio:
# http://stringr.tidyverse.org/

base_filmes_iesp %>% 
  mutate(titulo = str_to_lower(titulo)) %>% 
  select(titulo)

base_filmes_iesp %>% 
  mutate(descricao = str_to_lower(descricao)) %>% 
  select(descricao)

# Ok, comando funcionando corretamente. Vamos sobrescrever.

base_filmes_iesp <- base_filmes_iesp %>% 
  mutate(titulo = str_to_lower(titulo))

base_filmes_iesp <- base_filmes_iesp %>% 
  mutate(descricao = str_to_lower(descricao))

# Sendo repetitivo para fixar: acrescentei um "base_filmes_iesp <-"
# antes do "base_filmes_iesp" para sobrescrever e tirei o "select",
# já que não precisamos mais dele para testar se a coisa ficou ok. 

##=========================================================
## Resposta 3: tirar todos os acentos de todas as palavras
## no título e na descrição.
##=========================================================

# Ok, isso foi puxado, mas é importante pq com a repetição a gente 
# fixa melhor os conteúdos. Não vou fazer todas as alterações por 
# motivos de...preguiça. Mas os comandos seguem um parâmetro e é 
# só vcs aplicarem ad nauseam.

# Passo 1: testes dos comandos. 

base_filmes_iesp %>% 
  mutate(titulo = str_replace_all(titulo, "ó", "o")) %>% 
  select(titulo)

##================================================================
## Detalhadamente: 
## - o comando "str_replace_all", do pacote "stringr", serve
## para a gente modificar todos os parâmetros de uma mesma 
## variável - no caso, "titulo". Se o objetivo fosse modificar só
## um dos casos da variável, usaríamos o "str_replace".
## Na linha "mutate(titulo = str_replace_all(titulo, "ó", "o")) %>%"
## temos o verbo principal "mutate" para mudar a variável "titulo", 
## o "str_replace_all", que é o verbo suplementar. Portanto, no 
## suplemento "str_replace_all(titulo, "ó", "o"))" estamos dizendo ao R
## que a variável título tem um padrão "ó" (por óbvio, o "o" com acento) e
## que queremos tirar esse diabo desse acento, por isso o "ó, o". 
## - Assim, se quisermos modificar outras letras, basta a gente modificar 
## essa segunda linha. Exemplo abaixo:
##=======================================================================

base_filmes_iesp %>% 
  mutate(titulo = str_replace_all(titulo, "ó", "o")) %>% 
  mutate(titulo = str_replace_all(titulo, "ô", "o")) %>% 
  mutate(titulo = str_replace_all(titulo, "õ", "o")) %>% 
  mutate(titulo = str_replace_all(titulo, "ã", "a")) %>% 
  mutate(titulo = str_replace_all(titulo, "á", "a")) %>% 
  select(titulo)

# Tia velha da repetição: NÃO ESTAMOS SOBRESCREVENDO A BASE. NÃO ESTAMOS. 
# SÓ ESTAMOS TESTANDO SE O COMANDO DEU CERTO.

# Agora, sobrescrevendo:

base_filmes_iesp <- base_filmes_iesp %>% 
  mutate(titulo = str_replace_all(titulo, "ó", "o")) %>% 
  mutate(titulo = str_replace_all(titulo, "ô", "o")) %>% 
  mutate(titulo = str_replace_all(titulo, "õ", "o")) %>% 
  mutate(titulo = str_replace_all(titulo, "ã", "a")) %>% 
  mutate(titulo = str_replace_all(titulo, "á", "a")) 


##============================================================================
## Resposta 4: Ver quantos títulos têm nosso padrão acadêmico (com :).
##============================================================================

# Aqui, vamos ver quantos títulos têm nosso padrão metido a besta. 
# Para isso, vamos usar o comando "str_detect", também do pacote "stringr".
# O "str_detect" é um bom exemplo de verbo suplementar para o verbo principal
# "filter", do "tidyverse". Mas, claro, ele também pode ser usado com o 
# verbo principal "mutate", do "tidyverse". Aliás, um bom exercício 
# extra seria criar uma nova variável para identificar como "1" os 
# títulos com o padrão ":" e "0" para outros. Vou fazer abaixo. 

# primeiro a detecção do parâmetro ":"

base_filmes_iesp %>% 
  filter(str_detect(titulo, ":"))

# Temos 22 linhas com o esse nosso padrão acadêmico. Se a gente quiser
# que apareçam todos os filmes no console, usem o comando "print" depois
# da segunda linha. Exemplo:

base_filmes_iesp %>% 
  filter(str_detect(titulo, ":")) %>% 
  print(n = 22) # esse número 22 é só pq temos 22 casos

# E se a gente quiser criar uma nova base só com os 22 casos? Lembrem 
# da tia velha. Abaixo:  

base_nova <- base_filmes_iesp %>% 
  filter(str_detect(titulo, ":"))


##============================================================================
## Resposta 4: Ver quantos títulos terminam com a letra "a"
##============================================================================

# Mesma comando, a combinação de "filter" com "str_detect".

base_filmes_iesp %>% 
  filter(str_detect(titulo, "a"))

# Com o comando acima a gente seleciona todos os títulos com a letra "a". 
# Não é a resposta para a minha pergunta. Para filtrar somente os que 
# terminam com a letra "a", devemos acrescentar um "$" no final. 

base_filmes_iesp %>% 
  filter(str_detect(titulo, "a$"))

# Viram que mudou o número de casos?


##============================================================================
## Resposta 5: Mudar título do "La La Land" para qualquer título que quiserem
##============================================================================

# Como disse anteriormente, o "str_replace" serve para alterar
# somente um caso de uma determinada variável. Exemplo abaixo:

# comando usado para a gente listar o nome dos filmes no console. 
base_filmes_iesp %>% 
  select(titulo) %>% 
  print(n=100) # 100 pq temos 100 casos na base. 

# comando usado para testar (olha a tia velha!!!) e não para sobrescrever
# a base. Para os mortadelas:

base_filmes_iesp %>% 
  mutate(titulo = str_replace(titulo, "la la land: cantando estações",
                              "Fora Temer Golpista!")) %>% 
  select(titulo) %>% 
  print(n=100) # olhem para o titulo de número 23


base_filmes_iesp %>% 
  mutate(titulo = str_replace(titulo, "la la land: cantando estações",
                              "Bakunin da Massa: Como ser maior que Marx")) %>% 
  select(titulo) %>% 
  print(n=100) # olhem para o titulo de número 23


# Para os coxinhas. Dica: puxem o console mais para a esquerda. Lembrando 
# que as 4 janelas do R são reconfiguráveis.

# outro exemplo:
base_filmes_iesp %>% 
  mutate(titulo = str_replace(titulo, "la la land: cantando estações",
                              "MBL é amor: a luta por hegemonia num mundo dominado por esquerdistas")) %>% 
  select(titulo) %>% 
  print(n=100)


# outro exemplo:
base_filmes_iesp %>% 
  mutate(titulo = str_replace(titulo, "la la land: cantando estações",
                              "Menos Marx, mais Mises: como é sofrido ser um jovem liberal nas ciências sociais")) %>% 
  select(titulo) %>% 
  print(n=100)


# E para sobrescrever: NÃO DEIXE A TIA VELHA MORRER DENTRO DE VC!!

base_filmes_iesp <- base_filmes_iesp %>% 
  mutate(titulo = str_replace(titulo, "la la land: cantando estações",
                              "FLUMINENSE OLÊ, OLÊ, OLÊ")) 

# Gente, é isso. QQ dúvida, email. Abs.
























