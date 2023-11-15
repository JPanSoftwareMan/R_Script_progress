# Load the required packages
library(tiff)
library(raster)
library(tidyverse)
library(sf)
library(mapedit)
library(mapview)
#library(exif)

# Function to get the date of acquisition from a TIFF file
# get_acquisition_date <- function(file_path) {
#   exif_data <- read_exif(file_path)
#   creation_date <- exif_data$CreateDate
#   formatted_date <- format(creation_date, "%d%m%y")
#   return(formatted_date)
# }

# Specify the folder where your TIF files are located
folder_path <- "D:\\CCDC_Calgary_project"

# List all TIF files in the folder
tif_files <- list.files(path = folder_path, pattern = "\\.TIF$", full.names = TRUE, recursive = TRUE)

# Loop through the TIF files and print their properties
for (file in tif_files) {
  
  # Print full file path
  print(file)
  
  # Get and print the date of acquisition
  #acquisition_date <- get_acquisition_date(file)
  #cat("Date of Acquisition:", acquisition_date, "\n")
  
  # Print name of band
  band_name_split <- strsplit(file, "_")[[1]]
  band_name <- band_name_split[length(band_name_split)]
  print(band_name)
  
  # Open window and plot current band (if needed)
  # currentBand <- raster(file)
  # windows()
  # plot(currentBand)+
  # scale_fill_gradient(high = "#CEE50E", 
  #                     low = "#087F28",
  #                     name = "NDVI")
  # title(band_name)
}