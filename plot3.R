library(dplyr)
library(ggplot2)
Pollutants <- readRDS("summarySCC_PM25.rds")
Sources <- readRDS("Source_Classification_Code.rds")

baltimore_yearly_type_emmisions <- Pollutants %>% subset(fips == '24510') %>% group_by(year, type) %>% summarise(type_emmisions = sum(Emissions, na.rm = TRUE))

type_plot <- ggplot(data = baltimore_yearly_type_emmisions, aes(year, type_emmisions))
type_plot <- type_plot + geom_point(color = "purple", size = 3.267, alpha = 0.625) +facet_grid(. ~ type) + xlab("Year") + ylab("Total Emissions (tonnes)") + ggtitle("Total Annual Emissions in Baltimore by Year and Type")
png("plot3.png")       
type_plot
dev.off()