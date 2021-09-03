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


# merge two data frames --> adding Columns, don't forget to merge BY AOI !

r3 <- merge(r1, r2, by = 'AOI')

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
