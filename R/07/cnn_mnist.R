# install.packages("tidyverse")
# install.packages("GGally")
# install.packages("caret")
# install.packages('e1071')
# devtools::install_github("rstudio/keras")

library(MASS)
library(tidyverse)
# library(caret)
library(keras)
# install_keras()

mnist <- dataset_mnist()
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

image_size <- 28

# reshape
x_train <- array_reshape(x_train, c(nrow(x_train), image_size, image_size, 1))
x_test <- array_reshape(x_test, c(nrow(x_test), image_size, image_size, 1))
# rescale
x_train <- x_train / 255
x_test <- x_test / 255

y_train <- to_categorical(y_train, 10)
y_test <- to_categorical(y_test, 10)


model <- keras_model_sequential() %>%
  layer_conv_2d(filters = 32, kernel_size = c(3,3), activation = 'relu',
                input_shape = c(image_size, image_size, 1)) %>% 
  layer_max_pooling_2d(pool_size = c(2, 2)) %>% 
  layer_flatten() %>% 
  layer_dense(units = 32, activation = 'relu') %>% 
  layer_dense(units = 10, activation = 'softmax')

model %>% summary()


model %>% compile(
  loss = 'categorical_crossentropy',
  optimizer = "Adam",
  metrics = c('accuracy')
)

history <- model %>% fit(
  x_train, y_train, 
  epochs = 5, batch_size = 64
)

model %>% evaluate(x_test, y_test)

