# Load the tiff package
library(tiff)
library(raster)
library(tidyverse)
library(sf)
library(mapedit)
library(mapview)
# Specify the folder where your TIF files are located
folder_path <- "E:\\BGIS_BK\\Capstone\\LC08_L1TP_042024_20200726_20200908_Calgary"

# List all TIF files in the folder
tif_files <- list.files(path = folder_path, pattern = "\\.TIF$", full.names = TRUE)

# Loop through the TIF files and print their properties
for (file in tif_files) {
  print(file)
  band_name_split <- strsplit(file,"_")[[1]]
  band_name <- band_name_split[length(band_name_split)]
  print(band_name)
  currentBand <- raster(file)
  windows()
  plot(currentBand)+
    scale_fill_gradient(high = "#CEE50E", 
                        low = "#087F28",
                        name = "NDVI")
  title(band_name)
}

