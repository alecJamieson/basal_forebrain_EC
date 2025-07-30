#Script to generate Figure 3
# Load libraries
library(ggplot2)
library(ggthemes)
library(gridExtra)

# Define paths (change if needed)
file_path1 <- "/Users/ajjami/Documents/NAASA_Rest/Diagnosis_predict.csv"

# Load the dataset
data1 <- read.csv(file_path1)

# Calculate correlation
cor_test <- cor.test(data1$Observed_dx, data1$Predicted_dx, alternative = "greater", method = "pearson")
r_val <- round(cor_test$estimate, 2)
p_val <- sprintf("%.5f", cor_test$p.value)
df_val <- cor_test$parameter

# Create the right scatter plot
plot1 <- ggplot(data1, aes(x = Observed_dx, y = Predicted_dx)) +
  geom_point(color = "#0073C2FF", size = 3, alpha = 0.7) +
  labs(
    subtitle = paste0("corr(df:", df_val, ") = ", r_val, "; p = ", p_val),
    x = "Observed Group",
    y = "Predicted Group"
  ) +
  coord_cartesian(ylim = c(-5, 5)) +
  theme_minimal(base_size = 14, base_family = "Arial") +
  theme(
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12, color = "black"),
    panel.grid.major = element_line(color = "grey"),
    panel.grid.minor = element_line(color = "lightgrey"),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

# Calculate the CI for left plot
data1$lower_ci <- data1$Predicted_dx - data1$Predicted_variance
data1$upper_ci <- data1$Predicted_dx + data1$Predicted_variance

# Create the left line plot with CI
plot2 <- ggplot(data1, aes(x = ID, y = Predicted_dx)) +
  geom_line(color = "black") +
  geom_ribbon(aes(ymin = lower_ci, ymax = upper_ci), fill = "#0073C2FF", alpha = 0.2) +
  labs(
    subtitle = "Diagnostic Group Out of Sample Estimate",
    x = "Participants",
    y = "Predicted Group" 
  ) +
  coord_cartesian(ylim = c(-5, 5)) +
  scale_x_continuous(breaks = seq(0, 147, by = 10), limits = c(0,147)) +
  theme_minimal(base_size = 14) +
  theme(
    plot.subtitle = element_text(size = 14, hjust = 0.5),
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12, color = "black"),
    panel.grid.major = element_line(color = "grey"),
    panel.grid.minor = element_line(color = "lightgrey"),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

# Arrange plots
grid.arrange(plot2, plot1, ncol = 2)
