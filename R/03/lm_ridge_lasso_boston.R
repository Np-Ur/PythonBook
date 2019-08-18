# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")

library(MASS)
library(tidyverse)
library(GGally)
library(caret)

# データ読み込み
data(Boston)
Boston %>% summary()
Boston %>% head()

# 可視化
Boston %>% ggpairs()
Boston %>% select(1, 2) %>% ggpairs()

# L1正則化なし
train_size = 0.7
train_index <- sample(Boston %>% nrow(), Boston %>% nrow() * train_size)
train_data <- Boston[train_index,] # 訓練データ
test_data <- Boston[-train_index,] # テストデータ

lm_multi_model <- train(data=train_data, medv ~ ., method="lm")
y_pred <- predict(lm_multi_model, test_data)
MAE(y_pred, test_data$medv)

# Lasso回帰
lasso <- train(data=train_data, medv ~ ., method="glmnet", tuneGrid = expand.grid(alpha = 1, lambda = 1))
y_pred <- predict(lasso, test_data)
MAE(y_pred, test_data$medv)


# Ridge回帰
ridge <- train(data=train_data, medv ~ ., method="glmnet", tuneGrid = expand.grid(alpha = 0, lambda = 1))
y_pred <- predict(ridge, test_data)
MAE(y_pred, test_data$medv)

