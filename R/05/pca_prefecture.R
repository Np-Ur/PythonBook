# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')

library(MASS)
library(tidyverse)
# library(caret)

data_prefecture <- read_csv("src/05/data_prefecture_category.csv")
data_prefecture %>% summary()

pcr_model <- prcomp(data_prefecture %>% select(-都道府県), scale=T)
pcr_model %>% summary()

# plot(pcr_model$x[, 1], pcr_model$x[, 2])

# plot(x, y)
pt <- identify(pcr_model$x[, 1], pcr_model$x[, 2])

