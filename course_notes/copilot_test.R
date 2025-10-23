library(palmerpenguins)
library(tidyverse)

# Explore penguin dataset
glimpse(penguins)
view(penguins)

# Visualize bill length by species
ggplot(penguins, aes(x = species, y = bill_length_mm, fill = species)) +
  geom_boxplot() +
  labs(title = "Bill Length by Penguin Species",
       x = "Species",
       y = "Bill Length (mm)") +
  theme_minimal()

# What is the relationship between body mass and flipper length in penguins
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Body Mass vs Flipper Length in Penguins",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_minimal()

# What is the relationship between body mass and flipper length in penguins shape by sex ggplot
ggplot(data = penguins) + 
  geom_point()


library(gapminder)
library(knitr)
library(janitor)

head(gapminder) |> kable()

gapminder_clean <- gapminder |> 
  clean_names()

glimpse(gapminder_clean)

# Create a plot of gdp_per_capita vs year for each country. Use for loops and ggsave
unique_countries <- unique(gapminder_clean$country)
for (country in unique_countries) {
  country_data <- gapminder_clean |> 
    filter(country == !!country)
  
  p <- ggplot(country_data, aes(x = year, y = gdp_per_capita)) +
    geom_line() +
    geom_point() +
    labs(title = paste("GDP per Capita over Time in", country),
         x = "Year",
         y = "GDP per Capita") +
    theme_minimal()
  
  ggsave(filename = paste0("gdp_per_capita_", country, ".png"), plot = p)
}

