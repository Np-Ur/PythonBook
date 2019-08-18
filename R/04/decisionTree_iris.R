# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')
# install.packages("doParallel")

library(MASS)
library(tidyverse)
library(caret)
library(doParallel)

detectCores()
cl <- makePSOCKcluster(4)
registerDoParallel(cl)

# データ整形
data_iris <- iris %>% 
  filter(Species != "virginica") %>% select(-Species) %>% 
  mutate(Species = as.matrix(iris$Species[1:100]))

# 決定木
# 予測
train_size = 0.7
train_index <- sample(data_iris %>% nrow(), data_iris %>% nrow() * train_size)
train_data <- data_iris[train_index,] # 訓練データ
test_data <- data_iris[-train_index,] # テストデータ


decisionTree_model <- train(Species ~ ., data=train_data, method="rpart")
y_pred <- predict(decisionTree_model, test_data)
confusionMatrix(data = y_pred, test_data$Species %>% as.factor())

