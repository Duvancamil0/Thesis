data <- read_csv("/Users/camilodavid/Library/CloudStorage/OneDrive-Personal/Tohoku U/PhD/Thesis/Github/chapters_code/Chaper_4/Similarity/similarity.csv")

library(ROCR)

# Create a prediction object
pred <- prediction(predictions = data$Average, labels = data$Logical)

# Calculate the performance for TPR (sensitivity) vs. FPR (1 - specificity)
perf <- performance(pred, "tpr", "fpr")
tpr_values <- perf@y.values[[1]]
fpr_values <- perf@x.values[[1]]
thresholds <- perf@alpha.values[[1]]

# Your desired TPR and FPR
desired_tpr <- 0.65
desired_fpr <- 0.16

# Calculate the Euclidean distance from each point on the ROC curve to your desired point
distances <- sqrt((tpr_values - desired_tpr)^2 + (fpr_values - desired_fpr)^2)

# Find the index of the minimum distance
min_distance_index <- which.min(distances)

# Find the corresponding threshold
optimal_threshold <- thresholds[min_distance_index]

cat("Optimal threshold for desired TPR and FPR:", optimal_threshold, "\n")

# Plot ROC curve and mark the selected point
plot(perf, colorize = TRUE, main="ROC Curve")
abline(a=0, b=1, lty=2, col="gray")
points(fpr_values[min_distance_index], tpr_values[min_distance_index], col="red", pch=19)
text(fpr_values[min_distance_index], tpr_values[min_distance_index], 
     labels=paste("Threshold =", round(optimal_threshold, 2)), pos=4)

table <- matrix(c(28, 14, 11, 55), nrow = 2, byrow = TRUE,
                dimnames = list(c("Yes", "No"),
                                c("> 95%", "< 95%")))

# Convert the matrix to a dataframe for ggplot
data <- as.data.frame(as.table(table))

# Rename the columns appropriately
names(data) <- c("Improvement", "Similarity", "Count")

# Example in R for a simple bar plot
library(ggplot2)

ggplot(data, aes(x = Similarity, y = Count, fill = Improvement)) +
  geom_bar(stat = "identity", position = position_dodge(), color = "black") +
  scale_fill_manual(values = c("Yes" = "darkgreen", "No" = "red")) +
  theme_minimal() +
  labs(title = "Improvement on Parameter Learning by Dataset Similarity",
       x = "Augmented Dataset Similarity", y = "Count") +
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        axis.title.x = element_text(size = 16),
        axis.title.y = element_text(size = 16),
        legend.title = element_text(size = 16),
        legend.text = element_text(size = 14),
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14)) +
  geom_text(aes(label = Count), vjust = -0.5, position = position_dodge(0.9), size = 5)
