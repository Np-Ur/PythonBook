# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')

library(MASS)
library(tidyverse)
library(caret)

data_iris <- iris %>% 
  filter(Species != "virginica") %>% select(-Species) %>% 
  mutate(Species = as.matrix(iris$Species[1:100]))
# ロジスティック回帰
## 単回帰
logit_model <- train(Species ~ Sepal.Length, data=data_iris, method="glm", family=binomial())
logit_model %>% summary()

## 重回帰
logit_multi_model <- train(Species ~ ., data=data_iris, method="glm", family=binomial())
logit_multi_model %>% summary()

# 予測
train_size = 0.7
train_index <- sample(data_iris %>% nrow(), data_iris %>% nrow() * train_size)
train_data <- data_iris[train_index,] # 訓練データ
test_data <- data_iris[-train_index,] # テストデータ


## 単回帰
logit_single_model <- train(Species ~ Sepal.Length, data=train_data, method="glm", family=binomial())
y_pred <- predict(logit_single_model, test_data)
confusionMatrix(data = y_pred, test_data$Species %>% as.factor())


## 重回帰
logit_multi_model2 <- train(Species ~ ., data=train_data, method="glm", family=binomial())
y_pred <- predict(logit_multi_model2, test_data)
confusionMatrix(data = y_pred, test_data$Species %>% as.factor())

