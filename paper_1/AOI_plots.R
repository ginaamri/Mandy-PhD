
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if (!require(papaja)) install.packages('papaja'); library(papaja)
if (!require(psych)) install.packages('psych'); library(psych) # stats
if (!require(moments)) install.packages('moments'); library(moments) # skewness & kurtosis
if (!require(sjPlot)) install.packages('sjPlot'); library(sjPlot) # item analysis of a scale or index

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)

# prepare data (selected from AOI data)
et.raw.data<-read.table("./data/Aperol_pilot_glasses_AOI.txt", dec=",", sep="\t", header=T) 

# create a basic table (tibble) using tidyverse functions for all disruptions 
# Change Number of Digits in Global R Options to reduce the number of digits after the decimal point to two
options(digits = 2)              

et.table <- et.raw.data %>% # select data
  group_by(Type.of.disruption, Group) %>%
  summarise("Total Duration of Fixations" = Total.duration.of.fixation.in.AOI..sec.,
            "Average Duration of Fixations" = Average.duration.of.fixation.in.AOI..sec.,
            "Number of Fixations" = Number.of.fixations.in.AOI)
