### ProVisioNET pilot data 
#### intercoder reli eye tracking data 03_03


# if a package is not installed on the current machine, it will install it
if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if (!require(papaja)) install.packages("papaja"); library(papaja)
if (!require(psych)) install.packages('psych'); library(psych) # stats
if (!require(moments)) install.packages('moments'); library(moments) # skewness & kurtosis
if (!require(sjPlot)) install.packages('sjPlot'); library(sjPlot) # item analysis of a scale or index

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)

r_refs("r-references.bib")


################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1 <-read_tsv ("./data/03_03_EH_ProVisioNET_study_glasses Metrics_event-based.tsv", 
                   locale = locale(decimal_mark = ","))

# filter only rows lesson
r1 <- coding_data_r1 %>% filter(TOI == "Lesson")

# select variable AOI + Hit_proportion
r1 <- r1 %>% select(AOI, Hit_proportion)


#delete NAs
r1 <- na.omit(r1)

# round Hit_proportion to 1
options(digits = 0)              

#aggregate data by AOI
r1 <- aggregate(r1,
                by = list(r1$AOI),
                FUN = length)

# select only one row and rename columns 
r1 <- r1 %>% select (Group.1, Hit_proportion) %>%
              rename(AOI = Group.1,
                     AOI_hit_r1 = Hit_proportion)  
    
r1

################## RATER 2 ################

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r2 <-read_tsv ("./data/03_03_RD_ProVisioNET_study_glasses Metrics_event-based.tsv", 
                           locale = locale(decimal_mark = ","))

# filter only rows lesson
r2 <- coding_data_r2 %>% filter(TOI == "Lesson")

# select variable AOI + Hit_proportion
r2 <- r2 %>% select(AOI, Hit_proportion)


#delete NAs
r2 <- na.omit(r2)

# round Hit_proportion to 1
options(digits = 0)              

#aggregate data by AOI
r2 <- aggregate(r2,
                by = list(r2$AOI),
                FUN = length)

# select only one row and rename columns 
r2 <- r2 %>% select (Group.1, Hit_proportion) %>%
  rename(AOI = Group.1,
         AOI_hit_r2 = Hit_proportion)  

r2


###### filter only for identical rows for both rater

r1 <- r1 %>% filter(AOI != "Board_Screen",
                    AOI != "Disruptive_Person,students_material", 
                    AOI != "Material",
                    AOI != "students_material")

r1

r2 <- r2 %>% filter(AOI != "Board_Screen",
                    AOI != "Anna,Bianca,Disruptive_Person",
                    AOI != "Disruptive_Person,students_material", 
                    AOI != "Material",
                    AOI != "students_material")
r2



