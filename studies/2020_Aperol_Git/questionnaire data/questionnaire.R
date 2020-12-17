
### QUESTIONNAIRE DATA ###


### load packages

install.packages("tidyverse")
install.packages("ggplot2")
install.packages("psych")
install.packages('pander')
install.packages('Hmisc')
install.packages('ggm')
install.packages('polycor')

library(ggplot2)
library(tidyverse)
library(pander)
library(psych)
library(knitr)
library(dplyr)
library(readxl)

### read in data
# data<-read_excel("fragebogen_value.xlsx")
# 
# show(data)

# read in data:




### filter relevant rows via filter function
data <- data  %>% filter (Aperol_pilot_01_02_expert_A_quest)
