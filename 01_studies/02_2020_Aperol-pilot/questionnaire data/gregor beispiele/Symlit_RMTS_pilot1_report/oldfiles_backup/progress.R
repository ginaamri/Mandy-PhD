
# loading packages; if a package is not installed, it will install it
if (!require(bookdown)) install.packages('bookdown'); library(bookdown)
if (!require(tidyverse)) install.packages('tidyverse'); library(tidyverse)

### prepare file in excel
# use filter to select only lines with an ID in it (i.e. exclude all empty lines or lines with na ? x etc)
# select all lines except the columns for comments
# copy/paste into a new spreadsheet
# save as "tab-delimited-text"

### prepare data
# load tab delimited text file into R; file should be in the same folder as the script for "./" to select it
raw.data<-read.table("./data/SymLit_RMTS_subjectlist_011220_V2.txt",sep="\t", header=T) 

