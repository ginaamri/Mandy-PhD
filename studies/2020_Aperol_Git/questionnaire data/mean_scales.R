#### Session 1 

#### classroom management

```{r mean classroom management by session, echo = FALSE}

### classroom management session 1 

# filter by parameter variable, i.e. create a subset for each session
km1.data <- raw.data %>% filter(scale == "Klassenmanagement",
                                session == "1")

view (km1.data)

# value sometimes contained text before filtering, we have to convert the numbers to numeric
km1.data <- km1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***classroom management*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

``` {r classroom management data table, echo=FALSE}

km1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```

```{r classroom management line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
km1.plot.sd <- km1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
km1.plot<-ggplot(data = km1.plot.sd,
                 aes(x = perspective, y = mean,
                     group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = km1.data, y = "value", x = NULL,
       title="classroom management" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
km1.plot

```


#### positive climate and motivation

```{r mean positive climate and motivation by session, echo = FALSE}

### positive climate and motivation session 1 

# filter by parameter variable, i.e. create a subset for each session
lkm1.data <- raw.data %>% filter(scale == "Lernförderliches Klima und Motivierung",
                                 session == "1")

view (lkm1.data)

# value sometimes contained text before filtering, we have to convert the numbers to numeric
lkm1.data <- lkm1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***positive climate and motivation*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r positive climate and motivation data table, echo=FALSE}

lkm1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r positive climate and motivation line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
lkm1.plot.sd <- lkm1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
lkm1.plot<-ggplot(data = lkm1.plot.sd,
                  aes(x = perspective, y = mean,
                      group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = lkm1.data, y = "value", x = NULL,
       title="positive climate and motivation" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
lkm1.plot
```

XXX Order lieber Boxplots? Da würde ich gern noch die Mittelwerte mit einer Linie verbinden. XXX

```{r plot boxplot by groups, echo = FALSE}
lkm1.boxplot <- ggplot() +
  geom_boxplot(data = lkm1.plot.sd, 
               aes(x = perspective, y = mean), )+ 
  geom_line(data = lkm1.plot.sd, mapping = aes(x = perspective, y = mean)) + 
  geom_jitter(data = lkm1.plot.sd, aes(x = perspective, y = mean, colour = target), size = 2, width = 0.1) +
  scale_y_continuous(breaks = scales::pretty_breaks(n = 5), limits = c(0,4))+
  labs(x="perspective", y="value", title = "positive climate and motivation")+ 
  theme_classic()
lkm1.boxplot

```

#### clarity and structuredness

```{r mean clarity and structuredness by session, echo = FALSE}

### clarity and structuredness session 1 

# filter by parameter variable, i.e. create a subset for each session
ks1.data <- raw.data %>% filter(scale == "Klarheit und Strukturiertheit",
                                session == "1")

view (ks1.data)

# value sometimes contained text before filtering, we have to convert the numbers to numeric
ks1.data <- ks1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***clarity and structuredness*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r clarity and structuredness data table, echo=FALSE}

ks1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r clarity and structuredness line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
ks1.plot.sd <- ks1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
ks1.plot<-ggplot(data = ks1.plot.sd,
                 aes(x = perspective, y = mean,
                     group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = ks1.data, y = "value", x = NULL,
       title="clarity and structuredness" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
ks1.plot
```


#### activation and support

```{r mean activation and support by session, echo = FALSE}

### activation and support session 1 

# filter by parameter variable, i.e. create a subset for each session
af1.data <- raw.data %>% filter(scale == "Aktivierung und Förderung",
                                session == "1")

view (af1.data)

# value sometimes contained text before filtering, we have to convert the numbers to numeric
af1.data <- af1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***activation and support*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r activation and support data table, echo=FALSE}

af1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r activation and support line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
af1.plot.sd <- af1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
af1.plot<-ggplot(data = af1.plot.sd,
                 aes(x = perspective, y = mean,
                     group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = af1.data, y = "value", x = NULL,
       title="activation and support" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
af1.plot
```


#### presence: posture and gaze

```{r mean presence: posture and gaze by session, echo = FALSE}

### presence: posture and gaze session 1 

# filter by parameter variable, i.e. create a subset for each session
phb1.data <- raw.data %>% filter(scale == "Präsenz/Haltung_Blick",
                                 session == "1")

view (phb1.data)

# value sometimes contained text before filtering, we have to convert the numbers to numeric
phb1.data <- phb1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***presence: posture and gaze*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r presence: posture and gaze data table, echo=FALSE}

phb1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r presence: posture and gaze line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
phb1.plot.sd <- phb1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
phb1.plot<-ggplot(data = phb1.plot.sd,
                  aes(x = perspective, y = mean,
                      group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = phb1.data, y = "value", x = NULL,
       title="presence: posture and gaze" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
phb1.plot

```


#### presence: voice
XXX aus unerklärlichen Gründen wird mir "No data available in table" angezeigt, wenn ich versuche, Präsenz/Stimme für Session1 zu filtern. Hab den Fehler leider noch nicht gefunden... XXX
```{r mean presence: voice by session, echo = FALSE}

### presence: voice session 1 

# filter by parameter variable, i.e. create a subset for each session
ps1.data <- raw.data %>% filter(scale == "Präsenz/Stimme",
                                session == "1")

# value sometimes contained text before filtering, we have to convert the numbers to numeric
ps1.data <- ps1.data %>%  mutate(value = as.numeric(as.character(factor(value))))

# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***presence: voice*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX



``` {r presence: voice data table, echo=FALSE}
# 
# ps1.data %>% # select data
#   group_by(target,perspective) %>%
#   summarise(N = n_distinct(personID),
#             "mean" = round(mean(value), 2),
#             "min" = min(value),
#             "max" = max(value),
#             "sd" = sd(value),
#             "median" = median(value)
#             ) %>% 
#   knitr::kable(digits = 2)

```

```{r presence: voice line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# # to create error bars, we need to summarize the data in a separate data frame
# ps1.plot.sd <- ps1.data %>%
#   group_by(perspective, target, .drop=TRUE) %>%
#   summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )
# 
# # and here comes the long plot
# ps1.plot<-ggplot(data = ps1.plot.sd,
#                    aes(x = perspective, y = mean,
#                        group = target, colour = target)) +
#   geom_line()+
#   geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
#   theme_light() +
#   ylim(1,4)+
#   labs(data = ps1.data, y = "value", x = NULL,
#        title="presence: voice" ,
#        subtitle=NULL)+
#   theme(legend.position="bottom",
#         panel.spacing.x = ,
#         plot.title = element_text(hjust = 0.5))+
#   scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
#   coord_flip()
# ps1.plot

```




#### presence: verbal and non-verbal intervention

```{r mean presence: verbal and non-verbal intervention by session, echo = FALSE}

### presence: verbal and non-verbal intervention session 1 

# filter by parameter variable, i.e. create a subset for each session
pi1.data <- raw.data %>% filter(scale == "Präsenz/verbale_nonberbale Intervention",
                                session == "1")

# value sometimes contained text before filtering, we have to convert the numbers to numeric
pi1.data <- pi1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***presence: verbal and non-verbal intervention*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r presence: verbal and non-verbal intervention data table, echo=FALSE}

pi1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r presence: verbal and non-verbal intervention line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
pi1.plot.sd <- pi1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
pi1.plot<-ggplot(data = pi1.plot.sd,
                 aes(x = perspective, y = mean,
                     group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = pi1.data, y = "value", x = NULL,
       title="presence: verbal and non-verbal intervention" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
pi1.plot

```

#### turn taking

```{r mean turn taking by session, echo = FALSE}

### turn taking session 1 

# filter by parameter variable, i.e. create a subset for each session
redeanteil1.data <- raw.data %>% filter(scale == "Redeanteil",
                                        session == "1")

# value sometimes contained text before filtering, we have to convert the numbers to numeric
redeanteil1.data <- redeanteil1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***turn taking*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r turn taking data table, echo=FALSE}

redeanteil1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r turn taking line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
redeanteil1.plot.sd <- redeanteil1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
redeanteil1.plot<-ggplot(data = redeanteil1.plot.sd,
                         aes(x = perspective, y = mean,
                             group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1, 100)+
  labs(data = redeanteil1.data, y = "value", x = NULL,
       title="turn taking" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
redeanteil1.plot

```


#### natural behaviour

```{r mean natural behaviour by session, echo = FALSE}

### natural behaviour session 1 

# filter by parameter variable, i.e. create a subset for each session
m1.data <- raw.data %>% filter(scale == "Manipulationsitem",
                               session == "1")


# value sometimes contained text before filtering, we have to convert the numbers to numeric
m1.data <- m1.data %>%  mutate(value = as.numeric(as.character(factor(value))))


# # create  mean, min, max, sd of classroom management
# meankm1 <- mean(km1.data$value)
# minkm1 <- min(km1.data$value)
# maxkm1 <- max(km1.data$value)
# sdkm1 <- sd(km1.data$value)
# Nkm1 <- km1.data %>% summarise(N = n_distinct(personID))
# mdkm1 <- median(km1.data$value)

```

The table below shows the mean, minimum and maximum value, the standard deviation and median for the item ***natural behaviour*** in session 1 for each perspective and target. The target always corresponds with the perspective of the teacher, i.e. teacher = target A. 

XXX Die Tabellen kann ich mir vielleicht für jede Skala sparen? XXX

``` {r natural behaviour data table, echo=FALSE}

m1.data %>% # select data
  group_by(target,perspective) %>%
  summarise(N = n_distinct(personID),
            "mean" = round(mean(value), 2),
            "min" = min(value),
            "max" = max(value),
            "sd" = sd(value),
            "median" = median(value)
  ) %>% 
  knitr::kable(digits = 2)

```


```{r natural behaviour line plots,  fig.height = 4, message = FALSE, warning = FALSE , echo=FALSE}

# to create error bars, we need to summarize the data in a separate data frame
m1.plot.sd <- m1.data %>%
  group_by(perspective, target, .drop=TRUE) %>%
  summarise(mean = mean(value), n = n(), sd = sd(value), se = sd/sqrt(n), )

# and here comes the long plot
m1.plot<-ggplot(data = m1.plot.sd,
                aes(x = perspective, y = mean,
                    group = target, colour = target)) +
  geom_line()+
  geom_pointrange(position = position_dodge(0.1), aes(ymin = mean-se, ymax = mean+se))+
  theme_light() +
  ylim(1,4)+
  labs(data = m1.data, y = "value", x = NULL,
       title="natural behaviour" ,
       subtitle=NULL)+
  theme(legend.position="bottom",
        panel.spacing.x = ,
        plot.title = element_text(hjust = 0.5))+
  scale_x_discrete(labels = function(x) str_wrap(x, width = 55))+
  coord_flip()
m1.plot
```
