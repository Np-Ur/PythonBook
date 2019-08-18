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

# 線形回帰
# 単回帰
lm_model <- train(data=Boston, medv ~ rm, method="lm")
lm_model %>% summary()

# 重回帰
lm_multi_model <- train(data=Boston, medv ~ ., method="lm")
  
lm_multi_model %>% summary()

# 予測
train_size = 0.7
train_index <- sample(Boston %>% nrow(), Boston %>% nrow() * train_size)
train_data <- Boston[train_index,] # 訓練データ
test_data <- Boston[-train_index,] # テストデータ

lm_multi_model2 <- train(data=train_data, medv ~ ., method="lm")
y_pred <- predict(lm_multi_model2, test_data)
y_pred - test_data$medv

# MAE
## 単回帰
lm_single_model <- train(data=train_data, medv ~ rm, method="lm")
y_pred <- predict(lm_single_model, test_data)
MAE(y_pred, test_data$medv)

## 重回帰
lm_multi_model <- train(data=train_data, medv ~ ., method="lm")
y_pred <- predict(lm_multi_model, test_data)
MAE(y_pred, test_data$medv)

