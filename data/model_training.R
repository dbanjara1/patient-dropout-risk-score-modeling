# Load necessary libraries
library(caret)
library(xgboost)
library(randomForest)

# Load preprocessed data
data <- read.csv("preprocessed_data.csv")

# Split data into training and testing sets
set.seed(123)
split_ratio <- 0.75
index <- sample(1:nrow(data), size = round(split_ratio * nrow(data)))
train_data <- data[index, ]
test_data <- data[-index, ]

# Convert categorical variables to factors
train_data$Therapeutic_Area <- as.factor(train_data$Therapeutic_Area)
train_data$Parking_availability <- as.factor(train_data$Parking_availability)
train_data$Study_burden <- as.factor(train_data$Study_burden)
train_data$gender <- as.factor(train_data$gender)
train_data$education <- as.factor(train_data$education)

test_data$Therapeutic_Area <- as.factor(test_data$Therapeutic_Area)
test_data$Parking_availability <- as.factor(test_data$Parking_availability)
test_data$Study_burden <- as.factor(test_data$Study_burden)
test_data$gender <- as.factor(test_data$gender)
test_data$education <- as.factor(test_data$education)

# Train models
models <- c("lm", "glmnet", "gbm", "xgbTree", "randomForest")
results <- list()

for (i in models) {
  fitControl <- trainControl(method = "cv", number = 5, verboseIter = FALSE, returnResamp = "all")
  model <- train(risk_score ~ ., data = train_data, method = i, trControl = fitControl)
  prediction <- predict(model, newdata = test_data)
  rmse <- sqrt(mean((prediction - test_data$risk_score)^2))
  results[[i]] <- rmse
}

# Identify the best model
best_model <- names(which.min(sapply(results, min)))

# Train the best model
best_model_fit <- train(risk_score ~ ., data = train_data, method = best_model, trControl = fitControl)

# Save the best model
saveRDS(best_model_fit, "best_model.rds")
