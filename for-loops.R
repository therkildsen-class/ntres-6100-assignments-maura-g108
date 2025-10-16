library(tidyverse)
library(gapminder)




cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")


dir.create("figures/Europe")


country_list <- unique(gapminder$country)



gap_Europe <- gapminder |> 
  filter(continent == "Europe") |> 
  mutate(gdp_tot = gdpPercap*pop) 
  
country_list <- gap_Europe |> 
  distinct(country) |> 
  pull(country)

length(country_list)


for (cntry in country_list) {

gap_to_plot <- gap_Europe |> 
  filter(country == cntry)

my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = gdp_tot)) +
  geom_point() +
  labs(title = str_c(cntry, "GDP per cap", sep = " "))

print(str_c("Plotting ", cntry))

ggsave(filename = str_c("figures/Europe/", cntry, "_gdp_per_cap.png", sep = ""), plot = my_plot)

}

