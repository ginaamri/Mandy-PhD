### ProVisioNET pilot data 
#### intercoder reli expertise data 01_01


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


################## RATER 1 ################

# read in data from rater1 while specifying locale allows to set "," 
r1 <-read_excel ("./data/coding_reactions_CW_ohne_Abstufung.xlsx")


################## RATER 2 ################

# read in data from rater1 while specifying locale allows to set "," 
r2 <-read_excel ("./data/coding_reactions_LK_ohne_Abstufung.xlsx")


################## DATA WRANGLING ################

# filter relevant rows and select relevant columns 
r1_v1 <- r1 %>% filter(script == "01") %>%
               select(,4:17)

r2_v1 <- r2 %>% filter(script == "01") %>%
   select(,4:17)


# reshape data frame in long format 
r1_long <- gather(r1_v1, reaction, value)

r2_long <- gather(r2_v1, reaction, value)

r1_long$value <- as.numeric(r1_long$value)

r2_long$value <- as.numeric(r2_long$value)


# merge two data frames vertically
r3 <- merge(r1_long, r2_long, by="reaction")


# select only value 
r3 <- select(r3, value.x, value.y)

# compare for rating for video 01
# filter only rows lesson


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

# create again a new df r3 with only the ratings 
r3_long_wide <- r3_long_wide[c(2:3)]


#################### CohenKappa ##############################

# first, create a xtab and specify who is rater1 and rater2
ratertab <- xtabs(~r3_long_wide$rater1 + r3_long_wide$rater2)
ratertab

# now you can calculate CohenKappa
CohenKappa(ratertab)
