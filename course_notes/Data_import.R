library(tidyverse)
library(readxl)
library(googlesheets4)
library(janitor)


lotr <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")

write_csv(lotr, file = "data/lotr.csv")

lotr <- read_csv("data/lotr.csv", skip = 1, comment = "#")

lotr_excel <- read_xlsx("data/data_lesson11.xlsx", sheet = "FOTR")

gs4_deauth()
lotr_google <- read_sheet("https://docs.google.com/spreadsheets/d/1X98JobRtA3JGBFacs_JSjiX-4DPQ0vZYtNl_ozqF6IE/edit#gid=754443596", sheet = "deaths", range = "A5:F15")


msa <- read_tsv("https://raw.githubusercontent.com/nt246/NTRES-6100-data-science/main/datasets/janitor_mymsa_subset.txt")

colnames(msa)
msa_clean <- clean_names(msa, case = "upper_camel")

cbind(colnames(msa), colnames(msa_clean))


parse_number("$100")
parse_number("80%")
parse_number("It costs $100")
