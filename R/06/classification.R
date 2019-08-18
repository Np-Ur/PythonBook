# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages("pROC")

library(MASS)
library(tidyverse)
library(caret)
library(pROC)

data_iris <- iris %>% 
  filter(Species != "virginica") %>% select(-Species) %>% 
  mutate(Species = as.matrix(iris$Species[1:100]))

# 予測
train_size = 0.7
train_index <- sample(data_iris %>% nrow(), data_iris %>% nrow() * train_size)
train_data <- data_iris[train_index,] # 訓練データ
test_data <- data_iris[-train_index,] # テストデータ

## 重回帰
logit_multi_model <- train(Species ~ Sepal.Length, data=train_data, method="glm", family=binomial())
y_pred <- predict(logit_multi_model, test_data)
confusionMatrix(data = y_pred, test_data$Species %>% as.factor())

roc(test_data$Species %>% as.factor() %>% as.numeric(), y_pred %>% as.numeric(), plot = TRUE)

