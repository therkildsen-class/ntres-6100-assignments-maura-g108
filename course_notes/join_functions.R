library(tidyverse)
library(nycflights13) #install.packages("nycflights13")


# Row-binding -------------------------------------------------------------

fship <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")

ttow <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv")

rking <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

lotr <- bind_rows(fship, ttow, rking)

fship_no_female <- fship |> 
  select(Male, Film, Race)

bind_rows(ttow, fship_no_female, rking)


# Join functions ----------------------------------------------------------

flights
View(flights)

airlines
airports

planes |> 
  count(tailnum) |> 
  filter(n > 1)

planes |> 
  count(year) |> 
  tail()

weather
View(weather)

weather |> 
  count(time_hour, origin) |> 
  filter(n > 1)

planes |> 
  filter(is.na(tailnum))

flights2 <- flights |> 
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

airlines

flights2 |> 
  left_join(airlines)

weather

flights2 |> 
  left_join(weather)

planes

flights2 |> 
  left_join(planes, join_by(tailnum), suffix = c("_flights", "_planes"))

flights2
airports

flights2 |> 
  left_join(airports, join_by(origin == faa))

airports2 <- airports |> 
  select(faa, name, lat, lon)

flights2 |> 
  left_join(airports2, join_by(origin == faa)) |> 
  left_join(airports2, join_by(dest == faa), suffix = c("_origin", "_dest"))
