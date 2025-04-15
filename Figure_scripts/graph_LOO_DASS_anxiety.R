#Script to generate figure 4, panel e
# Load required libraries
library(ggplot2)
library(ggthemes)
library(gridExtra)

# Define file paths (modify if needed)
file_path1 <- "/Users/ajjami/Documents/NAASA_Rest/DASS_Anx.csv"

# Load the dataset
data1 <- read.csv(file_path1)

# Create the right scatter plot
plot1 <- ggplot(data1, aes(x = Observed_DASS, y = Predicted_DASS)) +
  geom_point(color = "#0073C2FF", size = 3, alpha = 0.7) +
  geom_smooth(method = "lm", color = "black", linetype = "dashed", se = FALSE) +
  labs(
    subtitle = "corr(df:50) = 0.35: p = 0.00593", #Values taken from matlab results (update for each analysis)
    x = "Observed DASS Anxiety Scores",
    y = "Predicted DASS Anxiety Scores"
  ) +
  coord_cartesian(ylim = c(-8, 6)) +
  theme_minimal(base_size = 12) +
  theme(
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 12, color = "#444444"),
    panel.grid.major = element_line(color = "grey"),
    panel.grid.minor = element_line(color = "lightgrey"),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

# Calculate the confidence intervals for left plot
data1$lower_ci <- data1$Predicted_DASS - data1$Predicted_variance
data1$upper_ci <- data1$Predicted_DASS + data1$Predicted_variance

# Create the left plot with confidence intervals
plot2 <- ggplot(data1, aes(x = ID, y = Predicted_DASS)) +
  geom_line(color = "black") +
  geom_ribbon(aes(ymin = lower_ci, ymax = upper_ci), fill = "#0073C2FF", alpha = 0.2) +
  labs(
    subtitle = "Out of Sample Estimate",
    x = "Participants",
    y = "Predicted DASS Anxiety Scores" 
  ) +
  coord_cartesian(ylim = c(-8, 6)) +
  scale_x_continuous(breaks = seq(0, 140, by = 10)) +
  theme_minimal(base_size = 12) +
  theme(
    plot.subtitle = element_text(size = 12, hjust = 0.5),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 12, color = "#444444"),
    panel.grid.major = element_line(color = "grey"),
    panel.grid.minor = element_line(color = "lightgrey"),
    panel.background = element_rect(fill = "white", color = NA),
    plot.background = element_rect(fill = "white", color = NA)
  )

# Arrange plots
grid.arrange(plot2, plot1, ncol = 2)