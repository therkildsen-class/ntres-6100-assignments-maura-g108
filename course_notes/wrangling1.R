library(tidyverse)
library(skimr) #install.packages("skimr")


coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

summary(coronavirus)
skim(coronavirus) # better than summary
View(coronavirus)
head(coronavirus)
tail(coronavirus)

head(coronavirus$cases) # base R



filter(coronavirus, cases > 0)

coronavirus_us <- filter(coronavirus, country == "US")
filter(coronavirus, country != "US")

filter(coronavirus, country == "US" | country == "Canada") # | means "or"
filter(coronavirus, country %in% c("US", "Canada")) # same as line above, %in% looks for a match within string



filter(coronavirus, country == "US" & type == "death") # & means "and"
filter(coronavirus, country == "US", type == "death") # same as line above



filter(coronavirus, country %in% c("Ireland", "France", "Germany"), date == "2021-09-16", type == "death")

View(count(coronavirus, country)) # counts the number of countries in coronavirus dataset

select(coronavirus, date, country, type, cases) # will print the order of columns based on the order of what we input
select(coronavirus, -province)

select(coronavirus, country, lat, long)
select(coronavirus, date:cases) #all columns to and including cases

select(coronavirus, 1:3)