library(tidyverse)

mpg
?mpg

?cars
cars

View(mpg)

head(cars, 4)
tail(cars)


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class, size = cyl), 
             shape = 1)
?geom_point

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = hwy), color = "blue")



ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(aes(color = class, size = cyl), shape = 1) +
  geom_smooth() +
  facet_wrap(~ year, nrow = 2) +
  theme_bw()


ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class)







plot1 <- ggplot(data=mpg, mapping = aes(x=displ, y=hwy)) +
  geom_point(mapping=aes (color=class, size=cyl), shape=1) +
  geom_smooth() +
  facet_wrap(~year, nrow=2) +
  theme_minimal()

plot1

ggsave("course_notes/plots/hwy_vs_displ.png", plot1, width = 8, height = 4)
?ggsave
