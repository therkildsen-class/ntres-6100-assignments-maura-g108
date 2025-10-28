library(tidyverse)

calc_shrub_vol <- function(length, width, height = 1){
  area = length * width
  volume = area * height
  return(volume)
}

calc_shrub_vol(0.8, 1.6, height = 3)

est_shrub_mass <- function(volume){
  mass = 2.65 * volume^0.9
  return(mass)
}

shrub_volume <- calc_shrub_vol(0.8, 1.6, height = 3)
shrub_mass <- est_shrub_mass(shrub_volume)

est_shrub_mass(calc_shrub_vol(0.8, 1.6, 3))

calc_shrub_vol(0.8, 1.6, 2.0) |> 
  est_shrub_mass()

est_shrub_mass_from_raw <- function(length, width, height){
  volume = calc_shrub_vol(length, width, height)
# 
  mass = est_shrub_mass(volume)
  return(mass)
}



convert_pounds_to_grams <- function(lbs){
  g = 453.6 * lbs
  return(g)
}

convert_pounds_to_grams(3.75)




