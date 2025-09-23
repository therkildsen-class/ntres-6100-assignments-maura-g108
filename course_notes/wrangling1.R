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

select(coronavirus, contains('y'), everything()) # includes all columns that contain '', everything will paste the remaining columns



coronavirus_us <- filter(coronavirus, country == "US")
coronavirus_us2 <- select(coronavirus_us, -lat, -long, -province)

coronavirus |> 
  filter(country == "US") |>  
  select(-lat, -long, -province) # equivalent to above


coronavirus |> 
  filter(type == "death", country %in% c("US", "Canada", "Mexico")) |> 
  select(country, date, cases) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = cases, color = country))


# Vaccine data -------------------------------------------------------------------------



vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")

View(vacc)



# Summarize ---------------------------------------------------------------

vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population) |> 
  mutate(vaxxrate = round(people_at_least_one_dose/population, 2))

vacc <- read_csv("https://raw.githubusercontent.com/RamiKrispin/coronavirus/main/csv/covid19_vaccine.csv")

vacc |> 
  filter(date == max(date)) |>
  select(country_region, continent_name, doses_admin, people_at_least_one_dose, population) |> 
  mutate(doses_per_vaxxed = doses_admin/people_at_least_one_dose) |> 
  filter(doses_per_vaxxed > 3) |> 
  arrange(-doses_per_vaxxed)
  

vr <- vacc |> 
  filter(date == max(date)) |> 
  select(country_region, continent_name, people_at_least_one_dose, population) |> 
  mutate(vaxxrate = people_at_least_one_dose/population) |> 
  filter(vaxxrate > 0.9) |> 
  arrange(-vaxxrate) |> 
  head(5)