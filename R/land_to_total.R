library(tidyverse)

plotTheme <- theme(
  plot.title =element_text(size=12),
  plot.subtitle = element_text(size=8),
  plot.caption = element_text(size = 6),
  axis.text.x = element_text(size = 10, angle = 45, hjust = 1),
  axis.text.y = element_text(size = 10),
  axis.title.y = element_text(size = 10),
  # Set the entire chart region to blank
  panel.background=element_blank(),
  plot.background=element_blank(),
  #panel.border=element_rect(colour="#F0F0F0"),
  # Format the grid
  panel.grid.major=element_line(colour="#D0D0D0",size=.75),
  axis.ticks=element_blank())

properties <- read.csv("https://opendata-downloads.s3.amazonaws.com/opa_properties_public.csv")

properties %>% 
  filter(str_detect(zoning, "RSA") == TRUE) %>%
  #mutate(taxable_land = ifelse(taxable_land == 0, 0.01, taxable_land)) %>%
  filter(taxable_land > 0) %>%
  mutate(land_to_value = taxable_land / market_value) %>% 
  dplyr::select(land_to_value, zoning) %>%
  ggplot()+ 
  geom_histogram(aes(land_to_value), binwidth = 0.05, alpha = 0.7, fill = "blue")+
  facet_wrap(~zoning, scales = "free_y")+
  labs(title="Ratio of Taxable Land to Total Assessment - RSA Properties - 2022 Phila. OPA Assessments",
       subtitle = "Data: Philadelphia OPA, 5/9/2022. n = 542,272. Excludes Tax Exempt Land (n = 38,540)\nAnalysis by Michael Fichman, PennPraxis / Weitzman School of Design - mfichman@upenn.edu",
       x="Taxable Land / Total Taxable Value", 
       y="Number of Properties")+
  plotTheme
