### PLOTTING PILOT A - 031 - material vs. class - automatic mapping

# Gregor KAchel, Mandy Klatt
# July, 2020

##########################################################################
### load Libraries / install packages
##########################################################################

## http://www.eyetracking-r.com/

if (!require(tidyverse)) install.packages("tidyverse", dep = TRUE)
if (!require(lemon)) install.packages("lemon", dep = TRUE)

# install.packages("tidyverse")
# install.packages("lemon")
# 
# library(tidyverse) # contains ggplot2, dplyr...and all the other good things
# library(lemon) # necessary for arranging multiple plots next to each other

### AUTOMATIC MAPPING
##########################################################################
### Prepare data TOTAL DURATION and PROPORTION DURATION of looking at AOIs Gregor, plant, teddy and computer
##########################################################################

# read in data while specifying locale allows to set "," 
data_raw<-read_tsv("./Mandy1_PilotA_031_metrics_class.tsv", 
                   locale = locale(decimal_mark = ","))

view(data_raw)

### TOTAL DURATION

# select relevant columns via SELECT
class_data_NA <- data_raw  %>% select(
  Total_duration_of_fixations.computer,
  Total_duration_of_fixations.gregor,
  Total_duration_of_fixations.plant,
  Total_duration_of_fixations.teddy
  )

view(class_data_NA)

# drop rows with NAs
class_data <- class_data_NA %>% filter(!is.na(Total_duration_of_fixations.computer+
                                              Total_duration_of_fixations.gregor+
                                              Total_duration_of_fixations.plant+
                                              Total_duration_of_fixations.teddy))

view(class_data)

# create new column names that give total duration of looking Computer, Gregor, Teddy and Plant
total_duration <- class_data  %>% 
  rename (Computer = Total_duration_of_fixations.computer,
          Gregor = Total_duration_of_fixations.gregor,
          Plant = Total_duration_of_fixations.plant,
          Teddy = Total_duration_of_fixations.teddy)

view(total_duration)
