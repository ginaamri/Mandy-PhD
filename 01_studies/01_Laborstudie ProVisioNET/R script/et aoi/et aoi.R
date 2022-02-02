### ProVisioNET Eyetracking AOI Coding Data 

library(needs)
needs(tidyverse,
      psych,
      moments,
      sjPlot,
      DescTools,
      irr,
      readxl, 
      gridExtra)

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)


# read in expert data
expert_aoi1 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_202_203_204_event_complete.tsv",
                       locale = locale(decimal_mark = ","))

expert_aoi2 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_205_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

expert_aoi3 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_206_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

expert_aoi4 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_207_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

# combine the expert df
expert_aoi <- rbind(expert_aoi1, expert_aoi2, expert_aoi3, expert_aoi4)
                    


# read in novice data
novice_aoi1 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_101_event_complete.tsv",
                        locale = locale(decimal_mark = ","))
                      
novice_aoi2 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_102-107_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

novice_aoi3 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_108-111_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

novice_aoi4 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_112_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

novice_aoi5 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_113-115_event_complete.tsv",
                        locale = locale(decimal_mark = ","))

# combine the novice df
novice_aoi <- rbind(novice_aoi1, novice_aoi2, novice_aoi3, novice_aoi4, novice_aoi5)



############### TIME TO FIRST FIXATION ####################

# filter relevant rows only for time to first reaction
toi_fix <- toi %>% filter (TOI == "Chatting_with_neighbour"|
                             TOI == "Clicking_pen"| 
                             TOI == "Drawing"|
                             TOI == "Drumming_with_hands"| 
                             TOI == "Head_on_table"| 
                             TOI == "Heckling"|
                             TOI == "Looking_at_phone" |
                             TOI == "Snipping_with_fingers"|
                             TOI == "Whispering")

# select relevant columns only for time to first fixation
toi_fix <- toi_fix %>% 
  select(Group, Participant, TOI, Time_to_first_fixation.Disruptive_Person, Number_of_fixations.Disruptive_Person)

# remoce all NAs
toi_fix <- na.omit(toi_fix)

# changing milliseconds into seconds
toi_fix$`Time to first fixation in seconds`<- round(toi_fix$Time_to_first_fixation.Disruptive_Person/1000,
                                                    digits = 2)

toi_fix$`Number of fixations on disruptive person` <- toi_fix$Number_of_fixations.Disruptive_Person


# plotting time to first fixation for groups
fix_group_plot <- 
  ggplot(data = toi_fix,
         mapping = aes(x = Group,
                       y = `Time to first fixation in seconds`)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  ylim(0,25) + 
  labs(x ="") + 
  scale_fill_brewer(palette = "Set1") +
  ggtitle("Time to first fixation to disruptive person") +
  theme_classic() + 
  theme(legend.position="none",
        axis.text.x = element_text(size = 11),
        plot.title = element_text(size = 15, face = "bold"))

fix_group_plot

# plotting time to first fixation for all disruptions
fix_plot <- 
  ggplot(data = toi_fix,
         mapping = aes(x = Group,
                       y = `Time to first fixation in seconds`)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  ylim(0,25) + 
  labs(x ="") + 
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(vars(TOI), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("Time to first fixation to disruptive person") +
  theme_classic() + 
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 6,
                                angle = 65),
    plot.title = element_text(size = 15, face = "bold"))

fix_plot
