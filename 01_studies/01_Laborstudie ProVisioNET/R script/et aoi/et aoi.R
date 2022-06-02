### ProVisioNET Eyetracking AOI Coding Data 
library(needs)
needs(tidyverse,
      psych,
      moments,
      sjPlot,
      DescTools,
      irr,
      readxl, 
      gridExtra,
      janitor)

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)

# return a character vector with names of .tsv data in data folder
file_names <- list.files(path = "data",
                         pattern = "interval_complete.tsv")

# read every object names in file_names and save it as a tibble
for (i in file_names) {
  
  work_data <- 
    read_tsv(file = paste0("data/", i),
             locale = locale(decimal_mark = ","))
  
  assign(value = work_data,
         x = str_remove(paste0("tib_", i),
                        pattern = ".tsv"
         )
  )
  
}

# Bind every tibble that contains "interval_complete" to a new tiblle
df_aoi <- 
  mget(ls(pattern = "interval_complete")) %>%
  bind_rows()

# Remove temporary data for a cleaner workspace
rm(list = ls(pattern = "^tib_ProVisio"))
rm(work_data)
rm(file_names)
rm(i)

# filter relevant rows
df_aoi <- df_aoi %>% filter (TOI %in% c("Chatting_with_neighbour",
                                        "Clicking_pen",
                                        "Drawing",
                                        "Drumming_with_hands",
                                        "Head_on_table",
                                        "Heckling",
                                        "Looking_at_phone",
                                        "Snipping_with_fingers",
                                        "Whispering"
                                        )
                             )

# creating new variable with sum disruptions
df_aoi$TOI_sum[df_aoi$TOI == "Chatting_with_neighbour" |
                 df_aoi$TOI == "Heckling" |
                 df_aoi$TOI == "Whispering"] <- "Verbal disruption"

df_aoi$TOI_sum[df_aoi$TOI == "Head_on_table" |
                 df_aoi$TOI == "Looking_at_phone" |
                 df_aoi$TOI == "Drawing"] <- "Lack of eagerness"

df_aoi$TOI_sum[df_aoi$TOI == "Clicking_pen" |
                 df_aoi$TOI == "Drumming_with_hands" |
                 df_aoi$TOI == "Snipping_with_fingers"] <- "Agitation"

# select relevant columns
df_aoi <- df_aoi %>% 
  select(Participant, 
         Group,
         TOI,
         TOI_sum,
         Time_to_first_fixation.Disruptive_Person,
         starts_with("Total_duration_of_fixations"),
         starts_with("Number_of_fixations"))


# # remove all NAs
# df_aoi <- na.omit(df_aoi)


########################### TIME TO FIRST FIXATION ON DISRUPTIVE PERSON ######################

# changing milliseconds into seconds
df_aoi$Time_to_first_fixation_seconds.Disruptive_Person <- round(df_aoi$Time_to_first_fixation.Disruptive_Person/1000, digits = 2)

# TIME TO FIRST FIXATION ON DISRUPTIVE PERSON 
# t-test for expertise differences
t.test(x = df_aoi$Time_to_first_fixation.Disruptive_Person[df_aoi$Group == "Expert"],
       y = df_aoi$Time_to_first_fixation.Disruptive_Person[df_aoi$Group == "Novice"])

# TIME TO FIRST FIXATION ON DISRUPTIVE PERSON 
# effect size for group differenes
d_time <- CohenD(x = df_aoi$Time_to_first_fixation.Disruptive_Person[df_aoi$Group == "Novice"],
            y = df_aoi$Time_to_first_fixation.Disruptive_Person[df_aoi$Group == "Expert"],
            na.rm = TRUE
            )

# plotting time to first fixation for groups
fix_group_plot <-
  ggplot(data = df_aoi,
         mapping = aes(x = Group,
                       y = Time_to_first_fixation_seconds.Disruptive_Person)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2,
             alpha = 0.4,
             position = position_jitter(seed = 1,
                                        width = 0.1,
                                        height = 0)) +
  ylim(0,15) +
  labs(x = "",
       y = "Time to first fixation in seconds") +
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  ggtitle("Time to first fixation to disruptive person for expertise groups") +
  theme_classic() +
  theme(legend.position="none",
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title = element_text(size=14),
        plot.title = element_text(size = 15, 
                                  face = "bold")
        )

fix_group_plot


# # plotting time to first fixation for all disruptions
# fix_plot <- 
#   ggplot(data = df_aoi,
#          mapping = aes(x = Group,
#                        y = Time_to_first_fixation_seconds.Disruptive_Person)) +
#   geom_boxplot(mapping = aes(fill = Group)) +
#   geom_point(size = 2, 
#              alpha = 0.4,
#              position = position_jitter(seed = 1, 
#                                         width = 0.1)) +
#   ylim(0,25) + 
#   labs(x ="") + 
#   scale_fill_manual(values=c("steelblue","firebrick")) +
#   facet_wrap(vars(TOI), 
#              nrow = 1, strip.position = "bottom") +
#   ggtitle("Time to first fixation in seconds to disruptive person") +
#   theme_classic() + 
#   theme(
#     axis.text.x = element_blank(),
#     axis.ticks.x = element_blank(),
#     strip.text.x = element_text(size = 6,
#                                 angle = 90),
#     plot.title = element_text(size = 15, face = "bold"))
# 
# fix_plot


# plotting time to first fixation for 3 disruptions sum up
fix_plot_sum <-
  ggplot(data = df_aoi,
         mapping = aes(x = Group,
                       y = Time_to_first_fixation_seconds.Disruptive_Person)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2,
             alpha = 0.4,
             position = position_jitter(seed = 1,
                                        width = 0.1,
                                        height = 0)) +
  ylim(0,15) +
  labs(x = "",
       y = "Time to first fixation in seconds") +
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  ggtitle("Time to first fixation to disruptive person for categories") +
  theme_classic() +
  theme(
    strip.background = element_blank(),
    legend.title = element_text(size=14), #change legend title font size
    legend.text = element_text(size=14), #change legend text font size
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 15),
    plot.title = element_text(size = 20, face = "bold"),
    axis.title.y = element_text(size = 16),
    axis.line = element_line(colour = "black"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank()) +
  facet_wrap(facets = vars(TOI_sum),
             nrow = 1,
             strip.position = "bottom")

fix_plot_sum

########################### TOTAL DURATION OF FIXATIONS IN AOIS ######################

# # creating new variable by summarizing total duration in all AOIs
# df_aoi_dur_sum <-
#   df_aoi %>% 
#   rowwise() %>% 
#   mutate(Sum_total_duration_of_fixations = sum(c_across(starts_with("Total_duration")
#                                                         ),
#                                                na.rm = TRUE
#                                                )
#          )

# TOTAL DURATION OF FIXATIONS IN AOI = Disruptive Person 
# t-test for expertise differences
t.test(x = df_aoi$Total_duration_of_fixations.Disruptive_Person[df_aoi$Group == "Expert"],
       y = df_aoi$Total_duration_of_fixations.Disruptive_Person[df_aoi$Group == "Novice"])


# TOTAL DURATION OF FIXATIONS IN AOI = Disruptive Person
# effect size for expertise differences
d_dur_disrup <- CohenD(x = df_aoi$Total_duration_of_fixations.Disruptive_Person[df_aoi$Group == "Novice"],
            y = df_aoi$Total_duration_of_fixations.Disruptive_Person[df_aoi$Group == "Expert"],
            na.rm = TRUE
                )


# TOTAL DURATION OF FIXATIONS IN AOI = Students 
# creating new variable by summarizing total duration in AOI "Students"
df_aoi <-
  df_aoi %>% 
  rowwise() %>% 
  mutate(Total_duration_of_fixations.Students = sum(c_across("Total_duration_of_fixations.Anna" | 
                                                             "Total_duration_of_fixations.Bianca" |
                                                             "Total_duration_of_fixations.Carl(a)")
                                                    )        
         )

# t-test for expertise differences
t.test(x = df_aoi$Total_duration_of_fixations.Students[df_aoi$Group == "Expert"],
       y = df_aoi$Total_duration_of_fixations.Students[df_aoi$Group == "Novice"])


# TOTAL DURATION OF FIXATIONS IN AOI = Students
# effect size for expertise differences
d_dur_stud <- CohenD(x = df_aoi$Total_duration_of_fixations.Students[df_aoi$Group == "Novice"],
                y = df_aoi$Total_duration_of_fixations.Students[df_aoi$Group == "Expert"],
                na.rm = TRUE
                    )

# selecting relevant columns
df_aoi_dur <- df_aoi %>% 
  select(Group,
         TOI_sum,
         starts_with("Total_duration_of_fixations"))


# changing format from wide to long
df_aoi_dur <- df_aoi_dur %>% pivot_longer(
                                        cols = contains("Total_duration"),
                                        names_to = "Total_durations_of_fixations",
                                        values_to = "Milliseconds")


# remove all NAs
df_aoi_dur <- na.omit(df_aoi_dur)


# changing milliseconds into seconds
df_aoi_dur$Seconds <- round(df_aoi_dur$Milliseconds/1000,
                        digits = 2)


# rename values
df_aoi_dur <- 
  df_aoi_dur %>% 
  mutate(AOI = recode(Total_durations_of_fixations, 
                                               Total_duration_of_fixations.Anna = 'StudentA',
                                               Total_duration_of_fixations.Bianca = 'StudentB',
                                               Total_duration_of_fixations.Board_Screen = 'Board/Screen',
                                               `Total_duration_of_fixations.Carl(a)` = 'StudentC',
                                               Total_duration_of_fixations.Classroom_Others = 'Classroom/Others',
                                               Total_duration_of_fixations.Disruptive_Person = 'Disruptive Person',
                                               Total_duration_of_fixations.Material_Students = 'Material Students',
                                               Total_duration_of_fixations.Material_Teacher = 'Material Teacher',
                                               Total_duration_of_fixations.Nametag_Anna = 'NametagA',
                                               Total_duration_of_fixations.Nametag_Bianca = 'NametagB',
                                               `Total_duration_of_fixations.Nametag_Carl(a)` = 'NametagC'))

         
# plotting total duration of fixations for expertise groups
totaldur_group_plot <- 
  ggplot(data = df_aoi_dur,
         mapping = aes(x = Group,
                       y = Seconds)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2, 
             alpha = 0.1,
             position = position_jitter(seed = 1, 
                                        width = 0.1)) +
  # ylim(0,20) + 
  labs(x ="") + 
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  ggtitle("Total Duration of Fixations in all AOIs") +
  theme_classic() + 
  theme(legend.position="none",
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title = element_text(size=14),
        plot.title = element_text(size = 15, 
                                  face = "bold")
        )

totaldur_group_plot



# plotting total duration of fixations for disruptive person
totaldur_disrup_plot <-
  df_aoi_dur %>%
  filter(AOI == "Disruptive Person") %>% 
  ggplot(mapping = aes(x = Group,
                       y = Seconds)) +
  # geom_violin(mapping = aes(fill = Group)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 1,
             alpha = 0.1,
             position = position_jitter(seed = 1,
                                        width = 0.1)) +
  ylim(0,20) +
  labs(x ="") +
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  # facet_wrap(vars(Total_Durations_Of_Fixations),
             # nrow = 1, strip.position = "bottom") +
  ggtitle("Total Duration of Fixations in AOI `Disruptive Person`") +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 6,
                                angle = 90),
    plot.title = element_text(size = 15, face = "bold")) + 
  theme(legend.position="none",
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title = element_text(size=14),
        plot.title = element_text(size = 15, 
                                  face = "bold")
        )

totaldur_disrup_plot


# plot für students
totaldur_student_plot <-
  df_aoi_dur %>%
  filter(AOI %in% c("StudentA", "StudentB", "StudentC")) %>% 
  ggplot(mapping = aes(x = Group,
                       y = Seconds)) +
  # geom_violin(mapping = aes(fill = Group)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 1,
             alpha = 0.1,
             position = position_jitter(seed = 1,
                                        width = 0.1)) +
  ylim(0,20) +
  labs(x ="") +
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  # facet_wrap(vars(Total_Durations_Of_Fixations),
  # nrow = 1, strip.position = "bottom") +
  ggtitle("Total Duration of Fixations in AOI `Students`") +
  theme_classic() +
  theme(legend.position="none",
    axis.text.x = element_text(size = 14),
    axis.text.y = element_text(size = 14),
    axis.title = element_text(size=14),
    plot.title = element_text(size = 15, 
                              face = "bold")
        )

totaldur_student_plot


grid.arrange(totaldur_disrup_plot, 
             totaldur_student_plot,
             nrow = 1)

########################### NUMBER OF FIXATIONS IN AOIS ######################

# NUMBER OF FIXATIONS IN AOI = Disruptive Person 
# t-test for expertise differences
t.test(x = df_aoi$Number_of_fixations.Disruptive_Person[df_aoi$Group == "Expert"],
       y = df_aoi$Number_of_fixations.Disruptive_Person[df_aoi$Group == "Novice"])


# TOTAL DURATION OF FIXATIONS IN AOI = Disruptive Person
# effect size for expertise differences
d_number_disrup <- CohenD(x = df_aoi$Number_of_fixations.Disruptive_Person[df_aoi$Group == "Novice"],
                       y = df_aoi$Number_of_fixations.Disruptive_Person[df_aoi$Group == "Expert"],
                       na.rm = TRUE
                          )


# TOTAL DURATION OF FIXATIONS IN AOI = Students 
# creating new variable by summarizing total duration in AOI "Students"
df_aoi <-
  df_aoi %>% 
  rowwise() %>% 
  mutate(Number_of_fixations.Students = sum(c_across("Number_of_fixations.Anna" |
                                                       "Number_of_fixations.Bianca" |
                                                       "Number_of_fixations.Carl(a)")
                                            )
         )

# t-test for expertise differences
t.test(x = df_aoi$Number_of_fixations.Students[df_aoi$Group == "Expert"],
       y = df_aoi$Number_of_fixations.Students[df_aoi$Group == "Novice"])


# TOTAL DURATION OF FIXATIONS IN AOI = Students
# effect size for expertise differences
d_number_stud <- CohenD(x = df_aoi$Number_of_fixations.Students[df_aoi$Group == "Expert"],
                     y = df_aoi$Number_of_fixations.Students[df_aoi$Group == "Novice"],
                     na.rm = TRUE
                     )

# selecting relevant columns
df_aoi_number <- df_aoi %>% 
  select(Group,
         TOI,
         starts_with("Number_of_fixations"))


# changing format from wide to long
df_aoi_number <- df_aoi_number %>% pivot_longer(
  cols = contains("Number_of_fixations"),
  names_to = "AOI",
  values_to = "Number")


# remove all NAs
df_aoi_number <- na.omit(df_aoi_number)

# rename values
df_aoi_number <- df_aoi_number %>% 
  mutate(AOI = recode(AOI,
                      Number_of_fixations.Anna = 'StudentA',
                      Number_of_fixations.Bianca = 'StudentB',
                      Number_of_fixations.Board_Screen = 'Board/Screen',
                      `Number_of_fixations.Carl(a)` = 'StudentC',
                      Number_of_fixations.Classroom_Others = 'Classroom/Others',
                      Number_of_fixations.Disruptive_Person = 'Disruptive Person',
                      Number_of_fixations.Material_Students = 'Material Students',
                      Number_of_fixations.Material_Teacher = 'Material Teacher',
                      Number_of_fixations.Nametag_Anna = 'NametagA',
                      Number_of_fixations.Nametag_Bianca = 'NametagB',
                      `Number_of_fixations.Nametag_Carl(a)` = 'NametagC'))


# plotting number of fixations in AOIs for expertise groups
number_group_plot <- 
  ggplot(data = df_aoi_number,
         mapping = aes(x = Group,
                       y = Number)) +
  # geom_violin(mapping = aes(fill = Group)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 2,
             alpha = 0.1,
             position = position_jitter(seed = 1,
                                        width = 0.1)) +
  ylim(0,20) + 
  labs(x ="") + 
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  ggtitle("Number of Fixations in all AOIs") +
  theme_classic() + 
  theme(legend.position="none",
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title = element_text(size=14),
        plot.title = element_text(size = 15, 
                                  face = "bold")
        )

number_group_plot

# plotting number of fixations in AOI = Disruptive Person
number_disrup_plot <-
  df_aoi_number %>%
  filter(AOI == "Disruptive Person") %>% 
  ggplot(mapping = aes(x = Group,
                       y = Number)) +
  # geom_violin(mapping = aes(fill = Group)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 1,
             alpha = 0.1,
             position = position_jitter(seed = 1,
                                        width = 0.1)) +
  ylim(0,20) +
  labs(x ="") +
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  # facet_wrap(vars(Total_Durations_Of_Fixations),
  # nrow = 1, strip.position = "bottom") +
  ggtitle("Number of Fixations in AOI `Disruptive Person`") +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 6,
                                angle = 90),
    plot.title = element_text(size = 15, face = "bold")) + 
  theme(legend.position="none",
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title = element_text(size=14),
        plot.title = element_text(size = 15, 
                                  face = "bold")
        )

number_disrup_plot


# plotting number of fixations in AOI = Students
number_stud_plot <-
  df_aoi_number %>%
  filter(AOI %in% c("StudentA", "StudentB", "StudentC")) %>% 
  ggplot(mapping = aes(x = Group,
                       y = Number)) +
  # geom_violin(mapping = aes(fill = Group)) +
  geom_boxplot(mapping = aes(fill = Group)) +
  geom_point(size = 1,
             alpha = 0.1,
             position = position_jitter(seed = 1,
                                        width = 0.1)) +
  ylim(0,20) +
  labs(x ="") +
  scale_fill_manual(values=c("steelblue","firebrick")) +  
  # facet_wrap(vars(Total_Durations_Of_Fixations),
  # nrow = 1, strip.position = "bottom") +
  ggtitle("Number of Fixations in AOI `Students`") +
  theme_classic() +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    strip.text.x = element_text(size = 6,
                                angle = 90),
    plot.title = element_text(size = 15, face = "bold")) +
  theme(legend.position="none",
        axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14),
        axis.title = element_text(size=14),
        plot.title = element_text(size = 15, 
                                  face = "bold")
        )


number_stud_plot


grid.arrange(number_group_plot,
             number_disrup_plot, 
             number_stud_plot,
             nrow = 1)
