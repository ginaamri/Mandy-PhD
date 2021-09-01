### ProVisioNET pilot data 
#### intercoder reli eye tracking data 03_03


# if a package is not installed on the current machine, it will install it
if(!"devtools" %in% rownames(installed.packages())) install.packages("devtools")
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)
if (!require(papaja)) install.packages("papaja"); library(papaja)
if (!require(psych)) install.packages('psych'); library(psych) # stats
if (!require(moments)) install.packages('moments'); library(moments) # skewness & kurtosis
if (!require(sjPlot)) install.packages('sjPlot'); library(sjPlot) # item analysis of a scale or index

# pro tip: There is a package called needs. needs simplyfies you code and makes it
  # easier portable. It includes the function needs(). Needs only uses the packages 
  # as arguments.


# Don' run:
install.packages("needs")
library(needs)
needs(tidyverse,
      papaja,
      psych,
      moments,
      sjPlot,
      DescTools)

# suppress "summarize" info. 
# if this line is ommitted, each table using the summarize function will be accompanied with a warning from the console
options(dplyr.summarise.inform = FALSE)

r_refs("r-references.bib")

# read in data from rater1 while specifying locale allows to set "," 
coding_data_r1 <-read_tsv ("./data/03_03_EH_ProVisioNET_study_glasses Metrics_event-based.tsv", 
                   locale = locale(decimal_mark = ","))

# select variable AOI + Hit_proportion
r1 <- coding_data_r1 %>% select(AOI, Hit_proportion)

#delete NAs
r1 <- na.omit(r1)

# round Hit_proportion to 1
options(digits = 0)

#alternative (maybe safer)

r1$Hit_proportion <- round(r1$Hit_proportion,
                           digits = 0)

#aggregate data by AOI
r1 <- aggregate(r1,
                by = list(r1$AOI),
                FUN = length)

# It does not work, because aggregate from the tidyverse does only work in 
  # combination with group_by():

r1_aggr <- group_by(.data = r1,
                    AOI) %>% summarise(Hit_count = length(Hit_proportion))












