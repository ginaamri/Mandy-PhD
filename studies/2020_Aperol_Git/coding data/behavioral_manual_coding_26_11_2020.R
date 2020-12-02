### PLOTTING MANUAL CODING DATA APEROL
# Mandy Klatt
# November, 2020

##########################################################################
### Load Libraries / install packages
##########################################################################

## http://www.eyetracking-r.com/

# # 
# install.packages("tidyverse")
# install.packages("lemon")
# install.packages("dplyr")
# install.packages("chron")
# install.packages("psych")
# install.packages("matrixStats")

library(tidyverse) # contains ggplot2, dplyr...and all the other good things
library(lemon) # necessary for arranging multiple plots next to each other
library(chron) # work with time
library(psych)
library(ggplot2)
library(dplyr)
library(matrixStats)

### read in data 
data_raw <- read.delim("manual_coding_withseconds.txt", header = TRUE, sep = "\t", dec=",")

View(data_raw)
str(data_raw)

### checking for missing values
is.na(data_raw)

# knock out NAs
data_raw <- data_raw  %>% filter(
  shortID != "NA")

View(data_raw)

# drop irrelevant columns with subset()
data_raw <- subset(data_raw, select = -c(X))

View(data_raw)


# filter relevant columns 
data_raw <- data_raw  %>% select(
                          condition,
                          shortID,
                          disturbance.executed,
                          type.of.disturbance,
                          duration.disturbance.seconds,
                          disturbance.seen,
                          disturbance.seen.seconds,
                          duration.onset.seen.seconds,
                          reacted..0.1.2.3.4.,
                          reaction01,
                          duration.reaction01.seconds,
                          reaction02,
                          duration.reaction02.seconds,
                          reaction03,
                          duration.reaction03.seconds,
                          duration.reaction.seconds,
                          duration.seen.reaction.seconds,
                          duration.video.seconds
                          )

View(data_raw)                         


# changing numeric to factor
# Variablen nur als kategoriale Var einsetzen, wenn sie auch kategorial sind

class(data_raw$disturbance.seen) ## der Dateityp "integer" ist für ganze Zahlen --> deswegen character

# disturbances into "seen" and "not seen"
data_raw$disturbance.seen2 <- as.character(data_raw$disturbance.seen,
                                           levels = c(0, 1), 
                                           labels = c("not seen", "seen"))
View(data_raw)

# condition into "Expert" and "Novice"
data_raw$condition2 <- factor(data_raw$condition,
                              levels = c(1, 2),
                              labels = c("Expert", "Novice"))

View(data_raw)

###### How many disturbances were visibly recognized (frequency and proportion)?
##########################################################################

### absolute frequency of seen disturbances

# plotting absolute frequency of seen disturbances (nonsense)
plot_total_disturbance <- ggplot(data_raw, aes(fill = disturbance.seen2, x = disturbance.seen2)) + 
                                geom_bar(aes(y = (..count..)))+
                                ylim(0, 50)+
                                theme_minimal()+                              
                                theme(axis.text.x=element_blank(),
                                      axis.ticks.x=element_blank())+                                
                                geom_text(stat='count', aes(label=..count..), vjust=-0.5, color="black", size=3.5)+
                                ggtitle("Absolute frequency of visibly recognized disturbances")+
                                labs(y = "counts", x = "disturbances")+
                                facet_grid(~condition2)+
                                scale_fill_discrete(name="disturbances",
                                                    breaks=c("0", "1"),
                                                    labels=c("not seen", "seen"))
                                
plot_total_disturbance                                



# table with the frequencies to check how many disturbances were seen 
table(data_raw$disturbance.seen2)


### counting the relative frequency of seen disturbances: proportions
table(data_raw$disturbance.seen2)/length(data_raw$disturbance.seen2)

# rounding the result to be more useful
proportion_disturbance <- round(table(data_raw$disturbance.seen2)/length(data_raw$disturbance.seen2),2)

view(proportion_disturbance)


proportion_disturbance <- data_raw %>% 
                                  group_by(condition2, disturbance.seen2) %>%
                                  summarise(n = n()) %>%
                                  mutate(freq = n / sum(n))

view(proportion_disturbance)

str(proportion_disturbance$freq)


### GREGOR ANFANG
### calculating mean, sd, se for plotting errorbars


# first try
# proportion_disturbance <- ddply(proportion_disturbance, c("disturbance.seen2", "condition2"), summarise,
#                                        N    = length(freq),
#                                        mean = mean(freq),
#                                        sd   = sd(freq),
#                                        se   = sd / sqrt(N)
#                         )
# 
# view(proportion_disturbance)



# second try
### package Rmisc need to be installed
# # summarySE provides the standard deviation, standard error of the mean, and a (default 95%) confidence interval
# proportion_disturbance <- summarySE(proportion_disturbance, measurevar="freq",
#                                       groupvars=c("condition2", "disturbance.seen2"),
#                                       .drop=FALSE)
# 
# view(proportion_disturbance)



# # third try
# proportion_disturbance <- summaryBy(freq ~ condition2 + disturbance.seen2,
#                                       data=data,
#                                       FUN=c(freq,mean,sd))
# 
# view(proportion_disturbance)



# fourth try
# proportion_disturbance = rowSds(as.matrix(proportion_disturbance[,c(4)]))
# 
# View(proportion_disturbance)


# # fifths try
# proportion_SD_disturbance <- proportion_disturbance %>% 
#                                   group_by(condition2, disturbance.seen2) %>%
#                                   summarise( sd_prop = sd(freq),
#                                              n_prop = n(),
#                                              SE_prop = sd(freq)/sqrt(n()))
# 
# view(proportion_SD_disturbance)



### GREGOR ENDE




############################## PROPORTION ############################################
#plot1
### plotting proportion of seen disturbances, facet grid ~ condition
plot_relative_disturbance <-  ggplot(proportion_disturbance, aes(x = disturbance.seen2, fill=disturbance.seen2)) +
                                      geom_bar(aes(y=freq), stat='identity') +
                                      scale_y_continuous(labels=scales::percent) +
                                      ggtitle("Percentage of visibly recognized disturbances")+
                                      labs(y = "percentage", x = "disturbances") +
                                      facet_grid(~condition2)+
                                      theme_minimal()+
                                      geom_text(aes(label = scales::percent(freq), y= (freq), stat="count"), 
                                                    vjust = -0.1, size = 3)+
                                      scale_fill_discrete(name="disturbances",
                                                          breaks=c("0", "1"),
                                                          labels=c("not seen", "seen"))

plot_relative_disturbance

#plot2 
###  plotting proportion of seen disturbances, facet grid ~ disturbance seen
plot_relative_disturbance <-  ggplot(proportion_disturbance, aes(x = condition2, fill=condition2)) +
                                      geom_bar(aes(y=freq), stat='identity') +
                                      scale_y_continuous(labels=scales::percent) +
                                      ggtitle("Percentage of visibly recognized disturbances")+
                                      labs(y = "percentage", x = "disturbances") +
                                      facet_grid(~disturbance.seen2)+
                                      facet_wrap(~disturbance.seen2, strip.position = "bottom")+
                                      guides(fill=guide_legend(title=NULL))+
                                      theme_minimal()+
                                      geom_text(aes(label = scales::percent(freq), y= (freq), stat="count"), 
                                                vjust = -0.1, size = 4)+
                                      scale_x_discrete(name="disturbances",
                                                       breaks=c("0", "1"),
                                                       labels=c("not seen", "seen"))
                                    

plot_relative_disturbance

##########################################################################



###### How long did the disturbances last in average?
##########################################################################

# filter only disturbance that were seen
disturbance_seen <- data_raw  %>% filter(
                                    disturbance.seen == "1")

view(disturbance_seen)


# calculating mean by group (condition)
data_mean <- aggregate(x = disturbance_seen$duration.disturbance.seconds,             # Specify data column
                       by = list(disturbance_seen$condition2),             # Specify group indicator
                       FUN = mean)                                # Specify function (i.e. mean)


# rename column group1 to condition and x to mean
data_mean <- data_mean %>% rename(condition = Group.1, mean_seconds = x)

view(data_mean)


# round only numeric columns
data_mean <- data_mean %>% mutate_if(is.numeric, ~round(., 0))

view(data_mean)


# # creating new variable mean_minutes
# data_mean <- data_mean %>% select (condition, mean_seconds) %>% 
#                            mutate (mean_minutes = round((mean_seconds/60), 1), condition)




# plotting percentage of seen disturbances per experimental group
plot_duration_mean <- ggplot(data_mean, aes(x = condition, fill = condition, y = mean_seconds))+
                        geom_bar(aes(y = mean_seconds), stat= "identity")+
                        guides(fill=FALSE)+
                        ggtitle("Average duration of disturbance")+
                        labs(y = "mean duration in seconds", x = "experimental group")+
                        geom_text(aes(label = (mean_seconds), y= (mean_seconds), stat="identity"), 
                                  vjust = 5, size = 6)+
                        theme_minimal(base_size=20)

plot_duration_mean

##########################################################################



###### How long did it take for disturbances to be seen?
##########################################################################

# filter only disturbance that were seen
disturbance_seen <- data_raw  %>% filter(
                                    disturbance.seen == "1")

view(disturbance_seen)

# calculating mean by group (condition)
data_mean <- aggregate(x = disturbance_seen$duration.onset.seen.seconds,             # Specify data column
                       by = list(disturbance_seen$condition2),             # Specify group indicator
                       FUN = mean)                                # Specify function (i.e. mean)


# rename column group1 to condition and x to mean
data_mean <- data_mean %>% rename(condition = Group.1, mean_seconds = x)

view(data_mean)


# round only numeric columns
data_mean <- data_mean %>% mutate_if(is.numeric, ~round(., 0))

view(data_mean)


# plotting percentage of seen disturbances per experimental group
plot_duration_mean <- ggplot(data_mean, aes(x = condition, fill = condition, y = mean_seconds))+
                              geom_bar(aes(y = mean_seconds), stat= "identity")+
                              guides(fill=FALSE)+
                              ylim(0,15)+                            
                              ggtitle("Average duration of disturbance perception")+
                              labs(y = "mean duration in seconds", x = "experimental group")+
                              geom_text(aes(label = (mean_seconds), y= (mean_seconds), stat="identity"), 
                                        vjust = 5, size = 6)+
                              theme_minimal(base_size=20)
  
plot_duration_mean

##########################################################################






###### How long did the reactions last in average?
##########################################################################

view(data_raw)

# filter only disturbance that were seen
disturbance_seen <- data_raw  %>% filter(
  disturbance.seen == "1")

view(disturbance_seen)

# calculating mean by group (condition)
data_mean <- aggregate(x = disturbance_seen$duration.reaction.seconds,             # Specify data column
                       by = list(disturbance_seen$condition2),             # Specify group indicator
                       FUN = mean)                                # Specify function (i.e. mean)


# rename column group1 to condition and x to mean
data_mean <- data_mean %>% rename(condition = Group.1, mean_seconds = x)

view(data_mean)


# round only numeric columns
data_mean <- data_mean %>% mutate_if(is.numeric, ~round(., 0))

view(data_mean)


# # creating new variable mean_minutes
# data_mean <- data_mean %>% select (condition, mean_seconds) %>% 
#                            mutate (mean_minutes = round((mean_seconds/60), 1), condition)




# plotting percentage of seen disturbances per experimental group
plot_duration_reaction_mean <- ggplot(data_mean, aes(x = condition, fill = condition, y = mean_seconds))+
                                  geom_bar(aes(y = mean_seconds), stat= "identity")+
                                  guides(fill=FALSE)+
                                  ylim(0,15)+                            
                                  ggtitle("Average duration of reaction")+
                                  labs(y = "mean duration in seconds", x = "experimental group")+
                                  geom_text(aes(label = (mean_seconds), y= (mean_seconds), stat="identity"), 
                                            vjust = 5, size = 6)+
                                  theme_minimal(base_size=20)

plot_duration_reaction_mean

##########################################################################



###### How long did it take from the onset disturbance to the reaction?
##########################################################################

view(data_raw)

# filter only disturbance that were seen
disturbance_seen <- data_raw  %>% filter(
  disturbance.seen == "1")

view(disturbance_seen)

# calculating mean by group (condition)
data_mean <- aggregate(x = disturbance_seen$duration.seen.reaction.seconds,             # Specify data column
                       by = list(disturbance_seen$condition2),             # Specify group indicator
                       FUN = mean)                                # Specify function (i.e. mean)


# rename column group1 to condition and x to mean
data_mean <- data_mean %>% rename(condition = Group.1, mean_seconds = x)

view(data_mean)


# round only numeric columns
data_mean <- data_mean %>% mutate_if(is.numeric, ~round(., 0))

view(data_mean)


# # creating new variable mean_minutes
# data_mean <- data_mean %>% select (condition, mean_seconds) %>% 
#                            mutate (mean_minutes = round((mean_seconds/60), 1), condition)




# plotting percentage of seen disturbances per experimental group
plot_duration_reaction_mean <- ggplot(data_mean, aes(x = condition, fill = condition, y = mean_seconds))+
  geom_bar(aes(y = mean_seconds), stat= "identity")+
  guides(fill=FALSE)+
  ylim(0,15)+                            
  ggtitle("Average duration from onset of disturbance to reaction")+
  labs(y = "mean duration in seconds", x = "experimental group")+
  geom_text(aes(label = (mean_seconds), y= (mean_seconds), stat="identity"), 
            vjust = 5, size = 6)+
  theme_minimal(base_size=20)

plot_duration_reaction_mean

##########################################################################


### GREGOR ANFANG

###### What was the most frequent reaction?
# plot with all reactions and the frequency
# create two categories "verbal reaction"/"non-verbal reaction"
## all reactions from 100-106 = verbal reaction, reactions from 200-202 = non-verbal reactions
##########################################################################

# filter only disturbance that were seen
data_react <- data_raw  %>% filter(
              disturbance.seen == "1")

view(data_react)



# select relevant columns 
data_react <- data_react  %>% select(
                                condition,
                                reaction01,
                                reaction02,
                                reaction03)

View(data_react)                         


# filter only reactions
data_react <- data_react  %>% filter(
  reaction01 != "0",
  reaction02 != "0",
  reaction03 != "0")

view(data_react)

class(data_react$reaction01)

########################################################################
### creating new datasets with number of reactions

dr1 <- data_react %>% 
  group_by(reaction01) %>%
  dplyr::summarise(n=n())

view(dr1)

dr2 <- data_react %>% 
  group_by(reaction02) %>%
  dplyr::summarise(n=n())

view(dr2)

dr3 <- data_react %>% 
  group_by(reaction03) %>%
  dplyr::summarise(n=n())

view(dr3)

##########################################################################
# rbind() 
data_react <- as.data.frame(
            rbind(
                    reaction01 = c(200, 103, 103, 103, 202, 201, 201, 100, 103, 202, 202, 202, 103, 103),
                    reaction02 = c(103, 105, 100, 100, 100, 103, 100, 103, 100, 105, 103, 103, 105, 100),
                    reaction03 = c(105, 200, 104, 106, 104, 105, 103, 105, 201, 200, 100, 105, 104, 105)
                  ))

view(data_react)

##########################################################################
data_react %>%
  # NOTE: name of id variable should not start with "v" or "V"
  # Otherwise the select will not work.
  rownames_to_column(var = "reaction") %>% 
  mutate(count = rowSums(select(., starts_with("V")), na.rm = TRUE)) %>% 
  select(reaction, count) %>% 
  ggplot(aes(reaction, count, fill = reaction)) +
  geom_col() +
  guides(fill = FALSE)


##########################################################################
# changing numeric to factor
# Variablen nur als kategoriale Var einsetzen, wenn sie auch kategorial sind

# reaction01 
data_react$reaction_01.1 <- as.character(data_react$reaction01,
                                           levels = c(200, 103, 202, 201, 100), 
                                           labels = c ("gesture", 
                                                      "disturbing person is addressed directly (by name)",
                                                      "moving towards disturbing person",
                                                      "gaze",
                                                      "asking a question"))
                                                
View(data_react)


# reaction02
data_react$reaction02.2 <- as.character(data_react$reaction02,
                                  levels = c(103, 105, 100),
                                  labels = c("disturbing person is addressed directly (by name)",
                                             "asking to stop the disturbance",
                                             "asking a question"))

View(data_react)


# reaction03
data_react$reaction03.3 <- as.character(data_react$reaction03,
                                  levels = c(105, 200, 104, 106, 103, 201, 100),
                                  labels = c("asking to stop the disturbance",
                                             "gesture",
                                             "involving the disturbung person in lesson",
                                              "meta-reflection",
                                              "disturbing person is addressed directly (by name)",
                                              "gaze",
                                              "asking a question"))


View(data_react)
str(data_react)


# condition "Expert" and "Novice"
data_react$condition <- as.character(data_react$condition,
                              levels = c(1, 2),
                              labels = c("Expert", "Novice"))

View(data_react)



#creating new dataframe with reactions as character
dr <- data.frame(data_react$reaction03.3, data_react$reaction02.2, data_react$reaction_01.1)
view(dr) 

# stack data
dr <- stack(dr)
view(dr)
# 
# compute  unique elements using unique()
uni <- unique(dr[, "values"])
view(uni)
# 
# # get it a new ID
# new_id <- as.numeric(as.factor(sort(uni)))


newdf <- data.frame(react = sort(uni), new_id = seq_along(uni))

dr <- merge(dr, newdf, by.x = "values", by.y = "react")
view(dr)


# possible values of "values"
dr <- factor(dr$new_id.x)
str(dr)

w = table(dr["new_id.x"])
w 


t = as.data.frame(w)
t


### GREGOR ENDE




