# install and load ggplot

install.packages("ggplot2")
library(ggplot2)

#Code
## Setup ggplot with data frame
g <- ggplot(base, aes(varX, varY))

## Add layer
g + geom_points(alpha = 1/3)
  + facet_wrap(cat1 ~ cat2, nrow = 2, ncol = 4)
  + geom_smooth(method = "lm", se = FLASE, col = "steelblue")
  + theme_bw(base_family = "Avenir", base_size = 10)
  + labs(x = expression("log " * PM[2.5]))
  + labs(y = "Nocturnal Symptoms")
  + labs(title = "Fancy title for the facet graph")
