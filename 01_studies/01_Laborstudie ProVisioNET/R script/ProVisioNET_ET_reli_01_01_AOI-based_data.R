### ProVisioNET pilot data 
#### intercoder reli eye tracking data 01_01


# install needed packages
library(needs)
needs(tidyverse,
      psych,
      moments,
      sjPlot,
      irr,
      readxl)

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)




### VIDEO 01_01
################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1_v1 <-read_tsv ("./data/01_01_AP_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r1_v1 <- coding_data_r1_v1 %>% filter(TOI == "Lesson")

# select relevant variables 
r1_v1 <- r1_v1 %>% select(EventIndex, AOI)

################## RATER 2 ################

# read in data from rater2 while specifying locale allows to set "," 
coding_data_r2_v1 <-read_tsv ("./data/01_01_MK_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r2_v1 <- coding_data_r2_v1 %>% filter(TOI == "Lesson")

# select relevant variables
r2_v1 <- r2_v1 %>% select(EventIndex, AOI)

#rename values in row Material = Teacher_Material
r2_v1$AOI[r2_v1$AOI == "Material_Teacher"] <- "Material"


###### filter identical row number

v1_r1 <- v1_r1 %>% filter(EventIndex != 1728,
                    EventIndex != 1729,
                    EventIndex != 1730,
                    EventIndex != 1731)

v1_r1


# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3_v1 <- left_join(r1_v1, r2_v1, by = 'EventIndex')


#compare AOI.x and AOI.y and output results to new column titled rating_compare
r3_v1$rating_compare <- as.numeric(r3_v1$AOI.x == r3_v1$AOI.y)

# replace NA with 0 
r3_v1 <- r3_v1 %>%
   mutate_all(~replace(., is.na(.), 0))


#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree_v1 <- r3_v1 %>% select(AOI.x, AOI.y)

# function agree() with a tolerance
agree(r3_agree_v1)

#################### CohenKappa ##############################

r3_kappa_v1 <- select(r3_v1,
                   AOI.x, AOI.y) 

r3_kappa_v1 <- as_factor(r3_kappa_v1)

r3_kappa_v1$AOI.x <- as_factor(r3_kappa_v1$AOI.x)

r3_kappa_v1$AOI.y <- as_factor(r3_kappa_v1$AOI.y)

psych::cohen.kappa(x = as.matrix(r3_kappa_v1))







### VIDEO 02_02
################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1_v2 <-read_tsv ("./data/02_02_AP_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r1_v2 <- coding_data_r1_v2 %>% filter(TOI == "Lesson")

# select relevant variables 
r1_v2 <- r1_v2 %>% select(EventIndex, AOI)

################## RATER 2 ################

# read in data from rater2 while specifying locale allows to set "," 
coding_data_r2_v2 <-read_tsv ("./data/02_02_MK_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r2_v2 <- coding_data_r2_v2 %>% filter(TOI == "Lesson")

# select relevant variables
r2_v2 <- r2_v2 %>% select(EventIndex, AOI)

#rename values in row Material = Teacher_Material
r2_v2$AOI[r2_v2$AOI == "Teacher_material"] <- "Material"

###### filter identical row number

r2_v2 <- r2_v2 %>% filter(EventIndex != 2398,
                    EventIndex != 2399,
                    EventIndex != 2400,
                    EventIndex != 2401)

r1_v2


# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3_v2 <- left_join(r1_v2, r2_v2, by = 'EventIndex')


#compare AOI.x and AOI.y and output results to new column titled rating_compare
r3_v2$rating_compare <- as.numeric(r3_v2$AOI.x == r3_v2$AOI.y)

# replace NA with 0 
r3_v2 <- r3_v2 %>%
   mutate_all(~replace(., is.na(.), 0))


#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree_v2 <- r3_v2 %>% select(AOI.x, AOI.y)

# function agree() with a tolerance
agree(r3_agree_v2)

#################### CohenKappa ##############################

r3_kappa_v2 <- select(r3_v2,
                   AOI.x, AOI.y) 

r3_kappa_v2 <- as_factor(r3_kappa_v2)

r3_kappa_v2$AOI.x <- as_factor(r3_kappa_v2$AOI.x)

r3_kappa_v2$AOI.y <- as_factor(r3_kappa_v2$AOI.y)

psych::cohen.kappa(x = as.matrix(r3_kappa_v2))







### VIDEO 03_03
################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1_v3 <-read_tsv ("./data/03_03_EH_ProVisioNET_study_glasses Metrics_event-based.tsv", 
                              locale = locale(decimal_mark = ","))

# filter only rows lesson
r1_v3 <- coding_data_r1_v3 %>% filter(TOI == "Lesson")

# select relevant variables 
r1_v3 <- r1_v3 %>% select(EventIndex, AOI)

################## RATER 2 ################

# read in data from rater2 while specifying locale allows to set "," 
coding_data_r2_v3 <-read_tsv ("./data/03_03_RD_ProVisioNET_study_glasses Metrics_event-based.tsv", 
                              locale = locale(decimal_mark = ","))

# filter only rows lesson
r2_v3 <- coding_data_r2_v3 %>% filter(TOI == "Lesson")

# select relevant variables
r2_v3 <- r2_v3 %>% select(EventIndex, AOI)

#rename values in row Material = Teacher_Material
r2_v3$AOI[r2_v3$AOI == "students_material"] <- "Material"

###### filter identical row number

r2_v3 <- r2_v3 %>% filter(EventIndex != 1055,
                          EventIndex != 1056,
                          EventIndex != 1057,
                          EventIndex != 1058,
                          EventIndex != 1059,
                          EventIndex != 1060,
                          EventIndex != 1061,
                          EventIndex != 1062,
                          EventIndex != 1063,
                          EventIndex != 1064,
                          EventIndex != 1065,
                          EventIndex != 1066,
                          EventIndex != 1067,
                          EventIndex != 1068,
                          EventIndex != 1069)

r1_v2


# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3_v3 <- left_join(r1_v3, r2_v3, by = 'EventIndex')


#compare AOI.x and AOI.y and output results to new column titled rating_compare
r3_v3$rating_compare <- as.numeric(r3_v3$AOI.x == r3_v3$AOI.y)

# replace NA with 0 
r3_v3 <- r3_v3 %>%
   mutate_all(~replace(., is.na(.), 0))


#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree_v3 <- r3_v3 %>% select(AOI.x, AOI.y)

# function agree() with a tolerance
agree(r3_agree_v3)

#################### CohenKappa ##############################

r3_kappa_v3 <- select(r3_v3,
                      AOI.x, AOI.y) 

r3_kappa_v3 <- as_factor(r3_kappa_v3)

r3_kappa_v3$AOI.x <- as_factor(r3_kappa_v3$AOI.x)

r3_kappa_v3$AOI.y <- as_factor(r3_kappa_v3$AOI.y)

psych::cohen.kappa(x = as.matrix(r3_kappa_v3))






### VIDEO 04_04
################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1_v4 <-read_tsv ("./data/04_04_AP_ProVisioNET_study_glasses Metrics_event-based.tsv", 
                              locale = locale(decimal_mark = ","))

# filter only rows lesson
r1_v4 <- coding_data_r1_v4 %>% filter(TOI == "Lesson")

# select relevant variables 
r1_v4 <- r1_v4 %>% select(EventIndex, AOI)

################## RATER 2 ################

# read in data from rater2 while specifying locale allows to set "," 
coding_data_r2_v4 <-read_tsv ("./data/04_04_MK_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                              locale = locale(decimal_mark = ","))

# filter only rows lesson
r2_v4 <- coding_data_r2_v4 %>% filter(TOI == "Lesson")

# select relevant variables
r2_v4 <- r2_v4 %>% select(EventIndex, AOI)

#rename values in row Material = Teacher_Material
r2_v4$AOI[r2_v4$AOI == "Material_Teacher"] <- "Material"

###### row number is already identical

# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3_v4 <- left_join(r1_v4, r2_v4, by = 'EventIndex')


#compare AOI.x and AOI.y and output results to new column titled rating_compare
# r3_v4$rating_compare <- as.numeric(r3_v4$AOI.x == r3_v4$AOI.y)

# replace NA with 0 
r3_v4 <- r3_v4 %>%
   mutate_all(~replace(., is.na(.), 0))


#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree_v4 <- r3_v4 %>% select(AOI.x, AOI.y)

# function agree() with a tolerance
agree(r3_agree_v4)

#################### CohenKappa ##############################

r3_kappa_v4 <- select(r3_v4,
                      AOI.x, AOI.y) 

r3_kappa_v4 <- as_factor(r3_kappa_v4)

r3_kappa_v4$AOI.x <- as_factor(r3_kappa_v4$AOI.x)

r3_kappa_v4$AOI.y <- as_factor(r3_kappa_v4$AOI.y)

psych::cohen.kappa(x = as.matrix(r3_kappa_v4))




