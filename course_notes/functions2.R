library(tidyverse)
library(gapminder)


gapminder <- gapminder |> 
  rename("life_exp" = lifeExp, "gdp_per_cap" = gdpPercap)


est <- read_csv('https://raw.githubusercontent.com/OHI-Science/data-science-training/master/data/countries_estimated.csv')
gapminder_est <- gapminder |> 
  left_join(est)


cntry <- "Belgium"
country_list <- c("Albania", "Canada", "Spain")


dir.create("figures")
dir.create("figures/europe")

country_list <- unique(gapminder$country)

gap_europe <- gapminder_est |> 
  filter(continent == "Europe") |> 
  mutate(gdp_tot = gdp_per_cap * pop)

country_list <- unique(gap_europe$country)

# cntry <- "Albania"

print_plot <- function(cntry, stat = "gdp_per_cap", filetype = "pdf") {
  
  print(str_c("Plotting ", cntry))
  
  gap_to_plot <- gap_europe |> 
    filter(country == cntry)
  
  my_plot <- ggplot(data = gap_to_plot, mapping = aes(x = year, y = get(stat))) +
    geom_point() +
    labs(title = str_c(cntry, "GDP", sep = " "), 
         subtitle = ifelse(any(gap_to_plot$estimated == "yes"), "Estimated data", "Reported data"),
         y = stat)
  
  
  ggsave(filename = str_c("figures/europe/", cntry, "_", stat, ".", filetype, sep = ""), plot = my_plot)
  
}

print_plot("Germany")
print_plot("Germany", "life_exp")
print_plot("Germany", "pop")
print_plot("Germany", "gdp_per_cap")

for(cntry in country_list){
  print_plot(cntry)
}

print_plot("Iceland")
