library(tidyr)
library(ggplot2)

load('data/full_data.Rdata')


d <- subset(full_data, day == 4 & location == "10 DEWOLFE STREET") %>% 
  summarise(total = n())

e <- subset(full_data, day == 4 & location == "10 DEWOLFE STREET") %>% 
  mutate(at_least_one_w = ifelse(avail_wash >= 1, 1, 0),
         at_least_one_d = ifelse(avail_wash >= 1, 1, 0)) %>% 
  group_by(time, at_least_one_w) %>% 
  summarise(at_least_1_w = n()) %>% 
  filter(at_least_one_w == 1) %>% 
  ungroup() %>% 
  select(at_least_1_w)

f <- subset(full_data, day == 4 & location == "10 DEWOLFE STREET") %>% 
  mutate(at_least_one_w = ifelse(avail_wash >= 1, 1, 0),
         at_least_one_d = ifelse(avail_wash >= 1, 1, 0)) %>% 
  group_by(time, at_least_one_d) %>% 
  summarise(at_least_1_d = n()) %>% 
  filter(at_least_one_d == 1) %>% 
  ungroup() %>% 
  select(at_least_1_d)


bound_data <-  cbind(d, e, f) 

bound_data %>% 
  mutate(proportion_w = at_least_1_w/total,
         proportion_d = at_least_1_d/total) %>% 
  mutate(w = case_when(
    proportion_w == 1 ~ 0.99,
    TRUE ~ proportion_w
  ),
  d = case_when(
    proportion_d == 1 ~ 0.99,
    TRUE ~ proportion_d
  )) %>% 
  ggplot(aes(x = time, y = w, fill = w)) +
  geom_col() %>% 
  labs(
    title = "Likelihood of At Least 1 Washing Machine Being Open"
  ) +
  ylab(
    "Likelihood"
  ) +
  xlab(
    "Time"
  )
