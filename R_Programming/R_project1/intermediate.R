# Read the data
car_data <- read.csv("car details v4.csv")

# Create a PDF file to save all plots
pdf("car_analysis_plots.pdf")

# 1. Pie Chart for Top Locations
location_table <- table(car_data$Location)
top_locations <- sort(location_table, decreasing = TRUE)[1:10]
pie(top_locations, 
    main = "Top 10 Car Locations",
    col = rainbow(10),
    labels = paste(names(top_locations), "\n", top_locations))

# 2. Pie Chart for Fuel Types
fuel_table <- table(car_data$Fuel.Type)
pie(fuel_table,
    main = "Distribution of Fuel Types",
    col = rainbow(length(fuel_table)),
    labels = paste(names(fuel_table), "\n", fuel_table))

# 3. Pie Chart for Top 10 Makes (Manufacturers)
make_table <- table(car_data$Make)
top_makes <- sort(make_table, decreasing = TRUE)[1:10]
pie(top_makes,
    main = "Top 10 Car Manufacturers",
    col = rainbow(10),
    labels = paste(names(top_makes), "\n", top_makes))

# 4. Pie Chart for Year Groups
year_breaks <- seq(min(car_data$Year), max(car_data$Year), by = 3)
year_groups <- cut(car_data$Year, breaks = year_breaks, include.lowest = TRUE)
year_table <- table(year_groups)
pie(year_table,
    main = "Distribution of Cars by Year Groups",
    col = rainbow(length(year_table)),
    labels = paste(names(year_table), "\n", year_table))

# 5. Pie Chart for Price Ranges
price_breaks <- quantile(car_data$Price, probs = seq(0, 1, 0.2))
price_groups <- cut(car_data$Price, breaks = price_breaks, include.lowest = TRUE)
price_table <- table(price_groups)
pie(price_table,
    main = "Distribution of Cars by Price Range",
    col = rainbow(length(price_table)),
    labels = paste("Range", 1:length(price_table), "\n", price_table))

# 6. Scatter Plot: Price vs Kilometer (keeping this as it's best shown as scatter)
plot(car_data$Kilometer, car_data$Price,
     main = "Price vs Kilometer",
     xlab = "Kilometers Driven",
     ylab = "Price (INR)",
     pch = 16,
     col = factor(car_data$Fuel.Type))
legend("topright", 
       legend = unique(car_data$Fuel.Type),
       col = 1:length(unique(car_data$Fuel.Type)),
       pch = 16,
       title = "Fuel Type")

# Close the PDF device
dev.off()

# Print summary statistics and explanations
cat("\nSummary Statistics:\n")

cat("\nTop 5 Locations by Number of Cars:\n")
print(head(sort(table(car_data$Location), decreasing = TRUE), 5))

cat("\nFuel Type Distribution:\n")
print(table(car_data$Fuel.Type))

cat("\nPrice Range Explanations:\n")
cat("Range 1:", format(price_breaks[1], scientific = FALSE), "to", format(price_breaks[2], scientific = FALSE), "INR\n")
cat("Range 2:", format(price_breaks[2], scientific = FALSE), "to", format(price_breaks[3], scientific = FALSE), "INR\n")
cat("Range 3:", format(price_breaks[3], scientific = FALSE), "to", format(price_breaks[4], scientific = FALSE), "INR\n")
cat("Range 4:", format(price_breaks[4], scientific = FALSE), "to", format(price_breaks[5], scientific = FALSE), "INR\n")
cat("Range 5:", format(price_breaks[5], scientific = FALSE), "to", format(price_breaks[6], scientific = FALSE), "INR\n")
