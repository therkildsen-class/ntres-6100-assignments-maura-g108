library(tidyverse)
library(skimr) #install.packages("skimr")


coronavirus <- read_csv('https://raw.githubusercontent.com/RamiKrispin/coronavirus/master/csv/coronavirus.csv')

View(coronavirus)

# Summarise Function ------------------------------------------------------


coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country) |> 
  summarise(total = sum(cases),
            n = n()) |> 
  arrange(-total)

coronavirus |> 
  group_by(date, type) |> 
  summarise(total = sum(cases)) |> 
  filter(date == "2023-01-01")

coronavirus |> 
  filter(type == "death") |> 
  group_by(date) |> 
  summarise(total = sum(cases)) |> 
  arrange(-total)

gg_base <- coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(date) |> 
  summarise(cases = sum(cases)) |> 
  ggplot(mapping = aes(x = date, y = cases))

gg_base +
  geom_line()

gg_base +
  geom_point()

gg_base +
  geom_col(color = "red")

gg_base +
  geom_area(color = "red", fill = "red")

gg_base +
  geom_line(
    color = "purple",
    linetype = "dashed"
  )

gg_base +
  geom_point(mapping = aes(size = cases, color = cases),
    alpha = 0.4
  ) +
  theme_minimal() +
  theme(legend.background = element_rect(
    fill = "lemonchiffon",
    color = "grey50",
    linewidth = 0.2
  ))

gg_base +
  geom_point(mapping = aes(size = cases, color = cases),
             alpha = 0.4
  ) +
  theme_minimal() +
  labs(
    x = "Date",
    y = "Total confirmed cases",
    title = str_c("Daily counts of new coronavirus cases", max(coronavirus$date), sep = " "),
    subtitle = "Global sums"
  )


coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country, date) |>
  summarise(total = sum(cases)) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = total, color = country))


top5_countries <- coronavirus |> 
  filter(type == "confirmed") |> 
  group_by(country) |> 
  summarise(total = sum(cases)) |> 
  arrange(-total) |> 
  head(5) |> 
  pull(country)

coronavirus |> 
  filter(type == "confirmed", country %in% top5_countries, cases >= 0) |> 
  group_by(date, country) |>
  summarise(total = sum(cases)) |> 
  ggplot() +
  geom_line(mapping = aes(x = date, y = total, color = country)) +
  facet_wrap(~country, ncol=1)

