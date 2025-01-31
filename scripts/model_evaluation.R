# Load necessary libraries
library(caret)

# Load the best model
best_model <- readRDS("best_model.rds")

# Load test data
test_data <- read.csv("preprocessed_data.csv")[-index, ]

# Make predictions
predictions <- predict(best_model, newdata = test_data)

# Evaluate the model
rmse <- sqrt(mean((predictions - test_data$risk_score)^2))
print(paste("RMSE of the best model:", rmse))
