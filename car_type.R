# Load required libraries
library(dplyr)
library(ggplot2)

# Load the dataset
data(mtcars)

# Inspect the first few rows of the dataset
head(mtcars)

# Calculate summary statistics for each variable
summary(mtcars)

# Data manipulation: Add a new column 'car_type' based on the number of cylinders
mtcars$car_type <- ifelse(mtcars$cyl == 4, "4-cylinder",
                          ifelse(mtcars$cyl == 6, "6-cylinder", "8-cylinder"))

# Calculate average miles per gallon (mpg) for each car type
car_type_mpg <- mtcars %>% group_by(car_type) %>% summarise(avg_mpg = mean(mpg))
car_type_mpg

# Data visualization: Create a bar plot of average mpg by car type
ggplot(car_type_mpg, aes(x = car_type, y = avg_mpg, fill = car_type)) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Average MPG by Car Type",
       x = "Car Type",
       y = "Average MPG",
       fill = "Car Type") +
  theme(legend.position = "none")

# Data visualization: Create a scatter plot of mpg vs horsepower, colored by car type
ggplot(mtcars, aes(x = hp, y = mpg, color = car_type)) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(title = "MPG vs Horsepower",
       x = "Horsepower",
       y = "Miles per Gallon (MPG)",
       color = "Car Type") +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed", aes(group = car_type))
