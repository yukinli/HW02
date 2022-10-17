library(ggplot2)
library(tidyverse)
library(tidymodels)
library(corrplot)
library(ggthemes)
library(yardstick)
tidymodels_prefer()

origin <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/abalone/abalone.data'
destination <- 'abalone.data'
download.file(origin, destination)
abalone <- read.table("abalone.data", sep = ",")
#1
Age <- abalone$V9 + 1.5
abalone$Age<-Age
setNames(abalone,c("Sex","Length","Diameter","Height","Whole","Shucked","Viscera","Shell","Rings","Age"))

#2
set.seed(3435)
abalone_split <- initial_split(abalone, prop = 0.80)
abalone_train <- training(abalone_split)
abalone_test <- testing(abalone_split)

#3
simple_abalone_recipe <-recipe(Age ~ ., data = abalone_train)
simple_abalone_recipe
abalone_recipe <- recipe(Age ~ ., data = abalone_train) %>%
  step_dummy(all_nominal_predictors())

#4
lm_model <- linear_reg() %>%
  set_engine("lm")

#5
lm_wflow <- workflow() %>%
  add_model(lm_model) %>%
  add_recipe(abalone_recipe)

#6
lm_fit <- fit(lm_wflow, abalone_train)
lm_fit %>% 
  extract_fit_parsnip() %>% 
  tidy()

#7
abalone_train_res <- predict(lm_fit, new_data = abalone_train %>% select(-Age))
abalone_train_res %>% 
  head()
abalone_train_res <- bind_cols(abalone_train_res, abalone_train %>% select(Age))
abalone_train_res %>% 
  head()
rmse(abalone_train_res, truth = Age, estimate = .pred)
abalone_metrics <- metric_set(rmse, rsq, mae)
abalone_metrics(abalone_train_res, truth = Age, 
                estimate = .pred)







