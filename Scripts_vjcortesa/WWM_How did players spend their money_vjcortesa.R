# Load necessary libraries
library(readxl)
library(readr)
# Load if using RStudio (interactive session)
library(rstudioapi)
library(sqldf)

# # 1. Read the database folder to create accordingly the dataframes -----------

# Get the path of the current script (works in RStudio)
folder_name <- "housinggame_session_20_251007_VerzekeraarsMasterClass"
script_path <- rstudioapi::getActiveDocumentContext()$path
script_dir <- dirname(script_path)

# Set folder path dynamically
folder_path <- paste0(script_dir, "\\",folder_name)

# List all CSV files in the folder
csv_files <- list.files(path = folder_path, pattern = "\\.csv$", full.names = TRUE)

# List all CSV files in the folder
csv_data_list <- lapply(csv_files, read_csv)

# Optionally, name each list element by its file name (without extension)
names(csv_data_list) <- tools::file_path_sans_ext(basename(csv_files))

#gameversion <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "gameversion.csv"))
#result <- sqldf("SELECT name FROM gameversion WHERE id = 13")

# gameversion <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "gameversion.csv"))
# gamesession <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "gamesession.csv"))
# group <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "group.csv"))
# groupround <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "groupround.csv"))
# playerround <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "playerround.csv"))
# welfaretype <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "welfaretype.csv"))
# scenario <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "scenario.csv"))
# player <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "player.csv"))
# housemeasure <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "housemeasure.csv"))
# housegroup <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "housegroup.csv"))
# measuretype <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "measuretype.csv"))
# personalmeasure <- read_csv(paste0(script_dir, "\\",folder_name, "\\", "personalmeasure.csv"))
# 
# # # 2. Add the variables to plot per session, group and player ------------
# # Add the session name variable remaned to avoid name overlap with the group name variable
# gamesession <- gamesession %>% rename(gamesession_name = name)
# 
# # Add to group the gamesession_name
# # Merge the gamesession selection into the group by the group = gamesession id
# # Inner_join keeps only the rows that have matching values in both data frames
# group <- group %>%
#   inner_join(gamesession %>% select(id, gamesession_name), by = c("gamesession_id" = "id"))
# 
# # Add to groupround the group_name and gamesession_name
# ## Merge the group selection into the groupround by the groupround = group id
# groupround <- groupround %>% 
#   inner_join(group %>% select(id, name, gamesession_id, gamesession_name, scenario_id), by = c("group_id" = "id"))
# ## Rename name variable in groupround for variable naming consistency
# groupround <- groupround %>% rename(group_name = name)
# 
# ## Add to playerround the groupround selection to filter per round, group and session id and names by playerround = groupround id
# playerround <- playerround %>%
#   inner_join(groupround %>% select(id, round_number, group_id, group_name, gamesession_id, gamesession_name, scenario_id), by = c("groupround_id" = "id"))
# 
# ## Add to playerround the player code to filter datasets per player by playerround = player id
# playerround <- playerround %>% 
#   inner_join(player %>% select(id, code), by = c("player_id" = "id"))