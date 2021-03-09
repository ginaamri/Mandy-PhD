
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
  

# create a new column with name Total that gives the sum duration in sec of looking at all AOIs
et.raw.data <- et.raw.data %>% mutate(Total = sum(Total.duration.of.fixation.in.AOI..sec.))


# create new columns that give proportion of the duration of looking at AOIs
# relative duration divided by total duration is the proportion
proportion.et.data <- et.raw.data %>% group_by(Group, Type.of.disruption) %>% 
                                      mutate(Proportion = Total.duration.of.fixation.in.AOI..sec./Total)


### Plot data TOTAL
total.plot <- ggplot(et.raw.data, aes(x = Type.of.disruption, y = Total.duration.of.fixation.in.AOI..sec., fill = Type.of.disruption)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10))+
  scale_x_discrete(guide = guide_axis(angle = 70)) +
  geom_boxplot()+
  facet_wrap(~ Group, nrow = 1)+
  theme_light() +
  theme(legend.position="none")+
  labs(y = "Total Duration of Looking at AOIs in sec", x = "AOI")

total.plot



### Plot data PROPORTIONS
prop.plot <- ggplot(proportion.et.data, aes(x = Type.of.disruption, y = Proportion, fill = Type.of.disruption)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10))+
  scale_x_discrete(guide = guide_axis(angle = 70)) +
  geom_boxplot()+
  facet_wrap(~ Group, nrow = 1)+
  theme_light() +
  theme(legend.position="none")+
  labs(y = "Proportion of Looking at AOIs", x = "AOI")

prop.plot


### Plot Number of Fixations
number.plot <- ggplot(et.raw.data, aes(x = Type.of.disruption, y = Number.of.fixations.in.AOI, fill = Type.of.disruption)) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 10))+
  scale_x_discrete(guide = guide_axis(angle = 70)) +
  geom_boxplot()+
  facet_wrap(~ Group, nrow = 1)+
  theme_light() +
  theme(legend.position="none")+
  labs(y = "Number of Fixations in AOI", x = "AOI")

number.plot

str(et.table)

### Plot Average duration of fixation
average.plot <- ggplot(et.table, aes(x = "Type of Disruption", y = "Mean Duration of Fixations", fill = "Type of Disruption")) +
  scale_x_discrete(guide = guide_axis(angle = 70)) +
  geom_bar(aes(y="Mean Duration of Fixations")) + 
  facet_wrap(~ Group)+
  theme_light() +
  theme(legend.position="none")+
  labs(y = "Average Duration of Looking at AOIs in sec", x = "AOI")

average.plot








