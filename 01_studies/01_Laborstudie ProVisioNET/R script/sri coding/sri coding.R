### ProVisioNET SRI Coding Data 

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
sri_novice <- read_excel("./data/coding_sri_novice.xlsx")

sri_expert <- read_excel("./data/coding_sri_expert.xlsx")


# filter relevant rows and select relevant columns 
sri_novice <- sri_novice %>% select(Group, Event, Disruption_Factor, Confident_Factor)

sri_expert <- sri_expert %>% select(Group, Event, Disruption_Factor, Confident_Factor)


# combine the two data frames with novice and expert
sri <- rbind(sri_expert, sri_novice)


# removing all NAs
sri_filter <- na.omit(sri)

# # replacing NA with 11
# sri[is.na(sri)] = 11

# # creating a new column --> event was "seen" / "not seen" 
# # WARNING! ifelse() needs three parameters: test, truth value, false value 
# sri$Seen <- ifelse(sri$Disruption_Factor <= 10, 'seen', ifelse(sri$Disruption_Factor > 11, 'not seen', 'not seen')) 


# define expert and novice with ifelse function
sri_filter$Group = ifelse(sri_filter$Group < 200, "Novice","Expert")

# create a new data frame with both factors
sri_disrup <- subset.data.frame(sri_filter, select = c(Group, Event, Disruption_Factor))
sri_confi <- subset.data.frame(sri_filter, select = c(Group, Event, Confident_Factor))


# plotting Disruption factor for groups
dist_group_plot <- 
  ggplot(data = sri_disrup,
         mapping = aes(x = Group,
                       y = Disruption_Factor)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1,
                                        height = 0)) +
  labs(x = "",
       y = "Disruption Factor") + 
  ylim(0,10)+
  scale_fill_brewer(palette = "Set1") +
  ggtitle("How disruptive was the event for you?") +
  theme_classic() + 
  theme(
    legend.position="none",
    axis.text.x = element_text(size = 15),
    plot.title = element_text(size = 19, face = "bold"),
    axis.text.y = element_text(size = 15),
    axis.title.y = element_text(size = 15))

dist_group_plot



# plotting Disruption factor for all disruptions
dist_plot <- 
  sri_disrup %>% 
  mutate(Event = factor(Event,
                      levels = c("chatting",
                                 "whispering",
                                 "heckling",
                                 "snipping",
                                 "drumming",
                                 "clicking",
                                 "looking at phone",
                                 "head on table",
                                 "drawing"
                      ),
                      labels = c("Chatting",
                                 "Whispering",
                                 "Heckling",
                                 "Snipping",
                                 "Drumming",
                                 "Clicking pen",
                                 "Looking at phone",
                                 "Head on table",
                                 "Drawing"
                      )
  )) %>%
  ggplot(data = sri_disrup,
         mapping = aes(x = Group,
                       y = Disruption_Factor)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1,
                                        height = 0)) +
  labs(x = "",
       y = "Disruption Factor") + 
  ylim(0,10)+
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(vars(Event), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("How disruptive was the event for you?") +
  theme_classic() + 
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        strip.text.x = element_text(size = 8, 
                                    angle = 90),
        plot.title = element_text(size = 15, face = "bold"))

dist_plot


# plotting Confident factor for group
confi_group_plot <- 
  ggplot(data = sri_confi,
         mapping = aes(x = Group,
                       y = Confident_Factor)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  labs(x = "", 
       y = "Confident Factor") +
  ylim(0,10) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.15, 
                                        height = 0)) +
  scale_fill_brewer(palette = "Set1") +
  ggtitle("How confident did you feel dealing with this event?") +
  theme_classic() +
  theme(axis.ticks.x = element_blank(),
        legend.position="none",
        axis.text.x = element_text(size = 11),
        plot.title = element_text(size = 15, face = "bold"))

confi_group_plot

# plotting confident factor for all disruptions
confi_plot <- 
  ggplot(data = sri_confi,
         mapping = aes(x = Group,
                       y = Confident_Factor)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1,
                                        height = 0)) +
  labs(x = "",
       y = "Confident Factor") + 
  ylim(0,10)+
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(vars(Event), 
             nrow = 1, strip.position = "bottom") +
  ggtitle("How confident did you feel dealing with this event?") +
  theme_classic() + 
  theme(axis.ticks.x = element_blank(),
        axis.text.x = element_blank(),
        strip.text.x = element_text(size = 8, 
                                    angle = 80),
        plot.title = element_text(size = 15, face = "bold"))

confi_plot

# # arranging plots 
# grid.arrange(dist_plot, confi_plot, ncol=2, nrow =1)



#################### MEAN, SD, N ############

# mean disrup_factor
sri_disrup_mean <- sri_disrup %>%
  group_by(Group) %>%
  summarise("M" = round(mean(Disruption_Factor), 2),
            "SD" = round(sd(Disruption_Factor), 2))

# mean ttfr 
sri_confi_mean <- sri_confi %>%
  group_by(Group) %>%
  summarise("M" = round(mean(Confident_Factor), 2),
            "SD" = round(sd(Confident_Factor), 2))


