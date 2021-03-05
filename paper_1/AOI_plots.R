
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

# convert into numeric
et.raw.data <- et.raw.data %>%  mutate(Total.duration.of.fixation.in.AOI..sec. = as.numeric(Total.duration.of.fixation.in.AOI..sec.),
                                       Average.duration.of.fixation.in.AOI..sec. = as.numeric(Average.duration.of.fixation.in.AOI..sec.),
                                       Number.of.fixations.in.AOI = as.numeric (Number.of.fixations.in.AOI),
                                       Total.Time.of.Interest.Duration..sec. = as.numeric(Total.Time.of.Interest.Duration..sec.))


# create a basic table (tibble) using tidyverse functions for all disruptions 
# Change Number of Digits in Global R Options to reduce the number of digits after the decimal point to two
options(digits = 2)              

et.table <- et.raw.data %>%
  group_by(Type.of.disruption, Group) %>%
  filter(Type.of.disruption != "staring out the window") %>%
  rename ('Type of Disruption' = Type.of.disruption) %>%
  summarise("Mean Duration of Fixations" = mean(Total.duration.of.fixation.in.AOI..sec.),
            "Number of Fixations" = mean(Number.of.fixations.in.AOI),
            "TOI" = mean(Total.Time.of.Interest.Duration..sec.))
 
# create new columns that give proportion of the duration of looking at AOIs
# relative duration divided by total duration is the proportion
proportion.et.data <- et.raw.data %>% 
  group_by(Type.of.disruption, Group) %>%
  summarise(Proportion = Average.duration.of.fixation.in.AOI..sec./Total.duration.of.fixation.in.AOI..sec.)

