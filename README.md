# Patient-dropout-risk-score-modeling

**Project Overview**

Clinical Trials Patient Dropout Risk Score Modeling
This repository contains the code and workflow for modeling patient dropout risk in clinical trials. The project involves defining variables of interest, collecting and cleaning data, generating synthetic data, preprocessing, training machine learning models, evaluating their performance, and deploying the best model for risk score generation.


**Objective**

To predict the risk of patient dropout in clinical trials using machine learning models. The risk score is generated based on patient-related, site-related, and sponsor/protocol-related factors.

**Key Steps**

Defined Variables of Interest:

Patient-related: Age, gender, education level, adverse events, etc.

Site-related: Distance to site, parking availability, study burden, time spent at site, etc.

Sponsor/Protocol-related: Therapeutic area, trial duration, treatment duration, etc.

**Data Collection:**

Data was sourced from the AACT database.

Additional sample data was generated using random and stratified sampling to supplement the dataset.

**Data Cleaning:**

Missing data and outliers were removed.

Only sponsored studies with at least a 10% dropout rate were included.

**Data Generation:**

The final dataset was created by combining modified AACT data and synthetic sample data.

**Data Split:**

The dataset was split into training (75%) and testing (25%) sets.

**Data Preprocessing:**

Variables like Patient ID, Visit Number, Visit Completion Flag, and Cumulative Visit Completion were removed.

Categorical variables (e.g., gender, education level, parking availability, study burden) were encoded using one-hot encoding.

**Model Generation:**

Multiple machine learning algorithms were compared:

Linear Model (lm)

Generalized Linear Model with Regularization (glmnet)

Gradient Boosting Machine (gbm)

Extreme Gradient Boosting (XGBoost)

Random Forest (randomForest)

Radial Support Vector Machine (SVM)

Model Evaluation:

Models were evaluated using Root Mean Squared Error (RMSE).

XGBoost performed the best with the lowest RMSE of 0.003.

Model Deployment:

The trained model is deployed in R to generate risk scores for study patient data.

Risk scores are stored in a MySQL database for each patient visit.

**Repository Structure**

clinical-trials-dropout-risk/
├── data_preprocessing.R          # Script for data cleaning and preprocessing
├── model_training.R              # Script for training ML models
├── model_evaluation.R            # Script for evaluating model performance
├── preprocessed_data.csv         # Preprocessed dataset
├── best_model.rds                # Serialized best model (XGBoost)
├── README.md                     # Project documentation

**Dependencies**
R (>= 4.0.0)

R Libraries:

dplyr (data manipulation)

caret (model training and evaluation)

xgboost (XGBoost implementation)

randomForest (Random Forest implementation)

e1071 (SVM implementation)

glmnet (Generalized Linear Model with Regularization)

**Results**
Best Model: XGBoost

Evaluation Metric: RMSE = 0.003

**Key Insights:**

Patient dropout risk is influenced by factors such as distance to site, adverse events, and study burden.

The XGBoost model effectively captures these relationships and provides accurate risk predictions.

**Future Work**
Incorporate additional data sources to improve model accuracy.

Develop a user-friendly interface for risk score generation.

Extend the model to predict dropout risk for different therapeutic areas.

**License**
This project is licensed under the MIT License. See the LICENSE file for details.

**Contact**
For questions or feedback, please contact:
Dinesh B
Email: coolsunshine77@gmail.com
GitHub: dbanjara1
