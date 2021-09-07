### ProVisioNET pilot data 
#### intercoder reli eye tracking data 03_03


# if a package is not installed on the current machine, it will install it
if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if (!require(papaja)) install.packages("papaja"); library(papaja)
if (!require(psych)) install.packages('psych'); library(psych) # stats
if (!require(moments)) install.packages('moments'); library(moments) # skewness & kurtosis
if (!require(sjPlot)) install.packages('sjPlot'); library(sjPlot) # item analysis of a scale or index
if (!require(DescTools)) install.packages('DescTools'); library(DescTools) # cohens kappa
if (!require(irr)) install.packages('irr'); library(irr) # Various Coefficients of Interrater Reliability and Agreement


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
r1$Hit_proportion <- round(r1$Hit_proportion,
                           digits = 0)

# group data by AOI and summarise Hit_prop
r1_aggr <- group_by(.data = r1,
                    AOI) %>% summarise(Hit_count = length(Hit_proportion))

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
r2$Hit_proportion <- round(r2$Hit_proportion,
                           digits = 0)

# group data by AOI and summarise Hit_prop
r2_aggr <- group_by(.data = r2,
                    AOI) %>% summarise(Hit_count = length(Hit_proportion))



###### filter only for identical rows for both rater

r1_filter <- r1_aggr %>% filter(AOI != "Board_Screen",
                    AOI != "Disruptive_Person,students_material", 
                    AOI != "Material",
                    AOI != "students_material")

r1_filter

r2_filter <- r2_aggr %>% filter(AOI != "Board_Screen",
                    AOI != "Anna,Bianca,Disruptive_Person",
                    AOI != "Disruptive_Person,students_material", 
                    AOI != "Material",
                    AOI != "students_material")
r2_filter

# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3 <- merge(r1_filter, r2_filter, by = 'AOI')


#################### Percentage Agreement ##############################

# create a new df with only the ratings 
r3_agree <- r3 %>% select(Hit_count.x, Hit_count.y)

# function agree() with a tolerance
agree(r3_agree, tolerance=50)

#################### CohenKappa ##############################

# first, create a xtab and specify who is rater1 and rater2
ratertab <- xtabs(~r3$Hit_count.x + r3$Hit_count.y)
ratertab

# now you can calculate CohenKappa
CohenKappa(ratertab)


#################### ICC ##############################

# build a subset that contains the two AOI hit variables  
data_icc <- subset(r3, select = c(Hit_count.x, Hit_count.y))

# calculate the ICC for two raters with new subset
ICC(data_icc)


