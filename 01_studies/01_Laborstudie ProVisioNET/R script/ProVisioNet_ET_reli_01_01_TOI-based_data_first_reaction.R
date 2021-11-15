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


# # replace 0 with NA
# # for AP
# reaction_AP$Time_to_first_Reaction[reaction_AP$Time_to_first_Reaction == 0] <- NA


# do it again for MK
reaction_MK <- reaction_MK %>%
  rowwise() %>%
  mutate(Time_to_first_Reaction = sum(c_across(cols = contains("Time_to")),
                                      na.rm = T)) %>%
  ungroup() %>%
  select(TOI, Time_to_first_Reaction)

# # replace 0 with NA
# # for MK
# reaction_MK$Time_to_first_Reaction[reaction_MK$Time_to_first_Reaction == 0] <- NA

# combine the two rater data frames
reaction_complete <- left_join(x = reaction_AP, 
                               y = reaction_MK,
                               by = "TOI")

# changing milliseconds into seconds
reaction_complete$Time_to_first_Reaction.x <- round(reaction_complete$Time_to_first_Reaction.x/1000,
                                               digits = 2)

reaction_complete$Time_to_first_Reaction.y <- round(reaction_complete$Time_to_first_Reaction.y/1000,
                                                    digits = 2)



#################### Percentage Agreement ##############################

# create a new df with only the ratings 
reaction_ratings <- reaction_complete %>% select(Time_to_first_Reaction.x, Time_to_first_Reaction.y)

# function agree() with a tolerance of 2 seconds
## reference for tolerance: TIMSS video study tolerance of 10 to 30 seconds 
### Seidel, 2003, p. 105 
agree(reaction_ratings, tolerance = 2)


#################### Intercoder Correlation ##############################
ICC(x = reaction_complete %>%
      select(!TOI) %>%
      as.matrix())


# #################### CohenKappa ##############################
# 
# # data preparation
# 
# #calculate difference between columns row wise Time_to_first_Reaction.x and Time_to_first_Reaction.y
# # first, create two new data frames
# df1 <- subset.data.frame(reaction_ratings, select = c(Time_to_first_Reaction.x))
# df2 <- subset.data.frame(reaction_ratings, select = c(Time_to_first_Reaction.y))
# 
# # add the difference as a new column
# reaction_ratings$diff <- df1 - df2
# 
# # creating only absolute values with abs()
# reaction_ratings$diff <- abs(reaction_ratings$diff) 
# 
# # if rating difference > 2 seconds --> 0
# reaction_ratings$diff = ifelse(reaction_ratings$"diff"<2, "1","0")
# reaction_ratings$diff <- as.numeric(reaction_ratings$diff)
# 
# # add a new column with values --> 0 / 1 
# reaction_ratings$r2 = ifelse(reaction_ratings$"diff">2, "0","1")
# 
# 
# ### GREGOR
# # load packages
# if (!require(irr)) install.packages('irr'); library(irr) # cohens kappa
# if (!require(irrCAC)) install.packages('irrCAC'); library(irrCAC) # cohens kappa
# 
# # calculating Cohen.Kappa
# psych::cohen.kappa(x = as.matrix(reaction_ratings_kappa))
# reaction_ratings_kappa <- select(reaction_ratings, diff, r2)
# reaction_ratings_kappa
# reli.reaction_ratings.res <- kappa2(reaction_ratings_kappa, "unweighted")
# reli.reaction_ratings.res
# 
# ###################################################################
# 
# 
# # create percent agreement for validity
# reli.reaction_ratings.data <- reli.reaction_ratings.data  %>%
#   mutate(countagreement = if_else(diff == r2, 1, 0) )
# 
# 
# # create percent agreement for validity
# reli.reaction_ratings.data <- reli.reaction_ratings.data  %>%
#   mutate(countagreement = if_else(diff == r2, 1, 0) )
# 
# reli.reaction_ratings.agreement <- round(mean(reli.reaction_ratings.agreement.data$countagreement),2)*100
# reli.reaction_ratings.agreement
# 
# 
# reli.reaction_ratings.data
# 
# 
# 
# 
# 
# 
# reaction_ratings_kappa <- select(reaction_ratings,
#                       diff, r2) %>% transmute(diff = as_factor(diff),
#                                               r2 = as_factor(r2)
#                                               )
# 
# reaction_ratings_kappa <- as_factor(reaction_ratings_kappa)
# 
# psych::cohen.kappa(x = as.matrix(reaction_ratings_kappa),
#                    n.obs = 9,
#                    )




