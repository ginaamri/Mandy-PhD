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


#compare AOI.x and AOI.y and output results to new column titled rating_compare
r3$rating_compare <- as.numeric(r3$AOI.x == r3$AOI.y)

# replace NA with 0 
r3 <- r3 %>%
   mutate_all(~replace(., is.na(.), 0))


#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree <- r3 %>% select(AOI.x, AOI.y)

# function agree() with a tolerance
agree(r3_agree)

#################### CohenKappa ##############################

r3_kappa <- select(r3,
                   AOI.x, AOI.y) 

r3_kappa <- as_factor(r3_kappa)

r3_kappa$AOI.x <- as_factor(r3_kappa$AOI.x)

r3_kappa$AOI.y <- as_factor(r3_kappa$AOI.y)

psych::cohen.kappa(x = as.matrix(r3_kappa))




# create a new variable with rater1
r3$rater1 <- ifelse(r3$rating_compare>0,"1", "0")

# create a new variable with rater2
r3$rater2 <- ifelse(r3$rater1<0,"0", "1")


# create a new df with only the ratings 
r3 <- r3 %>% select(rater1, rater2)


# create a xtab and specify who is rater1 and rater2
ratertab <- xtabs(~r3$rater1 + r3$rater2)
ratertab

# now you can calculate CohenKappa
CohenKappa(ratertab)


#################### ICC ##############################

# build a subset that contains the two AOI hit variables  
data_icc <- subset(r3, select = c(Hit_count.x, Hit_count.y))

# calculate the ICC for two raters with new subset
ICC(data_icc)
