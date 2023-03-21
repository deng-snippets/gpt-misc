# Load required packages
library(dplyr)     # For data manipulation
library(ggplot2)   # For data visualization
library(FactoMineR)# For PCA
library(factoextra)# For data visualization after PCA
library(cluster)   # For clustering

# Load dataset
mydata <- read.csv("mydata.csv")

# Perform PCA
mydata_pca <- mydata[, 1:5]
pca <- FactoMineR::PCA(mydata_pca, scale.unit = TRUE, graph = FALSE)

# Visualize PCA results
fviz_pca_ind(pca, label = "none", addEllipses = TRUE, ggtheme = theme_classic())

# Perform clustering
kmeans_model <- kmeans(mydata_pca, centers = 3, nstart = 25)

# Visualize clustering results
fviz_cluster(kmeans_model, data = mydata_pca, geom = "point", ggtheme = theme_classic())
