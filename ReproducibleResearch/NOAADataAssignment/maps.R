#install.packages("usmap")
#install.packages("cowplot")
#install.packages("ggplot2")
library(cowplot)
library(usmap)
library(ggplot2)


StateFatalitiesEvent <- aggregate(FATALITIES~state, StormDataSelected[StormDataSelected$FATALITIES > 0,], sum)
StateInjuriesEvent <- aggregate(INJURIES~state, StormDataSelected[StormDataSelected$INJURIES > 0,], sum)
StatePropCost <- aggregate(PropetyDMG~state, StormDataSelected[StormDataSelected$PropetyDMG > 0,], sum)
StateCropCost <- aggregate(CropDMG~state, StormDataSelected[StormDataSelected$CropDMG > 0,], sum)

FatalitiesEvent

statepop




map1 <- usmap::plot_usmap(data = StateFatalitiesEvent, values = "FATALITIES", lines = "black") +
  scale_fill_continuous(name = "Fatalities",type = "viridis") +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5)) +
  labs(title = "Fatalities")

map2 <- usmap::plot_usmap(data = StateInjuriesEvent, values = "INJURIES", lines = "black") +
  scale_fill_continuous(name = "Injuries",type = "viridis") +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5)) +
  labs(title = "Injuries")


map3 <- usmap::plot_usmap(data = StatePropCost, values = "PropetyDMG", lines = "black") +
  scale_fill_continuous(name = "Property cost",type = "viridis", label = scales::dollar) +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5)) +
  labs(title = "Property cost")

map4 <- usmap::plot_usmap(data = StateCropCost, values = "CropDMG", lines = "black") +
  scale_fill_continuous(name = "",type = "viridis", label = scales::dollar) +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5)) +
  labs(title = "Crop cost")

# Combine plots ####
title <- cowplot::ggdraw() +
  draw_label("Summary of catastrophic weather events in the US, 1950 - 2011",
             fontface = 'bold')

maps <- plot_grid(
  map1,
  map2,
  map3,
  map4,
  nrow = 2
)

cowplot::plot_grid(title, maps, ncol = 1,rel_heights = c(0.1, 1))

# Save plots ####
cowplot::ggsave("./data/maps.png", width = 18, height = 10, units = "in")
