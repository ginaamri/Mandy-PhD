### ProVisioNET SRI Coding Data 

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
sri_novice <- read_excel("./data/coding_sri_novice.xlsx")

sri_expert <- read_excel("./data/coding_sri_expert.xlsx")


# filter relevant rows and select relevant columns 
sri_novice <- sri_novice %>% select(Group, Event, Disturbing_Factor, Confident_Factor)

sri_expert <- sri_expert %>% select(Group, Event, Disturbing_Factor, Confident_Factor)


# combine the two data frames with novice and expert
sri <- rbind(sri_expert, sri_novice)


# removing all NAs
sri_filter <- na.omit(sri)

# # replacing NA with 11
# sri[is.na(sri)] = 11

# # creating a new column --> event was "seen" / "not seen" 
# # WARNING! ifelse() needs three parameters: test, truth value, false value 
# sri$Seen <- ifelse(sri$Disturbing_Factor <= 10, 'seen', ifelse(sri$Disturbing_Factor > 11, 'not seen', 'not seen')) 


# define expert and novice with ifelse function
sri_filter$Group = ifelse(sri_filter$Group < 200, "Novice","Expert")

# create a new data frame with both factors
sri_disturb <- subset.data.frame(sri_filter, select = c(Group, Event, Disturbing_Factor))
sri_confi <- subset.data.frame(sri_filter, select = c(Group, Event, Confident_Factor))


# plotting disturbing factor
dist_plot <- 
  ggplot(data = sri_disturb,
         mapping = aes(x = Group,
                       y = Disturbing_Factor)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  ylim(0,10)+
  scale_fill_brewer(palette = "RdBu") +
  facet_wrap(vars(Event), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("How disturbing was the event for you?") +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank())
dist_plot


# plotting Confident factor
confi_plot <- 
  ggplot(data = sri_confi,
         mapping = aes(x = Group,
                       y = Confident_Factor)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  scale_fill_brewer(palette = "RdBu") +
  facet_wrap(vars(Event), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("How confident did you feel in dealing with this event?") +
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank())

confi_plot

# arranging plots 
grid.arrange(dist_plot, confi_plot, ncol=2, nrow =1)
