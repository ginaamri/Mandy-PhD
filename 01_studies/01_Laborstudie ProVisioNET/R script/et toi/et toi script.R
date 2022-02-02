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


# read in expert data
expert_toi <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_202_203_204_205_interval.tsv",
                       locale = locale(decimal_mark = ","))

# read in novice data
toi_novice1 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_101_interval.tsv",
                            locale = locale(decimal_mark = ","))

toi_novice2 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_108-111_interval.tsv",
                       locale = locale(decimal_mark = ","))

toi_novice3 <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics 102-107_interval.tsv",
                            locale = locale(decimal_mark = ","))

# combine the novice df
toi_novice <- rbind(toi_novice1, toi_novice2, toi_novice3)

# combine two data frames 
toi <- rbind(expert_toi, toi_novice)


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
  select(Group, TOI, Participant, Time_to_first_Reaction)


# changing milliseconds into seconds
toi_react$`Time to first reaction in seconds`<- round(toi_react$Time_to_first_Reaction/1000,
                                                    digits = 2)


# plotting time to first reaction for groups
react_group_plot <- 
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
  scale_fill_brewer(palette = "Set1") +
  ggtitle("Time to first reaction to disruptive person") +
  theme_classic() + 
  theme(legend.position="none",
        axis.text.x = element_text(size = 11),
        plot.title = element_text(size = 15, face = "bold"))

react_group_plot


# plotting time to first reaction for all disruptions
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
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(vars(TOI), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("Time to first reaction to disruptive person") +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 8,
                                angle = 65),
    plot.title = element_text(size = 15, face = "bold"))
    
react_plot



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
#   ylim(0,20) +
#   labs(x = "") +
#   scale_fill_brewer(palette = "Set1") +
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

# # arranging plots 
# grid.arrange(fix_plot, react_plot, ncol=2, nrow =1)

#################### MEAN, SD, N ############

# mean ttff
toi_fix_mean <- toi_fix %>%
  group_by(Group) %>%
  summarise("N"=n_distinct(Participant),
            "M" = round(mean(`Time to first fixation in seconds`), 2),
            "SD" = round(sd(`Time to first fixation in seconds`), 2))

# mean ttfr 
toi_react_mean <- toi_react %>%
  group_by(Group) %>%
  summarise("N"=n_distinct(Participant),
            "M" = round(mean(`Time to first reaction in seconds`), 2),
            "SD" = round(sd(`Time to first reaction in seconds`), 2))

        