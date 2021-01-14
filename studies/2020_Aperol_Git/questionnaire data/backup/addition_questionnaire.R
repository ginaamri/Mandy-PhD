### Plotting questionnaire data

```{r plot classroom management boxplot by groups, echo = FALSE}

### classroom management

# filter by parameter variable, i.e. create a subset for each group (expert/novice/experimenter)
km.data <- raw.data %>% filter(item == "Klassenmanagement")

view (raw.data)

# value sometimes contained text before filtering, we have to convert the numbers to numeric
km.data <- km.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# create  mean, min, max, sd of classroom management
meankm <- mean(km.data$value)
minkm <- min(km.data$value)
maxkm <- max(km.data$value)
sdkm <- sd(km.data$value)
Nkm<-length(unique(km.data$ID))


# # filter by parametervariable, i.e. create a subset for the individual lecturer
# ind.km.data <- km.data %>% filter(Dozierende == params$Dozierende)
# # erstelle Mittelwert, min, max, sd for individual lecturer
# ind.meankm <- mean(ind.km.data$value)
# ind.minkm <- min(ind.km.data$value)
# ind.maxkm <- max(ind.km.data$value)
# ind.sdkm <- sd(ind.km.data$value)
# ind.Nkm<-length(unique(ind.km.data$ID))
```
The mean of the item "classroom management" is `r round(meankm, 2)` (min = `r minkm`; max = `r maxkm`; SD = `r round(sdkm,2)`; N = `r Nkm)`; lickert-scale 1-4; 4 = best rating). 

```{r classroom management horicontal Plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}
# filter by parametervariable, i.e. create a subset for the individual lecturer
km.data <- raw.data %>% filter(item == "Klassenmanagement")

# value sometimes contained text before filtering, we have to convert the numbers to numeric
km.data <- km.data %>%  mutate(value = as.numeric(as.character(factor(value))))

view(km.data)
# to stick to the individual vs all style necessary for anonymized feedback in plotting
# we create a new vector from experiece that we call "expert" and copy the names
# of the name called by the parameter but rename all others to "all"
# now the "fill ="option can use the new column to differentiate all vs parameter dozent

km.plot.data <- km.data %>%
  mutate(Teilnehmende = ifelse(Dozierende == params$Dozierende, toString(params$Dozierende), "Alle Kurse"))
modul.plot.data$Teilnehmende <- as.factor(modul.plot.data$Teilnehmende)

# to create error bars, we need to summarise the data in a seperate dataframe
modul.plot.sd <-modul.plot.data %>% 
  group_by(itemfulltext, Teilnehmende, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot 
modul.plot<-ggplot(data = modul.plot.sd, 
                   aes(x = itemfulltext, y = mean, 
                       group=Teilnehmende, colour = Teilnehmende)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,5)+
  labs(data = modul.plot.data, y = "Ausprägung", x = NULL,
       title="Modulbewertung" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
modul.plot

```
```{r plot linegraph performance across trials, echo=FALSE}

trial.data <- raw.data %>% 
  filter(what == "data" & valid == "1" & trialtype == "test") %>% 
  mutate(correct = as.integer(correct),
         valid = as.integer(valid),
         trial = as.integer(trial))%>% 
  select(age, condition, trial, correct) %>%
  group_by(age, condition, trial) %>%
  summarise(correct = round(mean(correct)*100, 2))  

trial.plot <- ggplot(trial.data, aes(x = trial, y=correct, colour=condition, linetype=condition))+
  geom_line()+
  geom_point()+
  scale_x_continuous(breaks=trial.data$trial)+
  scale_y_continuous(breaks = scales::pretty_breaks(n = 5), limits = c(0,100))+
  labs(x="Trials", y="Proportion Correct")+ # to add a title --> title="Performance across test trials", 
  theme_classic() +
  facet_grid(age ~ .)
trial.plot

```

### Performance by items
In each trial, children were presented with a target and distractor shape as well as a cue matching the target shape. The counterbalancing ensures that all shapes occur both as target and distractor. Presentation in trials is counterbalanced. The graph below shows children's individual performance aggregated for all target shapes. More incorrect choices for a specific target could indicate that a cue is ambiguous. 

```{r plot performance across items, echo=FALSE, warning=FALSE}

target.ind.data <- raw.data %>%
  filter(what == "data" & valid == "1" & trialtype == "test") %>%
  select(id, age, condition, tar, correct)  %>%
  mutate(correct = as.integer(correct),
         age = as.factor(age),
         condition = as.factor(condition),
         target = as.factor(tar),
         groups = paste(age,"-",condition)) %>%
  group_by(target,age, id) %>%
  summarise(proportion.correct = round(mean(correct)*100, 2))

target.boxplot <-ggplot() +
  geom_boxplot(data = target.ind.data, aes(x = target, y = proportion.correct),outlier.shape = NA)+ # when there is more data add "notch = TRUE" for conf intervalls
  geom_jitter(data = target.ind.data, aes(x = target, y = proportion.correct, colour=target), size = 2, width = 0.3) +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 5), limits = c(0,110))+
  labs(x="Target Shapes", y="Proportion Correct")+ # for title add --> title="Proportion of Correct Choices", 
  theme_classic()+
  facet_grid(age ~ .)
   # geom_violin(data = test.raw.data, trim = TRUE , adjust = .7, draw_quantiles = c(0.5), mapping = aes(x=groups, y = correct))
target.boxplot

```

In addition, the plot below shows individual performance across all distractor shapes. More incorrect choices for a specific distractor might indicate that children prefer to select that distractor over any target.

```{r plot performance across distractor items, echo=FALSE, warning=FALSE}

distractor.ind.data <- raw.data %>%
  filter(what == "data" & valid == "1" & trialtype == "test") %>%
  select(id, age, condition, dis, correct)  %>%
  mutate(correct = as.integer(correct),
         age = as.factor(age),
         condition = as.factor(condition),
         distractor = as.factor(dis),
         groups = paste(age,"-",condition)) %>%
  group_by(distractor,age, id) %>%
  summarise(proportion.correct = round(mean(correct)*100, 2))

distractor.boxplot <-ggplot() +
  geom_boxplot(data = distractor.ind.data, aes(x = distractor, y = proportion.correct),outlier.shape = NA)+ # when there is more data add "notch = TRUE" for conf intervalls
  geom_jitter(data = distractor.ind.data, aes(x = distractor, y = proportion.correct, colour=distractor), size = 2, width = 0.3) +
    scale_y_continuous(breaks = scales::pretty_breaks(n = 5), limits = c(0,110))+
  labs(x="Distractor Shapes", y="Proportion Correct")+ # for title add --> title="Proportion of Correct Choices", 
  theme_classic()+
  facet_grid(age ~ .)
   # geom_violin(data = test.raw.data, trim = TRUE , adjust = .7, draw_quantiles = c(0.5), mapping = aes(x=groups, y = correct))
distractor.boxplot

```


### Testing individual performance against chance
For each individual, we used a binomial test to investigate whether their performance was significantly above chance level (p < 0.05; 50%). The table provides the number and proportion of individuals performing above chance for age experimental group.

```{r table individual performance against chance, echo=FALSE}

ind.binom.data <- raw.data %>%
    filter(what == "data" & valid == "1" & trialtype == "test") %>% 
    select(condition, age, id, correct) %>% 
    mutate(correct = as.integer(correct))%>% 
    group_by(condition, age, id) %>%
    summarise("% correct" = round(mean(correct)*100, 2),
              "sum correct" = sum(correct),
              "sum trials" = length(correct),
              "p" = round(binom.test(sum(correct), length(correct), 
                               p = 0.5, alternative = "greater")$p.value, 3),
              "sig" = if_else(p < 0.05, 1, 0)
              )

sum.binom.data <- ind.binom.data %>%
    group_by(age, condition) %>%
    summarise(N = n_distinct(id),
            "succesfull"  = sum(sig))

sum.binom.data %>%
  mutate("% successful" = (succesfull/N)*100)%>% 
  knitr::kable(digits = 2)

```

### Testing group performance against chance
To test whether each children in both age-group and condition performed above chance on a group level, we used Wilcoxon / Mann-Whitney-U tests. 

xxx To Do xxx

```{r plot performance against chance, echo=FALSE}

# Alternative using one-sample t-tests from emopoint
# this is not working yet as the participants in 4<o comm are all 100% correct
# raw.data %>%
#   filter(what == "data" & valid == "1" & trialtype == "test") %>% 
#   mutate(correct = as.integer(correct)) %>%
#   group_by(condition, age, id) %>%
#   arrange(condition, age) %>%
#   summarise(correct = mean(correct)) %>%
#   summarise(correct = list(correct)) %>%
#   group_by(condition, age) %>%
#   mutate(m = mean(unlist(correct)),
#          sd = sd(unlist(correct)),
#          df= t.test(unlist(correct), mu = 0.5)$parameter,
#          t_value = t.test(unlist(correct), mu = 0.5)$statistic,
#          p = t.test(unlist(correct), mu = 0.5)$p.value,
#          d = cohensD(unlist(correct), mu = 0.5))%>%
#   select(condition,age, m,sd,t_value,p,d) %>% #add df
#   knitr::kable(digits = 2)

```
