### ProVisioNET SRI Coding Data 

library(needs)
needs(tidyverse,
      ggplot,
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
sri_novice <- read_excel("./data/coding_sri_novice.xlsx")

sri_expert <- read_excel("./data/coding_sri_expert.xlsx")


# filter relevant rows and select relevant columns 
sri_novice <- sri_novice %>% select(group, event, disturbing_factor, safety_factor)

sri_expert <- sri_expert %>% select(group, event, disturbing_factor, safety_factor)


# combine the two data frames
sri <- rbind(sri_expert, sri_novice)

# create a new data frame
sri_disturb <- subset.data.frame(sri, select = c(group, event, disturbing_factor))

sri_safe <- subset.data.frame(sri, select = c(group, event, safety_factor))

# define expert and novice with ifelse function
sri_disturb$group = ifelse(sri_disturb$group < 200, "Novice","Expert")

sri_safe$group = ifelse(sri_safe$group < 200, "Novice","Expert")


# plotting disturbing factor
dist_plot <- 
  ggplot(data = sri_disturb,
         mapping = aes(x = group,
                       y = "safety_factor")) +
  geom_boxplot(mapping = aes(fill = group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  scale_fill_brewer(palette = "RdBu") +
  facet_wrap(vars(event), 
             nrow = 1) +
  theme_blank()

dist_plot


# plotting safety factor
safe_plot <- 
  ggplot(data = sri_long,
         mapping = aes(x = event,
                       y = "Value")) +
  geom_boxplot(mapping = aes(fill = group)) +
  geom_point(size = 2, 
             alpha = 0.4,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  scale_fill_brewer(palette = "RdBu") +
  facet_wrap(vars(event), 
             nrow = 1) +
  theme_blank()

safe_plot
