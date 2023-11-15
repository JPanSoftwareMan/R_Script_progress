# Author: Justin Pan
# Purpose: script will run through all Landsat imagery sub folders in a main folder and calculate the NDVI for each of them. 
# In other words, this script will allow NDVI batch processing of multiple Landsat imagery folders.


# Load the neccessary packages
library(tiff)
library(raster)
library(tidyverse)
library(sf)
library(mapedit)
library(mapview)

library(stringr)
# Specify the folder where your TIF files are located
folder_path <- "D:\\CCDC_Calgary_project"

# List all TIF files in the folder
tif_files <- list.files(path = folder_path, pattern = "\\.TIF$", full.names = TRUE,recursive = TRUE)

#specify the output folder for storing the NDVI tif files
output_folder <- "D:\\CCDC_Calgary_Output"

#function calculates the NDVI for each folder and outputs it to the output folder 
calculate_ndvi <- function(red_band_path, nir_band_path, output_folder) {
  # Extract the date string (yyyyMMdd) using regular expression
  date_string <- str_extract(red_band_path, "\\d{8}")
  
  # Print the result
  cat("Date String:", date_string, "\n")
  
  #store red and NIR band tif's for the current input Landsat folder as rasters
  red_band <- raster(red_band_path)
  nir_band <- raster(nir_band_path)
  
  #calculate NDVI
  ndvi <- (nir_band - red_band) / (nir_band + red_band)
  
  # Construct the output filename based on the date string
  output_filename <- paste0(output_folder, "\\NDVI_", date_string, ".tif")
  print(output_filename)
  
  # Write the NDVI raster to the output folder
  writeRaster(ndvi, filename = output_filename, format = "GTiff", overwrite = TRUE)
}


#lines below 43 will find the band 4 and 5 of each landsat folder and will conduct NDVI calculations. 
band5_list <- list()
band4_list <- list()

# Loop through the TIF files and print their properties
for (file in tif_files) {
  
  #print full file path
  print(file)
  band_name_split <- strsplit(file,"_")[[1]]
  band_name <- band_name_split[length(band_name_split)]
  
  #print name of band
  print(band_name)
  
  if(band_name == "B5.TIF"){
    band5_list <- append(band5_list,file)
  }
  else if (band_name == "B4.TIF"){
    band4_list <- append(band4_list,file)
  }

}

band4_list <- c(band4_list)
band5_list <- c(band5_list)

len <- length(band5_list)

len



for (i in 1:len) {
  x <- band5_list[i]
  y <- band4_list[i]
  
  x <- gsub("/", "\\\\", x)
  y <- gsub("/", "\\\\", y)
  
  print(x)
  print(y)
  
  # Check if files exist
  if (file.exists(x) && file.exists(y)) {
    # Attempt to calculate NDVI and plot
    tryCatch({
      ndvi <- calculate_ndvi(x, y,output_folder)
      print(ndvi)  # Print NDVI values for verification
      
      # Optionally, visualize NDVI raster
      #plot(ndvi)
    }, error = function(e) {
      cat("Error:", e$message, "\n")
    })
  } else {
    cat("One or both files do not exist.\n")
  }
}




