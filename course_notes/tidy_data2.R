coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

library(tidyverse)


coronavirus |> 
  filter(country == "US", cases >= 0) |> 
  ggplot() +
  geom_line(aes(x = date, y = cases, color = type))
  

corona_wide <- coronavirus |> 
  pivot_wider(names_from = type, values_from = cases)

coronavirus_ttd <- coronavirus |> 
  group_by(country, type) |>
  summarize(total_cases = sum(cases)) |>
  pivot_wider(names_from = type, values_from = total_cases)

# Now we can plot this easily
ggplot(coronavirus_ttd) +
  geom_label(mapping = aes(x = confirmed, y = death, label = country))
  
  
