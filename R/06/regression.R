# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")

library(MASS)
library(tidyverse)
library(caret)

# データ読み込み
data(Boston)
Boston %>% summary()
Boston %>% head()

# 予測
train_size = 0.7
train_index <- sample(Boston %>% nrow(), Boston %>% nrow() * train_size)
train_data <- Boston[train_index,] # 訓練データ
test_data <- Boston[-train_index,] # テストデータ

lm_multi_model <- train(data=train_data, medv ~ ., method="lm")
y_pred <- predict(lm_multi_model, test_data)

# MAE
MAE(y_pred, test_data$medv)

# RMSE
RMSE(y_pred, test_data$medv)

# RMSLE
rmsle <- function(y_true, y_pred)
  sqrt(mean((log1p(y_true) - log1p(y_pred))^2))
rmsle(y_pred, test_data$medv)
