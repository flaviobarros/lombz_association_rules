## Carregando os pacotes necessários
library(arules)
library(arulesViz)

## Carregando o conjunto de dados
data("Groceries")

## Inspecionando
groceries <- read.transactions(file = 'groceries.txt', sep = ',', rm.duplicates = T)

## Sumário
summary(groceries)

## Observando algumas transações
inspect(groceries[1:4]) ## linhas da matrix são cestas de compras

## Colunas da matrix são items
itemFrequency(groceries[,1:10]) ## vendo os números
itemFrequencyPlot(groceries[,1:10]) ## gráfico de barras

## É possível colocar no gráfico somente itens com um certo suporte
itemFrequencyPlot(groceries, support = 0.1)

## É possível fazer seus próprios gráficos
itens <- itemFrequency(groceries)
itens <- itens[order(itens, decreasing = T)]
dotchart(itens)

## O mesmo gráfico com menos itens
dotchart(itens[1:10], cex = 0.8)
