library(dplR)
library(ggplot2)
library(dplyr)
library(reshape2)

series <- read.fh("data/Release_CUY_GEP.fh")

# 5 missing sapwood rings in CUY0109 series[71:75,2]


spag.plot(series)

series_tib <- tibble(series)
series_tib$year <- as.numeric(rownames(series))

ggplot(series_tib, aes(x=year, y=GEP00281)) + geom_line()

series_melt <- melt(series_tib, id.vars ="year", value.name = "ringwidth", variable.name = "series")

ggplot(series_melt, aes(year,ringwidth, col=series)) +
  geom_point(size = 0.75) + geom_line() + ylab("tree-ring width (mm)")

ggplot(series_melt, aes(year,ringwidth, col=series)) +
  geom_point(size = 0.75) + geom_line() + ylab("tree-ring width (mm)") +
  ylim(0,6) + annotate("rect", xmin = 323, xmax = 330, ymin = 0, ymax = 6, alpha = .3) +
  theme(legend.position = c(0.1,0.85))
ggsave("export/CUY_GEP_growth_release.png", width = 8, height = 6)



