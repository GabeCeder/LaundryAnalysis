library(tidyr)
library(dplyr)
library(ggplot2)

load('data/full_data.Rdata')


day <- 2
location <- "20 PRESCOTT ST"

d <- subset(full_data, day == day & location == location) %>% 
  group_by(time) %>% 
  summarise(total = n())

e <- subset(full_data, day == day & location == location) %>% 
  filter(avail_wash >= 1) %>% 
  group_by(time) %>% 
  summarise(prop = n())
  
bound_data <-  inner_join(d,e)

bound_data %>% 
  mutate(proportion_w = prop/total) %>% 
  mutate(w = case_when(
    proportion_w == 1 ~ 0.99,
    TRUE ~ proportion_w
  )) %>% 
  ggplot(aes(x = time, y = w, fill = w)) +
  geom_col() +
  labs(
    title = "Likelihood of Having 1 Machine Open"
  ) +
  ylab(
    "Likelihood"
  ) +
  xlab(
    "Time"
  ) +
  theme(
    legend.position = "none"
  )
