# Read the CSV file
car_data <- read.csv("car details v4.csv", check.names = TRUE)

# Create a PDF file for all plots
pdf("car_analysis_plots.pdf", width=12, height=8)

# Set up plotting parameters for better visibility
par(mar=c(10, 4, 4, 2))

# 1. Bar Plot of Fuel Type Distribution
barplot(table(car_data$Fuel.Type), 
        main="Distribution of Fuel Types",
        las=2,
        col="skyblue",
        ylab="Number of Cars")

# 2. Box Plot of Price by Transmission
boxplot(Price ~ Transmission, data=car_data,
        main="Car Prices by Transmission Type",
        ylab="Price (₹)",
        col=c("lightgreen", "lightpink"))

# 3. Scatter Plot of Price vs Year
plot(car_data$Year, car_data$Price/100000,  # Converting to lakhs for better visibility
     main="Car Price vs Manufacturing Year",
     xlab="Manufacturing Year",
     ylab="Price (Lakhs ₹)",
     pch=19,
     col=rgb(0,0,1,0.2))

# 4. Bar Plot of Top 10 Locations
top_locations <- sort(table(car_data$Location), decreasing=TRUE)[1:10]
barplot(top_locations,
        main="Top 10 Cities by Number of Cars",
        las=2,
        col="salmon",
        ylab="Number of Cars")

# 5. Histogram of Car Ages
hist(2025 - car_data$Year,
     main="Distribution of Car Ages",
     xlab="Age (Years)",
     ylab="Frequency",
     col="lightblue",
     breaks=20)

# 6. Box Plot of Price by Owner Type
boxplot(Price/100000 ~ Owner, data=car_data,  # Converting to lakhs for better visibility
        main="Car Prices by Owner Type",
        las=2,
        col="lightyellow",
        ylab="Price (Lakhs ₹)")

# 7. Bar Plot of Top 10 Car Brands
top_brands <- sort(table(car_data$Make), decreasing=TRUE)[1:10]
barplot(top_brands,
        main="Top 10 Car Brands",
        las=2,
        col="lightgreen",
        ylab="Number of Cars")

# 8. Scatter Plot of Price vs Kilometer
plot(car_data$Kilometer/1000, car_data$Price/100000,  # Converting to thousands km and lakhs
     main="Car Price vs Kilometers Driven",
     xlab="Kilometers Driven (Thousands)",
     ylab="Price (Lakhs ₹)",
     pch=19,
     col=rgb(1,0,0,0.2))

# 9. Bar Plot of Color Distribution
top_colors <- sort(table(car_data$Color), decreasing=TRUE)[1:10]
barplot(top_colors,
        main="Top 10 Car Colors",
        las=2,
        col=c("gray95", "gray80", "gray60", "lightblue", "gray20", "pink", 
              "tan", "rosybrown", "yellow", "orange"),
        ylab="Number of Cars")

# Close the PDF device
dev.off()

# Print column names to verify structure
cat("\n=== Column Names ===\n")
print(names(car_data))

# 1. Basic Dataset Information
cat("\n=== Basic Dataset Information ===\n")
cat("Number of records:", nrow(car_data), "\n")
cat("Number of features:", ncol(car_data), "\n")

# 2. Summary Statistics
cat("\n=== Summary Statistics ===\n")
print(summary(car_data[c("Price", "Year", "Kilometer")]))

# 3. Fuel Type Analysis
cat("\n=== Fuel Type Distribution ===\n")
fuel_dist <- table(car_data$Fuel.Type)
print(fuel_dist)
cat("\nPercentage Distribution:\n")
print(round(prop.table(fuel_dist) * 100, 2))

# 4. Brand Analysis
cat("\n=== Top 10 Car Brands ===\n")
brand_dist <- sort(table(car_data$Make), decreasing = TRUE)[1:10]
print(brand_dist)

# 5. Price Analysis by Fuel Type
cat("\n=== Price Statistics by Fuel Type ===\n")
price_by_fuel <- tapply(car_data$Price, car_data$Fuel.Type, 
                       function(x) c(Mean = mean(x), 
                                   Median = median(x),
                                   Min = min(x),
                                   Max = max(x)))
print(price_by_fuel)

# 6. Transmission Analysis
cat("\n=== Transmission Type Distribution ===\n")
trans_dist <- table(car_data$Transmission)
print(trans_dist)
cat("\nPercentage Distribution:\n")
print(round(prop.table(trans_dist) * 100, 2))

# 7. Age Analysis
current_year <- 2025  # Using current year from metadata
car_data$Age <- current_year - car_data$Year
cat("\n=== Age Statistics ===\n")
print(summary(car_data$Age))

# 8. Location Analysis
cat("\n=== Top 10 Locations ===\n")
location_dist <- sort(table(car_data$Location), decreasing = TRUE)[1:10]
print(location_dist)

# 9. Owner Analysis
cat("\n=== Owner Distribution ===\n")
owner_dist <- table(car_data$Owner)
print(owner_dist)

# 10. Correlation Analysis for Numeric Variables
cat("\n=== Correlation between Price and Kilometer ===\n")
correlation <- cor(car_data$Price, car_data$Kilometer, use = "complete.obs")
print(correlation)

# 11. Seating Capacity Analysis
cat("\n=== Seating Capacity Distribution ===\n")
seating_dist <- table(car_data$Seating.Capacity)
print(seating_dist)

# 12. Color Analysis
cat("\n=== Top 10 Car Colors ===\n")
color_dist <- sort(table(car_data$Color), decreasing = TRUE)[1:10]
print(color_dist)

cat("\nVisualization completed! Check 'car_analysis_plots.pdf' for all charts.\n")
cat("Note: Prices in plots are shown in Lakhs (1 Lakh = 100,000 ₹) for better visibility\n")
