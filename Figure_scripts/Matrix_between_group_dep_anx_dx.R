#Script to create Figure S2a and b
# Load libraries
library(ggplot2)
library(viridis)
library(gridExtra)

# Function to create a heatmap
create_heatmap <- function(Ep, Pp, title) {
  # Define regions
  regions <- c("Ch1-3", "Ch4", "VP", "Insula (R)", "Insula (L)", "vmPFC", "dACC", "PCC", "IPL (R)", "IPL (L)")
  
  # Create a data frame for the matrix
  df <- data.frame(
    x = rep(1:10, each = 10),
    y = rep(1:10, times = 10),
    value = Ep,
    Pp = Pp,
    region_x = factor(rep(regions, each = 10), levels = regions),
    region_y = factor(rep(regions, times = 10), levels = rev(regions))
  )
  
  # Set values to NA where Pp <= 0.99
  df$value[df$Pp <= 0.99] <- NA
  
  # Create the plot
  ggplot(df, aes(x = region_x, y = region_y, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "#134DD0", mid = "white", high = "#C70606", 
                         midpoint = 0, na.value = "white", 
                         limits = c(min(df$value, na.rm = TRUE), max(df$value, na.rm = TRUE)),
                         labels = scales::number_format(accuracy = 0.01)) +  # This line locks legend to 2 decimal places
    geom_text(aes(label = ifelse(Pp > 0.99, sprintf("%.2f", value), "")),
              color = "black", size = 3) +
    coord_fixed() +
    theme_minimal() +
    labs(title = title,
         x = "From",
         y = "To",
         fill = "Value") +
    theme(panel.grid = element_blank(),
          axis.text.x = element_text(angle = 45, hjust = 0, size = 11),
          axis.text.y = element_text(angle = 45, hjust = 1, size = 11),
          axis.title.x = element_text(margin = margin(b = 10), size = 12),
          axis.title.y = element_text(margin = margin(r = 10), size = 12),
          axis.text.x.top = element_text(angle = 45, hjust = 0, size = 11),
          axis.ticks.x.top = element_blank(),
          axis.ticks.x.bottom = element_blank(),
          axis.text.x.bottom = element_blank(),       
          legend.key.size = unit(1.2, "cm"),
          legend.key.width = unit(0.9, "cm"),
          legend.text = element_text(size = 11),
          legend.title = element_text(size = 12),
          legend.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")) +
    scale_x_discrete(position = "top") +
    guides(fill = guide_colorbar(barwidth = 1, barheight = 7))
}

# Set up Ep and Pp for the plots, values extracted using Ep_Pp_converter.m
Ep1 <- c(-0.21, 0.00, 0.12, -0.44, -0.37, 0.22, -0.13, 0.18, 0.00, 0.10, 
         0.00, -0.14, 0.18, 0.27, 0.26, -0.25, -0.11, -0.49, -0.59, -0.57, 
         0.00, 0.21, 0.09, 0.14, 0.12, -0.20, 0.05, -0.28, -0.42, -0.54, 
         -0.05, 0.11, 0.05, 0.36, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.05, 0.07, 0.00, 0.46, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.05, 0.00, 0.00, 0.00, 0.19, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.32, 0.00, 0.00, 0.00, 
         -0.05, 0.00, 0.05, 0.00, 0.00, 0.00, 0.00, 0.10, 0.00, 0.00, 
         0.01, 0.01, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, -0.10, 0.00, 
         0.00, 0.07, 0.06, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, -0.06)

Pp1 <- c(1.00, 0.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 0.00, 1.00, 
         0.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 1.00, 
         0.00, 1.00, 1.00, 1.00, 1.00, 1.00, 0.64, 1.00, 1.00, 1.00, 
         1.00, 1.00, 1.00, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 1.00, 1.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 1.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 
         1.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 
         0.00, 1.00, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1.00)

Ep2 <- c(0.00, 0.14, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.19, -0.20, 0.00, 0.00, -0.38, -0.26, -0.32, 0.00, -0.06, 
         0.01, 0.00, 0.00, 0.08, 0.06, 0.06, 0.00, 0.00, 0.00, -0.06, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         -0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, -0.01, 0.00, 0.00, 0.15, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.01, 0.11, -0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, -0.10, 0.00, 
         0.00, -0.09, 0.01, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00)

Pp2 <- c(0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 1.00, 1.00, 0.00, 0.00, 1.00, 1.00, 1.00, 0.00, 0.52, 
         0.00, 0.00, 0.00, 0.57, 0.53, 0.53, 0.00, 0.00, 0.00, 0.53, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 
         0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 1.00, 0.00, 
         0.00, 1.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00)

# Create the two plots
plot1 <- create_heatmap(Ep1, Pp1, "Average Control Connectivity")
plot2 <- create_heatmap(Ep2, Pp2, "Clinical Patients > Controls")

# Arrange the plots side by side
combined_plot <- grid.arrange(plot1, plot2, ncol = 2)