# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')

library(MASS)
library(tidyverse)
# library(caret)

data_iris <- iris %>% select(Sepal.Width, Petal.Width) %>% scale()
k_means <- kmeans(data_iris, 2)
k_means %>% summary()
k_means$cluster

data_kmeans <- cbind(data_iris, k_means$cluster) %>% as.data.frame()

g <- ggplot(data_kmeans, aes(x=Sepal.Width, y=Petal.Width))
g <- g + geom_point(aes(colour=V3), size=1, alpha=0.5)
g