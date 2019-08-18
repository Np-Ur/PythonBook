# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')
# install.packages("doParallel")

library(MASS)
library(tidyverse)
library(caret)
library(doParallel)
library(RMeCab)

detectCores()
cl <- makePSOCKcluster(4)
registerDoParallel(cl)

# データ読み込み
tweets <- read.csv("src/04/tweets.tsv",sep = "\t") %>% na.omit()
tweets %>% dim()

y <- tweets$X1
text_all <- as.data.frame(tweets$X0)

# データ整形（tf-idf）
doc_matrix <- docDF(text_all, col = 1, type = 1, pos = c("名詞", "形容詞"), minFreq = 1, weight = "tf*idf*norm") %>% 
  filter(POS2 %in% c("一般", "固有名詞","自立"))
doc_matrix_t <- doc_matrix[, 4:ncol(doc_matrix)] %>% t()

rownames(doc_matrix_t) <- c(1:nrow(doc_matrix_t))
# colnames(doc_matrix_t) <- doc_matrix[, 1]

doc_matrix_t_1 <- cbind(doc_matrix_t, y %>% as.factor()) %>% na.omit()

doc_matrix_t_1[is.nan(doc_matrix_t_1)] <- NA
doc_matrix_df <- doc_matrix_t_1 %>% na.omit() %>% as.data.frame()

colnames(doc_matrix_df)[ncol(doc_matrix_df)] = "y"

# 決定木
# 予測
train_size = 0.7
train_index <- sample(doc_matrix_df %>% nrow(), doc_matrix_df %>% nrow() * train_size)
train_data <- doc_matrix_df[train_index,] # 訓練データ
test_data <- doc_matrix_df[-train_index,] # テストデータ


rf_model <- train(y ~ ., data=train_data, method="rf", tuneLength=4)
y_pred <- predict(rf_model, test_data)
confusionMatrix(data = y_pred %>% round() %>% as.factor(), test_data$y %>% as.factor())

