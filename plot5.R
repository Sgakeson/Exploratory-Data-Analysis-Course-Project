library(dplyr)
library(ggplot2)
Pollutants <- readRDS("PM25.rds")
Sources <- readRDS("Source.rds")

vehicle_emmisions <- Sources[grep("[Vv]ehicle", Sources$Short.Name),]

baltimore_vehicle_emmisions <- Pollutants %>% subset(fips == "24510" & Pollutants$SCC %in% vehicle_emmisions$SCC) %>% merge(y = vehicle_emmisions, by.x = "SCC", by.y = "SCC") %>% group_by(year) %>% summarise(Vehicle_emmisions_Baltimore = sum(Emissions, na.rm = TRUE))

plot <- ggplot(data = baltimore_vehicle_emmisions, aes(year, Vehicle_emmisions_Baltimore))

plot <- plot + geom_point(color = "purple", size = 3.267, alpha = 0.625) + xlab("Year") + ylab("Total Emissions (tonnes)") + ggtitle("Vehicle Emmisions, Baltimore")

png("plot5.png")
plot
dev.off()