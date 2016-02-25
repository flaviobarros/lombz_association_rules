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
itemFrequencyPlot(groceries, topN=10)

## Encontrando as regras de associação com o algoritmo Apriori
regras <- apriori(groceries, parameter = list(support=0.001, confidence=0.5, minlen = 2))

## Inspecionando as regras
summary(regras)

## Vendo as regras
inspect(regras[1:3])
inspect(regras)
inspect(sort(regras, by = 'confidence'))

## Visualizando as regras como um grafo
plot(regras, method = 'scatterplot', interactive=TRUE, shading=NA)
plot(regras, method = 'two-key plot', interactive=TRUE, shading=NA)

## Fazendo o gráfico do lift pelo suporte
plot(regras, measure=c("support", "lift"), shading="confidence")

## Obtendo um conjunto menor de regras
subregras <- regras[quality(regras)$confidence > 0.8]

## Fazendo os gráficos de matrizes
plot(subregras, method = 'matrix', interactive=TRUE, shading=NA)
plot(regras, method = 'matrix3D', interactive=TRUE, shading=NA)

## Agora mundando a ordem
plot(subregras, method="matrix", measure="lift", control=list(reorder=TRUE), interactive = T)

## Plotando as regras agrupadas
plot(regras, method="grouped", control = list(k=50), cex = 0.8)

## Plotando regras como grafos
subregras2 <- head(sort(regras, by="lift"), 10)
plot(subregras2, method="graph", control=list(type="itemsets"))
