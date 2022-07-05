library(tidyverse)
library(ggthemes)
library(readxl)
library(dplyr)
library(plotly)


michigan <- read_excel("michigan.xlsx", col_types = c("numeric", 
                   "text", "text", "numeric", "numeric", 
                  "numeric", "numeric", "numeric", "numeric", 
                   "numeric", "numeric", "numeric", "text", 
                   "numeric", "numeric", "numeric"))
View(michigan)


fish_plot <- michigan |> 
  as_tibble(michigan)
rename(michigan, mi_total = "MI State Total") |> 
  select(Year, Species, mi_total) |> 
  filter(Species %in% c("Carp", "Walleye", "Yellow Perch", "Lake Sturgeon", "Lake Trout", "Northern Pike")) |> 
  drop_na() |> 
  ggplot(mapping = aes(x = Year, 
                       y = mi_total, 
                       color = Species)) +
  geom_line() +
  theme_clean() +
  labs(title = "Fish Stocking by Year and Species", 
       subtitle = "Less fish are stocked yearly", 
       x = "Year", 
       y = "Total # of Fish Stocked into Lake Michigan", 
       caption = "Source: Baldwin, N.S., Saalfeld, R.W., Dochoda, M.R., Buettner, 
       H.J., Eshenroder, R.L., and O’Gorman, R. 2018")

write_rds(fish_plot, "fish-plot.rds")



