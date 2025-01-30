# Read the data
car_data <- read.csv("car details v4.csv")

# Create PDF for plots
pdf("EDA_plots.pdf")

# Basic Structure and Summary
cat("\n=== DATASET STRUCTURE ===\n")
str(car_data)

cat("\n=== SUMMARY STATISTICS ===\n")
print(summary(car_data))

# Missing Values Analysis
cat("\n=== MISSING VALUES ANALYSIS ===\n")
missing_values <- sapply(car_data, function(x) sum(is.na(x)))
print(missing_values[missing_values > 0])

# Numerical Variables Analysis
numerical_vars <- sapply(car_data, is.numeric)
num_data <- car_data[, numerical_vars]

cat("\n=== NUMERICAL VARIABLES STATISTICS ===\n")
# Calculate descriptive statistics for numerical variables
num_stats <- data.frame(
  Mean = sapply(num_data, mean, na.rm = TRUE),
  Median = sapply(num_data, median, na.rm = TRUE),
  SD = sapply(num_data, sd, na.rm = TRUE),
  Variance = sapply(num_data, var, na.rm = TRUE),
  Skewness = sapply(num_data, function(x) {
    m3 <- mean((x - mean(x, na.rm = TRUE))^3, na.rm = TRUE)
    s3 <- sd(x, na.rm = TRUE)^3
    m3/s3
  }),
  Kurtosis = sapply(num_data, function(x) {
    m4 <- mean((x - mean(x, na.rm = TRUE))^4, na.rm = TRUE)
    s4 <- sd(x, na.rm = TRUE)^4
    m4/s4
  })
)
print(round(num_stats, 2))

# Correlation Analysis for Numerical Variables
cat("\n=== CORRELATION MATRIX ===\n")
cor_matrix <- cor(num_data, use = "complete.obs")
print(round(cor_matrix, 2))

# Categorical Variables Analysis
cat("\n=== CATEGORICAL VARIABLES ANALYSIS ===\n")
categorical_vars <- names(car_data)[!numerical_vars]
for(var in categorical_vars) {
  cat("\nFrequency table for", var, ":\n")
  freq_table <- table(car_data[[var]])
  prop_table <- prop.table(freq_table) * 100
  combined_table <- cbind(
    Frequency = as.vector(freq_table),
    Percentage = as.vector(prop_table)
  )
  print(round(combined_table, 2))
}

# Visualization Section

# 1. Histograms for Numerical Variables
par(mfrow = c(2, 2))
for(var in names(num_data)) {
  hist(num_data[[var]], main = paste("Histogram of", var),
       xlab = var, col = "lightblue", breaks = 30)
}

# 2. Box Plots for Numerical Variables
par(mfrow = c(2, 2))
for(var in names(num_data)) {
  boxplot(num_data[[var]], main = paste("Boxplot of", var),
          ylab = var, col = "lightgreen")
}

# 3. QQ Plots for Numerical Variables
par(mfrow = c(2, 2))
for(var in names(num_data)) {
  qqnorm(num_data[[var]], main = paste("Q-Q Plot of", var))
  qqline(num_data[[var]], col = "red")
}

# 4. Scatter Plot Matrix for Key Numerical Variables
key_vars <- c("Price", "Year", "Kilometer", "Engine", "Max.Power")
pairs(car_data[, key_vars], main = "Scatter Plot Matrix of Key Variables")

# 5. Bar Plots for Categorical Variables
par(mfrow = c(2, 2))
for(var in categorical_vars) {
  barplot(table(car_data[[var]]), 
          main = paste("Distribution of", var),
          las = 2,
          cex.names = 0.7)
}

# Price Analysis by Categories
# 1. Price by Fuel Type
boxplot(Price ~ Fuel.Type, data = car_data,
        main = "Price Distribution by Fuel Type",
        las = 2,
        col = rainbow(length(unique(car_data$Fuel.Type))))

# 2. Price by Location (Top 10)
top_locations <- names(sort(table(car_data$Location), decreasing = TRUE)[1:10])
location_data <- car_data[car_data$Location %in% top_locations,]
boxplot(Price ~ Location, data = location_data,
        main = "Price Distribution by Top Locations",
        las = 2,
        col = rainbow(10))

# 3. Price by Make (Top 10)
top_makes <- names(sort(table(car_data$Make), decreasing = TRUE)[1:10])
make_data <- car_data[car_data$Make %in% top_makes,]
boxplot(Price ~ Make, data = make_data,
        main = "Price Distribution by Top Makes",
        las = 2,
        col = rainbow(10))

# Additional Statistical Tests

# 1. Shapiro-Wilk test for normality of Price
cat("\n=== NORMALITY TEST FOR PRICE ===\n")
shapiro_test <- shapiro.test(car_data$Price)
print(shapiro_test)

# 2. ANOVA test for Price differences among Fuel Types
cat("\n=== ANOVA TEST: PRICE ~ FUEL TYPE ===\n")
anova_result <- aov(Price ~ Fuel.Type, data = car_data)
print(summary(anova_result))

# 3. Chi-square test of independence between Make and Fuel Type
cat("\n=== CHI-SQUARE TEST: MAKE vs FUEL TYPE ===\n")
chi_test <- chisq.test(table(car_data$Make, car_data$Fuel.Type))
print(chi_test)

# Close PDF device
dev.off()

# Calculate and print summary insights
cat("\n=== KEY INSIGHTS ===\n")

# Price Insights
cat("\nPrice Insights:\n")
cat("- Average car price:", format(mean(car_data$Price), big.mark = ",", scientific = FALSE), "INR\n")
cat("- Median car price:", format(median(car_data$Price), big.mark = ",", scientific = FALSE), "INR\n")
cat("- Price range:", format(min(car_data$Price), big.mark = ",", scientific = FALSE), "to", 
    format(max(car_data$Price), big.mark = ",", scientific = FALSE), "INR\n")

# Age Insights
current_year <- max(car_data$Year)
cat("\nAge Insights:\n")
cat("- Average car age:", round(current_year - mean(car_data$Year), 1), "years\n")
cat("- Newest car:", max(car_data$Year), "\n")
cat("- Oldest car:", min(car_data$Year), "\n")

# Market Insights
cat("\nMarket Insights:\n")
cat("- Most common fuel type:", names(which.max(table(car_data$Fuel.Type))), "\n")
cat("- Most common manufacturer:", names(which.max(table(car_data$Make))), "\n")
cat("- Most common location:", names(which.max(table(car_data$Location))), "\n")

# Kilometer Insights
cat("\nKilometer Insights:\n")
cat("- Average kilometers driven:", format(mean(car_data$Kilometer), big.mark = ",", scientific = FALSE), "km\n")
cat("- Median kilometers driven:", format(median(car_data$Kilometer), big.mark = ",", scientific = FALSE), "km\n")
cat("- Range:", format(min(car_data$Kilometer), big.mark = ",", scientific = FALSE), "to",
    format(max(car_data$Kilometer), big.mark = ",", scientific = FALSE), "km\n")
