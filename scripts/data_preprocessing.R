# Load necessary libraries
library(dplyr)
library(caret)

# Set seed for reproducibility
set.seed(123)

# Load data
resp <- read.csv("./Respiratory Data.csv")

# Data preprocessing
resp1 <- resp %>%
  filter(Industry == "Sponsor", dwp_all > 5, Age_mean >= 18) %>%
  group_by(nct_id, Disease, Phase) %>%
  mutate(Id = row_number()) %>%
  mutate(LastFlag = ifelse(Id == first(Id), "Yes", "No")) %>%
  filter(LastFlag == "Yes") %>%
  mutate(sample = 30, dropprob = dwp_all / 100)

resp1$dropprob <- as.numeric(resp1$dropprob)

# Calculate dropout probabilities by disease
drp <- sum(resp1$dwp_all)
xx <- unique(resp1$Disease)

for (i in xx) {
  drp1 <- sum(subset(resp1, Disease == i)$dwp_all) / drp
  print((drp1 / 0.329356) * 100)
  print(i)
}

# Generate synthetic patient data
studies <- c("NCT1", "NCT2", "NCT3")
therapeutic_areas <- c("Cancer", "Asthma", "Sleep Apnea", "Fibrosis", "Rhinitis", "Cystic Fibrosis", "Inf.Disease", "COPD", "Embolism", "PH", "Nasal Polyps")
genders <- c("Male", "Female")
educations <- c("Low", "Medium", "High")

resp2 <- resp1 %>%
  ungroup() %>%
  select(study_name = nct_id, age = Age_mean, trial_duration = Duration.Trial,
         treatment_duration = Duration.Treatment, therapeutic_area = Disease) %>%
  mutate(gender = sample(genders, 679, replace = TRUE, prob = c(0.6, 0.4)),
         education = sample(educations, 679, replace = TRUE, prob = c(0.3, 0.5, 0.2)),
         distance = round(runif(679, 0, 20), 2),
         Parking_availability = sample(c("Easy", "Moderate", "Difficult"), 679, replace = TRUE),
         Study_burden = sample(c("Low", "Moderate", "High"), 679, replace = TRUE),
         Time_spent_at_site = round(rnorm(679, mean = 4, sd = 1))) %>%
  select(study_name, age, gender, education, distance, therapeutic_area, trial_duration, treatment_duration, Parking_availability,
         Study_burden, Time_spent_at_site)

resp2 <- resp2 %>%
  mutate_if(is.numeric, round) %>%
  ungroup() %>%
  mutate(id = row_number()) %>%
  mutate(patient_id = id + 4000)

resp_duplicated <- do.call(rbind, lapply(1:12, function(i) resp2)) %>%
  mutate(Adverse_event = sample(0:12, 8148, replace = TRUE)) %>%
  group_by(patient_id) %>%
  mutate(visit_number = cumsum(id))

respfinal <- resp_duplicated %>%
  mutate(visit_number = cumsum(id))

# Save preprocessed data
write.csv(respfinal, "preprocessed_data.csv", row.names = FALSE)
