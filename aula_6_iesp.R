##==============================
##    Aula 6 - Apresentações
##==============================

## O R serve de base para uma série de apresentações
## acadêmicas. Aqui, vou apresentar alguns formatos 
## possíveis -- do mais simples ao mais complexo. 


## R Markdown ======================================= 

install.packages("rmarkdown")
install.packages("knitr")

## - No ícone da folha, com um sinal de "+" 
## justaposto, clicar em "Rmarkdown...". 
## Particularidade do Rmarkdown: comandos funcionam
## por "chunks". Onde aprender mais sobre o 
## funcionamento do Rmarkdown e das "chunks"? 
## Aqui: http://rmarkdown.rstudio.com/
## e aqui: http://rmarkdown.rstudio.com/authoring_rcodechunks.html

## Para salvar o documento do Rmarkdown em arquivo do Word 
## (.doc;.docx) basta ir na aba "Documents" e depois selecionar
## em "Default Output Option" a opção "Word". Quando acabarem
## de mexer no arquivo, usem o botão "knit", com um símbolo
## de novelo de lã (lado direito da lupa).

##=======================================================
## Dica: 
## - Esse sistema é muito bom para escrever artigos 
## acadêmicos, mas, na hora de redigir o trabalho, 
## use como base o Word, já que lá tem o corretor
## automático -- algo que falta ao Rmardown. Assim,
## a gente evita os chamados "typos". Texto finalizado
## no Word, passem para cá o conteúdo e comecem a 
## aplicar os comandos que quiserem dentro das "chunks".
##========================================================


## R Notebook ======================================= 

## - Funcionamento similar ao Rmarkdown, mas
## resultados saem em tempo real, embaixo da  
## "chunk". Para criar um documento no Rnotebook, 
## entre no ícone da folha e clique em Rnotebook. 
## Para abrir depois um arquivo em HTML, Word ou
## PDF, apertem o "Preview" (ao lado da lupa). 
## Onde aprender mais?
## Aqui: http://rmarkdown.rstudio.com/r_notebooks.html



## Sweave ===========================================

## - Melhor forma de escrever sua tese usando o Latex 
## (principalmente para os alunos do IESP). Isso porque
## algum aluno brilhante criou toda a configuração 
## necessária para que salvem a tese nos padrões ABNT2. 
## O site do rapaz (Luís Fernando de Oliveira) é esse aqui:
## https://sites.google.com/site/deoliveiralf/latex-uerj.
## Passo a passo?

## 1) Para ter sua tese usando o sistema Latex, precisamos
## baixar alguns arquivos de antemão. Primeiro, o miktex
## para Windows (https://miktex.org/) ou o mactex para
## Mac (http://www.tug.org/mactex/). Caso contrário, 
## não conseguirão abrir o um arquivo PDF-Latex.
## Depois, baixem TODOS os arquivos disponibilizados no site
## do tal Luís Fernando de Oliveira, no final da página. 
## Baixados os arquivos, salve-os todos numa mesma pasta
## em algum diretório do seu computador.
## Baixe também um editor de Latex. Eu prefiro o 
## "TexStudio" (https://www.texstudio.org/).

## 2) Agora abram um arquivo Sweave no próprio R:
## ícone da folha > "R Sweave". Detalhe: o Sweave tem um 
## funcionamento mais ou menos parecido com o 
## Rmarkdown e o Rnotebook. O que muda mais são os
## comandos utilizados nas "chunks". Onde aprender 
## sobre as especificidades das "chunks" do Sweave?
## Aqui: https://yihui.name/knitr/options/.
## Salve este arquivo dentro da tal pasta que criaram
## com os conteudos do Luís Fernando de Oliveira.

## NÃO DEIXEM DE SALVAR O DOCUMENTO DO SWEAVE DENTRO
## DESSA PASTA. CASO CONTRÁRIO, NÃO VAI FUNCIONAR!!!!
## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## 3) Copiem TODO o conteúdo dentro do arquivo "modelo". 
## Como? Abram o arquivo com o editor de Latex (no caso, 
## o TexStudio), selecionem tudo e... ctrl(cmd) + C.

## 4) Abram o arquivo Sweave dentro da pasta com os 
## conteúdos do Luís Fernando (sendo bastante repetitivo
## para que não esqueçam). Apaguem TUDO dentro do script do
## Sweave e colem os comandos copiados do arquivo "modelo". 

## 5) Vejam se deu tudo certo: dentro do arquivo do Sweave, 
## editado com os comandos copiados do arquivo "modelo", 
## apertem o botão "Compile PDF" (segundo botão no lado 
## direito da lupa). 

## 6) Aquilo que viram é um arquivo "cru". Agora basta
## que vcs coloquem o texto que quiserem e terão uma tese 
## no formato Latex.

## Onde aprender mais sobre o Latex?
## https://www.sharelatex.com/learn/
## https://www.youtube.com/watch?v=SaVO8rrttDY&list=PLJH9xsc0pltklnechNXNZ9EPFRb7IKG2G


## Ioslides (Slidy) =================================

## - O R também dá suporte às apresentações em 
## HTML, mais adequadas a dados interativos. 
## Dentro da pasta do Rmarkdown, escolha 
## "presentations > ioslides". 

## (Vou colocar um exemplo no Git. Basta "knitar" 
## e terão uma apresentação em HTML). 

## Onde aprender mais? 
## http://rmarkdown.rstudio.com/ioslides_presentation_format.html


## Dashboards =======================================

## FlexDashboards e Shiny. 

## https://jjallaire.shinyapps.io/shiny-biclust/

## https://www.showmeshiny.com/wp-content/uploads/2017/01/CED-Catalunya.png

##  https://jiashenliu.shinyapps.io/PokemonGo/

## Onde aprender mais ? 

## http://rmarkdown.rstudio.com/flexdashboard/
## https://shiny.rstudio.com/


## Passos para que pensem na apresentação 
## dos trabalhos finais: 

##==================================
##  Regras: 
##  1) Objetivos;
##  2) Dados;
##  3) Período;
##  4) Hipóteses. 
##==================================

## É isso, abs. 















