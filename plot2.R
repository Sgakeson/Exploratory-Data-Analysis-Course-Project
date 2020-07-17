library(dplyr)
library(ggplot2)
Pollutants <- readRDS("PM25.rds")
Sources <- readRDS("Source.rds")

baltimore_yearly_total_emmisions <- Pollutants %>% subset(fips == '24510') %>% group_by(year) %>% summarise(total_emmisions = sum(Emissions, na.rm = TRUE))

png("plot2.png")
plot(baltimore_yearly_total_emmisions$year, baltimore_yearly_total_emmisions$total_emmisions, pch = 120, col = "#660099", xlab = 'Year', ylab = 'Total pm25 (tonnes)', main = 'Baltimore Total Yearly Emmisions', cex = 1.53)
dev.off()