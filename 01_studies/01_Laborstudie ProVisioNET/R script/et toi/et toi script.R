### ProVisioNET Eyetracking TOI Coding Data 

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

# read in data
expert_toi <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_202_203_interval.tsv",
                       locale = locale(decimal_mark = ","))
novice_toi <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_novice_interval.tsv",
                       locale = locale(decimal_mark = ","))


# combine two data frames 
toi <- rbind(expert_toi, novice_toi)


############### TIME TO FIRST REACTION ####################

# filter relevant rows only for time to first reaction
toi_react <- toi %>% filter (TOI == "Chatting_with_neighbour"|
                                    TOI == "Clicking_pen"| 
                                    TOI == "Drawing"|
                                    TOI == "Drumming_with_hands"| 
                                    TOI == "Head_on_table"| 
                                    TOI == "Heckling"|
                                    TOI == "Looking_at_phone" |
                                    TOI == "Snipping_with_fingers"|
                                    TOI == "Whispering")


# select relevant columns only for time to first event
toi_react <- toi_react %>% 
  select(Participant, Group, TOI,
         Time_to_first_Event.Reaction_chatting,
         Time_to_first_Event.Reaction_clicking,
         Time_to_first_Event.Reaction_drawing,
         Time_to_first_Event.Reaction_drumming,
         Time_to_first_Event.Reaction_head,
         Time_to_first_Event.Reaction_heckling,
         Time_to_first_Event.Reaction_phone,
         Time_to_first_Event.Reaction_snipping,
         Time_to_first_Event.Reaction_whispering)


# # compute "row-wise" sum across multiple columns but instead of typing column names, use tidy selection syntax
# toi_react <- toi_react %>%
#   rowwise() %>%
#   mutate(Time_to_first_Reaction = sum(c_across(cols = contains("Time_to")),
#                                       na.rm = T)) %>%
#   ungroup() %>%
#   select(Group, TOI, Time_to_first_Reaction)


# changing format with pivot_longer()
toi_react <-
  toi_react %>%
  pivot_longer(cols = contains("Time_to"),
               names_to = "Time_to_first_reaction",
               values_to = "Time_to_first_Reaction") %>%
  na.omit() %>% 
  select(Group, TOI, Time_to_first_Reaction)



# changing milliseconds into seconds
toi_react$`Time to first reaction in seconds`<- round(toi_react$Time_to_first_Reaction/1000,
                                                    digits = 2)


# plotting time to first reaction
react_plot <- 
  ggplot(data = toi_react,
         mapping = aes(x = Group,
                       y = `Time to first reaction in seconds`)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1,
                                        height = 0)) +
  ylim(0,25) + 
  labs(x = "") +
  scale_fill_brewer(palette = "RdBu") +
  facet_wrap(vars(TOI), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("Time to first reaction to disruptive person") +
  theme_minimal() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 8, 
                                angle = 80))
react_plot

         
############### TIME TO FIRST FIXATION ####################

# read in novice data
toi_fix_novice1 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_novice_interval_101;108-111.tsv",
                           locale = locale(decimal_mark = ","))

toi_fix_novice2 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_novice_interval_102-105.tsv",
                            locale = locale(decimal_mark = ","))

# combine the novice df
toi_fix_novice <- rbind(toi_fix_novice1, toi_fix_novice2)


# read in expert data
toi_fix_expert <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_202_203_interval.tsv",
                           locale = locale(decimal_mark = ","))


# combine two data frames 
toi_fix <- rbind(toi_fix_novice, toi_fix_expert)


# filter relevant rows = TOIs
toi_fix <- toi_fix %>% filter (TOI == "Chatting_with_neighbour"|
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
  select(Group, TOI, Time_to_first_fixation.Disruptive_Person, Number_of_fixations.Disruptive_Person)

# remoce all NAs
toi_fix <- na.omit(toi_fix)

# changing milliseconds into seconds
toi_fix$`Time to first fixation in seconds`<- round(toi_fix$Time_to_first_fixation.Disruptive_Person/1000,
                                                      digits = 2)

toi_fix$`Number of fixations on disruptive person` <- toi_fix$Number_of_fixations.Disruptive_Person

# plotting time to first fixation
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
  scale_fill_brewer(palette = "RdBu") +
  facet_wrap(vars(TOI), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("Time to first fixation to disruptive person") +
  theme_minimal() + 
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "none",
    strip.text.x = element_text(size = 8,
                                angle = 80))

fix_plot

# # plotting number of fixations for disruptive person
# number_plot <- 
#   ggplot(data = toi_fix,
#          mapping = aes(x = Group,
#                        y = `Number of fixations on disruptive person`)) +
#   geom_boxplot(mapping = aes(fill = Group)) +
#   geom_point(size = 2, 
#              alpha = 0.4,
#              position = position_jitter(seed = 1, 
#                                         width = 0.1)) +
#   labs(x = "") + 
#   scale_fill_brewer(palette = "RdBu") +
#   facet_wrap(vars(TOI), 
#              nrow = 1, strip.position = "bottom") +
#   ggtitle("Number of fixations on disruptive person") +
#   theme_minimal() +
#   theme(
#     axis.text.x = element_blank(),
#     axis.ticks.x = element_blank(),
#     strip.text.x = element_text(size = 8,
#                                 angle = 80))
# 
# number_plot



# arranging plots 
grid.arrange(fix_plot, react_plot, ncol=2, nrow =1)

  
        