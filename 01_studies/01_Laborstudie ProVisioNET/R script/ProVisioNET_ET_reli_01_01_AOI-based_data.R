### ProVisioNET pilot data 
#### intercoder reli eye tracking data 01_01


# if a package is not installed on the current machine, it will install it
library(needs)
needs(tidyverse,
      psych,
      moments,
      sjPlot,
      DescTools,
      irr,
      readxl)

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)


################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1 <-read_tsv ("./data/01_01_AP_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r1 <- coding_data_r1 %>% filter(TOI == "Lesson")

# select relevant variables 
r1 <- r1 %>% select(EventIndex, AOI)

################## RATER 2 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r2 <-read_tsv ("./data/01_01_MK_ProVisioNET_study_glasses_Metrics_Event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r2 <- coding_data_r2 %>% filter(TOI == "Lesson")

# select relevant variables
r2 <- r2 %>% select(EventIndex, AOI)

#rename values in row Material = Teacher_Material
r2$AOI[r2$AOI == "Material_Teacher"] <- "Material"


###### filter identical row number

r1 <- r1 %>% filter(EventIndex != 1728,
                    EventIndex != 1729,
                    EventIndex != 1730,
                    EventIndex != 1731)

r1


# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3 <- left_join(r1, r2, by = 'EventIndex')

#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree <- r3 %>% select(AOI.x, AOI.y)

# function agree() with a tolerance
agree(r3_agree)

#################### CohenKappa ##############################

# first, create a xtab and specify who is rater1 and rater2
ratertab <- xtabs(~r3$AOI.x + r3$AOI.y)
ratertab

# now you can calculate CohenKappa
CohenKappa(ratertab)


#################### ICC ##############################

# build a subset that contains the two AOI hit variables  
data_icc <- subset(r3, select = c(Hit_count.x, Hit_count.y))

# calculate the ICC for two raters with new subset
ICC(data_icc)
