library(dplyr)
library(ggplot2)
Pollutants <- readRDS("summarySCC_PM25.rds")
Sources <- readRDS("Source_Classification_Code.rds")

vehicle_emmisions <- Sources[grep("[Vv]ehicle", Sources$Short.Name),]

baltimore_vehicle_emmisions <- Pollutants %>% subset(fips == "24510" & Pollutants$SCC %in% vehicle_emmisions$SCC) %>% merge(y = vehicle_emmisions, by.x = "SCC", by.y = "SCC") %>% group_by(year) %>% summarise(Vehicle_emmisions_Baltimore = sum(Emissions, na.rm = TRUE))

LA_vehicle_emmisions <- Pollutants %>% subset(fips == "06037" & Pollutants$SCC %in% vehicle_emmisions$SCC) %>% merge(y = vehicle_emmisions, by.x = "SCC", by.y = "SCC") %>% group_by(year) %>% summarise(Vehicle_emmisions_LA = sum(Emissions, na.rm = TRUE))

City_comparrison_plot <- ggplot(data = baltimore_vehicle_emmisions, aes(year, Vehicle_emmisions_Baltimore)) + geom_point(aes(year, Vehicle_emmisions_Baltimore, color = "Baltimore"), pch = 120, size = 3.267, alpha = 0.625) + geom_point(data = LA_vehicle_emmisions, aes(year, Vehicle_emmisions_LA, color = "LA"), pch = 120, size = 3.267, alpha = 0.625)+ ggtitle("Comparison of LA and Baltimore Motor Vehicle Emmisions") + xlab("Year") + ylab("Total Emmisions (tonnes)") + theme() + labs(color = "Cities") + scale_color_manual(values = c("Dark Green","Purple"))
png("plot6.png")
City_comparrison_plot
dev.off()