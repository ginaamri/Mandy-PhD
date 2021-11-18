### ProVisioNET Eyetracking TOI Coding Data 

library(needs)
needs(tidyverse,
      ggplot,
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
expert_toi <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_experts_intervall.tsv",
                       locale = locale(decimal_mark = ","))
novice_toi <- read_tsv(file = "./data/ProVisioNET_study_glasses_metrics_novice_intervall.tsv",
                       locale = locale(decimal_mark = ","))


# combine two data frames 
toi <- rbind(expert_toi, novice_toi)

# filter relevant rows only for time to first reaction
toi_react <- toi %>% filter(TOI == "Lesson" |
                            TOI == "Whispering")


# select relevant columns only for time to first event
toi_react <- toi_react %>% 
  select(Group, TOI,
         Time_to_first_Event.Reaction_chatting,
         Time_to_first_Event.Reaction_clicking,
         Time_to_first_Event.Reaction_drawing,
         Time_to_first_Event.Reaction_drumming,
         Time_to_first_Event.Reaction_head,
         Time_to_first_Event.Reaction_heckling,
         Time_to_first_Event.Reaction_phone,
         Time_to_first_Event.Reaction_snipping,
         Time_to_first_Event.Reaction_whispering)

# changing from wide to long format
toi_react <- toi_react %>% 
  pivot_longer(!Group, names_to = "Events", values_to = "Time")


# changing milliseconds into seconds
toi_react <- round(toi_react$Time_to_first_Event.Reaction_chatting/1000,
                   toi_react$Time_to_first_Event.Reaction_clicking/1000,
                   toi_react$Time_to_first_Event.Reaction_drawing/1000,
                   toi_react$Time_to_first_Event.Reaction_drumming/1000,
                   toi_react$Time_to_first_Event.Reaction_head/1000,
                   toi_react$Time_to_first_Event.Reaction_heckling/1000,
                   toi_react$Time_to_first_Event.Reaction_chatting/1000,
                                                    digits = 2)         
         
         
         
         
         