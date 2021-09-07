### ProVisioNET pilot data 
#### intercoder reli eye tracking data 01_01

if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if (!require(papaja)) install.packages("papaja"); library(papaja)
if (!require(psych)) install.packages('psych'); library(psych) # stats
if (!require(moments)) install.packages('moments'); library(moments) # skewness & kurtosis
if (!require(sjPlot)) install.packages('sjPlot'); library(sjPlot) # item analysis of a scale or index
if (!require(DescTools)) install.packages('DescTools'); library(DescTools) # cohens kappa
if (!require(irr)) install.packages('irr'); library(irr) # Various Coefficients of Interrater Reliability and Agreement
if (!require(readxl)) install.packages('readxl'); library(readxl) # read in excel files

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
  filter(TOI == "Chatting_with_neighbour",
         TOI == "Clicking_pen", 
         TOI == "Drawing", 
         TOI == "Drumming_with_hands", 
         TOI == "Head_on_table", 
         TOI == "Heckling",
         TOI == "Looking_at_phone",
         TOI == "Snipping_with_fingers",
         TOI == "Whispering"
         )