### ProVisioNET pilot data 
#### intercoder reli eye tracking data 01_01

library(needs)
needs(tidyverse,
      psych,
      moments,
      sjPlot,
      DescTools,
      irr,
      readxl)

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)

r_refs("r-references.bib")


# read in data
reaction_AP <- read_tsv(file = "data/01_01_AP_ProVisioNET_study_glasses_Metrics_Intervall based.tsv"
)

reaction_MK <- read_tsv(file = "data/01_01_MK_ProVisioNET_study_glasses_Metrics_Intervall based.tsv"
)

# select relevant columns
reaction_AP <- reaction_AP %>% 
  select(TOI, 
         Time_to_first_Event.Reaction_chatting,
         Time_to_first_Event.Reaction_clicking,
         Time_to_first_Event.Reaction_drawing,
         Time_to_first_Event.Reaction_drumming,
         Time_to_first_Event.Reaction_head,
         Time_to_first_Event.Reaction_heckling,
         Time_to_first_Event.Reaction_phone,
         Time_to_first_Event.Reaction_snipping,
         Time_to_first_Event.Reaction_whispering
         )

reaction_MK <- reaction_MK %>% 
  select(TOI, 
         Time_to_first_Event.Reaction_chatting,
         Time_to_first_Event.Reaction_clicking,
         Time_to_first_Event.Reaction_drawing,
         Time_to_first_Event.Reaction_drumming,
         Time_to_first_Event.Reaction_head,
         Time_to_first_Event.Reaction_heckling,
         Time_to_first_Event.Reaction_phone,
         Time_to_first_Event.Reaction_snipping,
         Time_to_first_Event.Reaction_whispering
         )

# filter only for event TOIs 
reaction_AP <- reaction_AP %>% 
  filter(TOI == "Chatting_with_neighbour"|
         TOI == "Clicking_pen"| 
         TOI == "Drawing"|
         TOI == "Drumming_with_hands"| 
         TOI == "Head_on_table"| 
         TOI == "Heckling"|
         TOI == "Looking_at_phone" |
         TOI == "Snipping_with_fingers"|
         TOI == "Whispering"
         )

reaction_MK <- reaction_MK %>% 
  filter(TOI == "Chatting_with_neighbour"|
           TOI == "Clicking_pen"| 
           TOI == "Drawing"|
           TOI == "Drumming_with_hands"| 
           TOI == "Head_on_table"| 
           TOI == "Heckling"|
           TOI == "Looking_at_phone" |
           TOI == "Snipping_with_fingers"|
           TOI == "Whispering"
  )

# compute "rowise" sum across multiple columns but instead of typing column names, use tidy selection syntax
# for AP
reaction_AP <- reaction_AP %>%
  rowwise() %>%
  mutate(Time_to_first_Reaction = sum(c_across(cols = contains("Time_to")),
                                      na.rm = T)) %>%
  ungroup() %>%
  select(TOI, Time_to_first_Reaction)

# replace 0 with NA
# for AP
reaction_AP$Time_to_first_Reaction[reaction_AP$Time_to_first_Reaction == 0] <- NA

# do it again for MK
reaction_MK <- reaction_MK %>%
  rowwise() %>%
  mutate(Time_to_first_Reaction = sum(c_across(cols = contains("Time_to")),
                                      na.rm = T)) %>%
  ungroup() %>%
  select(TOI, Time_to_first_Reaction)

# replace 0 with NA
# for MK
reaction_MK$Time_to_first_Reaction[reaction_MK$Time_to_first_Reaction == 0] <- NA

# combine the two rater data frames
reaction_complete <- left_join(x = reaction_AP, 
                               y = reaction_MK,
                               by = "TOI")

# ICC
cor.test(x = reaction_complete$Time_to_first_Reaction.x,
         y = reaction_complete$Time_to_first_Reaction.y,
         method = "pearson")

ICC(x = select(reaction_complete,
               Time_to_first_Reaction.x,
               Time_to_first_Reaction.y
)
)

