### ProVisioNET pilot data 
#### intercoder reli expertise data 01_01


# if a package is not installed on the current machine, it will install it
if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if (!require(papaja)) install.packages("papaja"); library(papaja)
if (!require(psych)) install.packages('psych'); library(psych) # stats
if (!require(moments)) install.packages('moments'); library(moments) # skewness & kurtosis
if (!require(sjPlot)) install.packages('sjPlot'); library(sjPlot) # item analysis of a scale or index
if (!require(DescTools)) install.packages('DescTools'); library(DescTools) # cohens kappa
if (!require(irr)) install.packages('irr'); library(irr) # Various Coefficients of Interrater Reliability and Agreement
if (!require(readxl)) install.packages('readxl'); library(readxl) # read in excel files


# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)

r_refs("r-references.bib")

################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
r1 <-read_excel ("./data/coding_expertise_visual_engagement_JH.xlsx")

#delete NAs
r1 <- na.omit(r1)

################## RATER 2 ################

# read in data from rater1 while specifying locale allows to set "," 
r2 <-read_excel ("./data/coding_expertise_visual_engagement_FP.xlsx")


################## DATA WRANGLING ################

# different number of variables in r1 and r2 --> select all variables in r2 till 986
r2new <- r2[c(1:986)]

# merge two data frames vertically with rbind
r3 <- rbind(r1, r2new)

# add a new column to differentiate rater1 and rater2 in wide format
r3$Added_Column <- c("rater1", "rater2")

#rename column
r3 <- r3 %>% rename(rater = Added_Column)

# relocate the column to the first place
r3 <- r3 %>% relocate(rater)

# create a new df r3 with only the ratings 
r3 <- r3[-c(2:3)]

# wide to long format
r3_long <- gather(r3, timestamp, value, 2:985)

r3_long_wide <- pivot_wider(r3_long,
                            names_from = rater)

#################### CohenKappa ##############################

# first, create a xtab and specify who is rater1 and rater2
ratertab <- xtabs(~r3$Hit_count.x + r3$Hit_count.y)
ratertab

# now you can calculate CohenKappa
CohenKappa(ratertab)
