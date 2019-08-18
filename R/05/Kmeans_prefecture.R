# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')

library(MASS)
library(tidyverse)
# library(caret)

data_prefecture <- read_csv("src/05/data_prefecture_category.csv")
data_prefecture %>% summary()

data_prefecture_scaled <- data_prefecture %>% select(-都道府県) %>% scale()
k_means <- kmeans(data_prefecture_scaled, 4)
k_means %>% summary()
k_means$cluster

data_prefecture_kmeans <- data_prefecture %>% mutate("label" = k_means$cluster)

data_prefecture_kmeans %>% filter(label==1)
data_prefecture_kmeans %>% filter(label==2)
data_prefecture_kmeans %>% filter(label==3)
data_prefecture_kmeans %>% filter(label==4)

data_prefecture_kmeans %>% filter(label==1) %>% summary()
data_prefecture_kmeans %>% filter(label==2) %>% summary()
data_prefecture_kmeans %>% filter(label==3) %>% summary()
data_prefecture_kmeans %>% filter(label==4) %>% summary()
