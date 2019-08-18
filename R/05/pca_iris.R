# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')

library(MASS)
library(tidyverse)
# library(caret)

pcr_model <- prcomp(iris %>% select(-Species), scale=T)
pcr_model %>% summary()

# plot(pcr_model$x[, 1], pcr_model$x[, 2])
data_pca <- cbind(pcr_model$x, iris$Species) %>% as.data.frame()

g <- ggplot(data_pca, aes(x=PC1, y=PC2))
g <- g + geom_point(aes(colour=V5), size=1, alpha=0.5)
#描画
g