##========================================
##         Aula 4 - Gráficos 
##========================================

##=============================
##  Gráficos comuns
## - Gráfico de linhas
## - Gráfico de barras
## - Scatterplot
## - Boxplot
## - Histogramas
## - Gráficos de pirulito
##=============================

# options(digits = 2)
options(scipen = 999) # remover notação científica
rm(list = ls()) # remover o que tem na memória


## abrir pacotes ========================================

install.packages("gapminder") # instalar antes

library(gapminder) # pacote com base para exemplos
library(tidyverse)
library(janitor) # usado para tabular (tabyl)

# library(ggplot2) para gráficos 

##======================================================================
## Detalhe: 
## - Os gráficos no R são altamente customizáveis. Para ter uma 
## ideia mais clara das possibilidades de modificação, consultar
## o sítio: http://ggplot2.tidyverse.org/reference/. Outra maneira
## é dar uma olhada no livro sobre o ggplot2 escrito pelo Wickham, 
## apontado nas referências bibliográficas. Para os que preferem 
## referências em vídeos, as comunicações do Roger Peng 
## (https://www.youtube.com/watch?v=HeqHMM4ziXA) e do Data Science
## Dojo (https://www.youtube.com/watch?v=49fADBfcDD4) são bons guias. 
## Mas, claro, existe uma enormidade de vídeos sobre o ggplot2 no 
## youtube. Fica a gosto do freguês.
##=======================================================================


## base para exemplos ==================================

gapminder <- data.frame(gapminder)


## nomes das variáveis da base "gapminder" =============

names(gapminder)


## sumarizar as variáveis da base "gapminder" ==========

gapminder %>% 
  summary() 

##=====================================================
##   Como faço para saber a classe das variáveis? 
##=====================================================

glimpse(gapminder)

##===========================================================
##        Histograma de expectativa de vida 
##===========================================================

# Vamos começar com os gráficos. 

## Os histogramas são formas de visualização apropriadas
## às variáveis contínuas (ex: idade, altura, salário, etc).
## Usamos histogramas quando queremos saber a distribuição  
## dessas variáveis.


##===========================================================
## Dica: 
## - Por padrão, o Rstudio abre os gráficos dentro da aba  
## "plot. Se quiserem ver a figura em uma aba separada, usem
## os comandos "windows()" (para usuários de windows) ou
## "quartz()" (para usuários de mac).
##===========================================================

windows() # abrir dispositivo de gráfico no windows
quartz() # abrir dispositivo de gráfico no mac

# comando para fazer histograma 

gapminder %>% 
  ggplot(aes(lifeExp)) + geom_histogram() 

##======================================================
## Detalhe: 
## - Único dos gráficos que só tem uma variável 
## dentro do "ggplot(aes())". Lê-se: a partir da base 
## "gapminder", quero fazer um histograma da variável
## expectativa de vida ("lifeExp"). O "pipe" ( %>% )
## serve para fazer esse link entre a base (gapminder) e
## a função (ggplot + geom_histogram). Normalmente, os 
## gráficos seguem o padrão "ggplot(aes(x, y)) + 
## geom_alguma coisa".
##=======================================================


##=====================================================
##   Scatterplot - correlação gdpPercap e lifeExp
##=====================================================

##=====================================================
## Detalhe:
## - Os scatterplots são utilizados quando queremos 
## ver a relação entre duas variáveis contínuas. No 
## caso abaixo, veremos se o PIB per capita (gdpPercap)
## tem impacto na expectativa de vida (lifeExp).
## geom_point = comando usado para criar scatterplots.
##=====================================================

gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

##======================================================
## Detalhe: agora tivemos 2 variáveis dentro do comando 
## "ggplot(aes())". Lembrando que o X é sempre o eixo
## horizontal e o Y é o eixo vertical do gráfico. 
##=====================================================



##=====================================================
##   Boxplot - diferença Brasil x Canada
##=====================================================

# Usamos Boxplots para avaliar relações entre variáveis
# contínuas e categóricas, atentando para a distribuição
# dos valores. A linha do meio da caixa indica a mediana; 
# a linha de baixo, o 1o quartil; a linha de cima, o
# 3o quartil; o pauzinho de baixo, fora da caixa, o 
# limite inferior; o pauzinho de cima, fora da caixa,
# o limite superior.

##======================================================
## Detalhe: 
## - No comando abaixo, filtramos as categorias "Brazil"
## e Canada dentro da variável "country". Depois, pedimos
## para o R criar um boxplot das variáveis "country"
## e "lifeExp". geom_boxplot = comando utilizado para
## criar boxplots.
##=====================================================

gapminder %>%  
  filter(country %in% c("Brazil", "Cuba")) %>% 
  ggplot(aes(x = country, y = lifeExp)) + geom_boxplot()



##=====================================================
## Comparar expectativa Brasil x Argentina, em 2007, 
## e fazer gráfico de barras.
##=====================================================

# Os gráficos de barra também servem para que a gente
# avalie a relação entre uma variável categórica (country)
# e outra contínua (lifeExp).

##===============================================================
## Detalhe:
## - No comando abaixo, filtramos duas coisa diferentes:
## os países "Brazil" e "Argentina", dentro da variável 
## "country" e (&) o ano de 2007, dentro da variável
## "year", antes de rodar o comando do gráfico. Tudo, claro, 
## interligado pelo "pipe" ( %>% ). 
## O comando dos gráficos de barra têm uma particularidade:
## temos que dizer qual tipo de barra queremos, já que 
## existe mais de um tipo. No caso, pedi um gráfico simples,
## por isso a extensão "geom_bar(stat = "identity")". 
## Para saber mais sobre gráficos de barra, ver:
## https://www.google.com.br/search?dcr=0&source=hp&q=geom_bar+ggplot2&oq=geom_bar+ggplot&gs_l=psy-ab.3.0.0l2j0i22i30k1l2.383.3024.0.3819.16.15.0.0.0.0.200.1713.7j7j1.15.0....0...1.1.64.psy-ab..1.15.1712.0..0i131k1.0.DJV-a9RWulg
## Atentem que no comando abaixo detalhe melhor a forma
## como quero o gráfico. Antes, tinha parado no geom_alguma coisa.
## Agora estendi o comando dizendo algo sobre o fundo (branco),
## o escala do eixo y e os títulos do eixo x, do eixo y e do 
## gráfico. 
##================================================================

gapminder %>% 
  filter(country %in% c("Brazil", "Argentina") & 
           year == 2007) %>% 
  ggplot(aes(x = country, y = lifeExp)) + 
  geom_bar(stat = "identity", fill = "red") + 
  theme_bw() + scale_y_continuous(limits = c(0, 90)) +
  labs(x = "País", y = "Expectativa",
       title = "Vida")



##=====================================================
## Expectativa de vida no Brasil (longitudinal) 
##=====================================================

# Os gráficos de linha são apropriados quando o pesquisador
# quer ver a evolução de uma variável contínua ao longo do
# tempo. 

##==========================================================
## Detalhe:
## - No comando abaixo, filtrei só o "Brazil", e usei linhas 
## e pontos para melhor graficar a curva de expectativa de vida. 
## Dentro do "ggplot(aes(x, y))" temos o ano (year) como eixo
## x. Pois bem, a configuração dos gráficos de linha sempre 
## terá os anos no eixo x. No final, acertei a escala do 
## eixo y para que a curva ficasse mais centralizada
## no gráfico. 
##===========================================================

gapminder %>% 
  filter(country == "Brazil") %>% 
  ggplot(aes(x = year, y = lifeExp)) + geom_line() +
  geom_point() + scale_y_continuous(limits = c(30,90))



##=========================================================
## Selecionar Brasil, Argentina, Albania, Australia, 
## Canada, Chile, China, Cuba, Dinamarca, ver 
## expectativa de vida em 2007 e fazer gráfico 
## de pirulito.
##==========================================================

# Os gráficos de pirulito são outra maneira de ver 
# interações entre variáveis contínuas (life Exp)
# e categóricas (country). 


##===========================================================
## Detalhe:
## - O "ggalt" é uma extensão do pacote "ggplot2" com 
## uma função apropriada para os gráficos de pirulito. Se
## quiserem saber sobre outras extensões, ver
## http://www.ggplot2-exts.org/.
## No comando abaixo, mais uma novidade: a reordenação dos 
## variável "country" de acordo com os valores de lifeExp.
## geom_lollipop = para fazer gráficos de pirulito. 
##============================================================

install.packages("ggalt", dependencies = T)

library(ggalt) # extensao do ggplot

gapminder %>% 
  filter(country %in% c("Brazil", "Argentina",
                        "Albania", "Australia",
                        "Canada", "Chile", "China",
                        "Cuba", "Denmark") & 
           year == 2007) %>% 
  ggplot(aes(x = reorder(country, lifeExp), y = lifeExp)) + 
  geom_lollipop() + coord_flip()


## Gente, é isso. Qualquer dúvida, mandem emails. Abs.   
  









