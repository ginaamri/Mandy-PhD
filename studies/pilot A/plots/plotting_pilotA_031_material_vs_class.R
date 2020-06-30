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
data_raw<-read_tsv("./Mandy1_PilotA_031_metrics_AOI.tsv", 
                   locale = locale(decimal_mark = ","))

view(data_raw)

### TOTAL DURATION

# select relevant columns via SELECT
data_NA <- data_raw  %>% select(
  Recording,
  Toi,
  Total_duration_of_fixations.computer,
  Total_duration_of_fixations.gregor,
  Total_duration_of_fixations.plant,
  Total_duration_of_fixations.teddy,
  Total_duration_of_fixations.material
  )

view(data_NA)

# drop rows with NAs
total_duration_data <- data_NA %>% filter(!is.na(Total_duration_of_fixations.computer+
                                              Total_duration_of_fixations.gregor+
                                              Total_duration_of_fixations.plant+
                                              Total_duration_of_fixations.teddy+
                                              Total_duration_of_fixations.material))
view(total_duration_data)

# XXXGREGOR: ist hier wirklich nur "Entire Recording" wichtig oder auch die Snapshots als TOIs? 
# filter only total_duration for time of interest = entire recording to get full data
total_duration_data <- total_duration_data  %>% filter(
  Toi == "Entire Recording")

view(total_duration_data)

# create new column names that give total duration of looking Computer, Gregor, Teddy and Plant
total_duration <- total_duration_data  %>% 
  rename (Computer = Total_duration_of_fixations.computer,
          Gregor = Total_duration_of_fixations.gregor,
          Plant = Total_duration_of_fixations.plant,
          Teddy = Total_duration_of_fixations.teddy,
          Material = Total_duration_of_fixations.material)

view(total_duration)

# XXXGREGOR: wie schnallt R, dass computer, plant, gregor und teddy hier im long format der AOI untergeordnet werden?
# create data set of total duration in long format for plotting
total_duration_long <- gather(total_duration, AOI, duration, Computer:Material)

view(total_duration_long)


### PROPOTION DURATION

### create an additional data set with proportions of duration


# create a new column with name sum_aois that gives the sum of looking at all AOIs
total_duration <- total_duration  %>% mutate(sum_aois =
                                               Computer +
                                               Gregor+
                                               Plant+
                                               Teddy+
                                               Material)
view(total_duration)

# create new columns that give proportion of the duration of looking at AOIs
# relative duration divided by total duration is the proportion
proportion_duration <- total_duration  %>% 
  mutate(Computer = Computer/sum_aois)   %>% 
  mutate(Gregor = Gregor/sum_aois)   %>% 
  mutate(Plant = Plant/sum_aois)   %>% 
  mutate(Teddy = Teddy/sum_aois)   %>%
  mutate(Material = Material/sum_aois)

view(proportion_duration)

# # create data set of proportions in long format for plotting
# proportion_duration_long  <- gather(proportion_duration, AOI, proportion, Computer:Material)
# 
# view(proportion_duration_long)


#########################################################
### Plotting total duration and proportions of duration
#########################################################

# XXXGREGOR: wir hatten gesagt, dass es hier keinen Sinn macht, Boxplots zu nehmen, sondern eher Barplots, richtig?

### BOXPLOTS
### Plot data TOTAL DURATION
total.plot.raw <- ggplot(total_duration_long, aes(x = AOI, y = duration, colour = AOI, fill = AOI)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10))+
  geom_point(aes(shape = AOI), size = 3,)+
  geom_jitter(position = position_jitterdodge(jitter.width = 0, dodge.width = 0.8), size = 3, fill = FALSE)+
  geom_boxplot(fill = FALSE)+
  labs(y = "Total Duration of Looking at AOIs in ms", x = "AOI") +
  scale_x_discrete(labels=c(
    "Total_duration_of_fixations.computer" = "Computer", 
    "Total_duration_of_fixations.gregor" = "Gregor",
    "Total_duration_of_fixations.teddy" = "Teddy",
    "Total_duration_of_fixations.plant" = "Plant"
  ))

total.plot.raw

### Plot data PROPORTIONS
prop.plot <- ggplot(proportion_duration_long, aes(x = AOI, y = proportion, colour = AOI, fill = AOI)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10))+ 
  geom_point(aes(shape = AOI), size = 3,)+
  geom_jitter(position = position_jitterdodge(jitter.width = 0, dodge.width = 0.8), size = 3, fill = FALSE)+
  geom_boxplot(fill = FALSE)+
  labs(y = "Proportion of Looking at AOIs", x = "AOI")

prop.plot



### BARPLOTS
### Plot data TOTAL DURATION
duration_plot <- ggplot(total_duration, aes(x = `AOI:`, y = X5))+
  geom_bar(stat="identity", width=.5, fill="tomato") + 
  labs (title = "Total duration (s)", 
        x = 
        "Total_duration_of_fixations.computer" = "Computer", 
        "Total_duration_of_fixations.gregor" = "Gregor",
        "Total_duration_of_fixations.teddy" = "Teddy",
        "Total_duration_of_fixations.plant" = "Plant",
        "Total_duration_of_fixation.material = Material",
        y = "Total duration (s)")

duration_plot



