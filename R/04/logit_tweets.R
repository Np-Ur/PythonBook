# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')
# install.packages("RMeCab", repos = "http://rmecab.jp/R", type = "source") 

library(MASS)
library(tidyverse)
library(caret)
library(RMeCab)

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

doc_matrix_t_1 <- cbind(doc_matrix_t, y) %>% na.omit()

doc_matrix_t_1[is.nan(doc_matrix_t_1)] <- NA
doc_matrix_df <- doc_matrix_t_1 %>% na.omit() %>% as.data.frame()


# ロジスティック回帰
# logit_multi_model <- train(y ~ ., data=doc_matrix_df, method="glm", family=binomial())
# logit_multi_model %>% summary()

# 予測
train_size = 0.7
train_index <- sample(doc_matrix_df %>% nrow(), doc_matrix_df %>% nrow() * train_size)
train_data <- doc_matrix_df[train_index,] # 訓練データ
test_data <- doc_matrix_df[-train_index,] # テストデータ


logit_multi_model2 <- train(y ~ ., data=train_data, method="glm", family=binomial())
y_pred <- predict(logit_multi_model2, test_data)
confusionMatrix(data = y_pred %>% round() %>% as.factor(), test_data$y %>% as.factor())

