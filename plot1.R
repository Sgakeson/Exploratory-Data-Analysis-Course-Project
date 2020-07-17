library(dplyr)
library(ggplot2)
Pollutants <- readRDS("summarySCC_PM25.rds")
Sources <- readRDS("Source_Classification_Code.rds")

by_year_total_emmisions <- Pollutants %>% group_by(year) %>% summarise(total_emmisions = sum(Emissions, na.rm = TRUE))

png("plot1.png")
plot(by_year_total_emmisions$year, by_year_total_emmisions$total_emmisions, pch = 120, col = "#660099", xlab = 'Year', ylab = 'Total pm25 (tonnes)', main = 'Total Yearly Emmisions', cex = 1.53)
dev.off()
