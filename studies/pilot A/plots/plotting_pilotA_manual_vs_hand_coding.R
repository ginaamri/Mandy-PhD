
### PLOTTING PILOT A - manual coding vs. hand coding

# Gregor KAchel, Mandy Klatt
# January, 2020

##########################################################################
### load Libraries / install packages
##########################################################################

## http://www.eyetracking-r.com/


install.packages("tidyverse")
install.packages("lemon")

library(tidyverse) # contains ggplot2, dplyr...and all the other good things
library(lemon) # necessary for arranging multiple plots next to each other

### MANUAL CODING
##########################################################################
### Prepare data event durations and proportion durations looking at Gregor, plant, teddy and computer
##########################################################################

# read in data while specifying locale allows to set "," 
data_raw<-read_tsv("./Mandy1_PilotA_data_export_hand_coding_events.tsv", 
                   locale = locale(decimal_mark = ","))

view(data_raw)


# select relevant columns via SELECT
event_duration <- data_raw  %>% select(
  'Recording timestamp',                                      
  'Computer timestamp',
  Event, 
  )

 view(event_duration)




