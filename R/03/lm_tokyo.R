# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")

library(MASS)
library(tidyverse)
library(GGally)
library(caret)

# データ読み込み
data_tokyo <- read.csv("src/03/13_Tokyo_20171_20184.csv", header = TRUE, encoding = "cp932")

data_tokyo %>% summary()
data_tokyo %>% head()

# 整形
data_used_apartment <- data_tokyo %>% filter(種類 == "中古マンション等")
columns_name_list <- c("最寄駅.距離.分.", "間取り", "面積...","建築年", "建物の構造", "建ぺい率...", "容積率...", "市区町村名", "取引価格.総額.")
data_selected_dropna <- data_used_apartment %>% select(columns_name_list) %>% 
  na.omit() %>%  filter(str_detect(建築年, "^平成|昭和")) %>% 
  filter(str_detect(最寄駅.距離.分., "\\?", negate = TRUE))

wareki_to_seireki = c(1926-1, 1989-1)
building_year_list <- data_selected_dropna$建築年

building_age_list <- c()
for (i in 1:(building_year_list %>% length())){
  # 西暦に変換
  tmp <- unlist(strsplit(as.character(building_year_list[i]), "成|和|年"))
  if (tmp[1] == "平"){
    seireki = wareki_to_seireki[2] + as.integer(tmp[2])
  }
  else {
    seireki = wareki_to_seireki[1] + as.integer(tmp[2])
  }
  # 築年数に変換
  building_age = 2018 - seireki
  
  building_age_list = c(building_age_list, building_age)
}

data_selected_dropna$築年数 <- building_age_list
data_selected_dropna <- data_selected_dropna[, colnames(data_selected_dropna) != "建築年"]
data_selected_dropna$最寄駅.距離.分. <- as.numeric(data_selected_dropna$最寄駅.距離.分)
data_selected_dropna$面積... <- as.numeric(data_selected_dropna$面積...)

data_added_dummies <- data_selected_dropna %>% filter(取引価格.総額. < 60000000)

# 線形回帰
## 単回帰
lm_model <- train(data=data_added_dummies, 取引価格.総額. ~ 面積..., method="lm")
lm_model %>% summary()

## 重回帰
lm_multi_model <- train(data=data_added_dummies, 取引価格.総額. ~ ., method="lm")
lm_multi_model %>% summary()

# 予測
train_size = 0.7
train_index <- sample(data_added_dummies %>% nrow(), data_added_dummies %>% nrow() * train_size)
train_data <- data_added_dummies[train_index,] # 訓練データ
test_data <- data_added_dummies[-train_index,] # テストデータ

lm_multi_model2 <- train(data=train_data, 取引価格.総額. ~ ., method="lm")
y_pred <- predict(lm_multi_model2, test_data)
y_pred - test_data$取引価格.総額.

# MAE
## 単回帰
lm_single_model <- train(data=train_data, 取引価格.総額. ~ 面積..., method="lm")
y_pred <- predict(lm_single_model, test_data)
MAE(y_pred, test_data$取引価格.総額.)

## 重回帰
lm_multi_model <- train(data=train_data, 取引価格.総額. ~ ., method="lm")
y_pred <- predict(lm_multi_model, test_data)
MAE(y_pred, test_data$取引価格.総額.)

