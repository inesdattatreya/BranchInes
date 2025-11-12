combine_csvs_to_excel <- function(folder_pattern = "csv_folder", output_prefix = "combined") {
  # Load required libraries
  if (!requireNamespace("readr", quietly = TRUE)) install.packages("readr")
  if (!requireNamespace("openxlsx", quietly = TRUE)) install.packages("openxlsx")
  if (!requireNamespace("rstudioapi", quietly = TRUE)) install.packages("rstudioapi")
  
  library(readr)
  library(openxlsx)
  library(rstudioapi)
  
  # Get the current script directory
  script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
  
  # Find the target folder matching the pattern
  folders <- list.dirs(path = script_dir, full.names = TRUE, recursive = FALSE)
  target_folder <- folders[grepl(folder_pattern, basename(folders))][1]
  
  if (is.na(target_folder)) {
    stop(paste("No folder matching pattern '", folder_pattern, "' found.", sep = ""))
  }
  
  # List CSV files
  csv_files <- list.files(path = target_folder, pattern = "\\.csv$", full.names = TRUE)
  
  if (length(csv_files) == 0) {
    stop("No CSV files found in the target folder.")
  }
  
  # Create workbook
  wb <- createWorkbook()
  
  for (csv_file in csv_files) {
    df <- read_csv(csv_file)
    sheet_name <- tools::file_path_sans_ext(basename(csv_file))
    addWorksheet(wb, sheet_name)
    writeData(wb, sheet = sheet_name, x = df)
  }
  
  # Create dynamic output filename
  folder_base <- basename(target_folder)
  timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S")
  output_filename <- paste0(output_prefix, "_", folder_base, "_", timestamp, ".xlsx")
  output_path <- file.path(script_dir, output_filename)
  
  # Save workbook
  saveWorkbook(wb, output_path, overwrite = TRUE)
  message("Excel file created at: ", output_path)
}

combine_csvs_to_excel("housinggame_session_16_240924_EPA_IntroDays_Ommen","combined")
combine_csvs_to_excel("housinggame_session_19_250923_EPA_IntroDays_Overasselt","combined")
combine_csvs_to_excel("housinggame_session_20_251007_VerzekeraarsMasterClass","combined")