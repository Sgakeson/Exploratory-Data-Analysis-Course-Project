library(dplyr)
library(ggplot2)
Pollutants <- readRDS("PM25.rds")
Sources <- readRDS("Source.rds")

Source_Coal <- Sources[grep("[Cc]oal", Sources$EI.Sector),]
Pollutants_Coal <- subset(Pollutants, Pollutants$SCC %in% Source_Coal$SCC)

Source_Pollutants_Coal <- merge(Sources, Pollutants_Coal, by.x = "SCC", by.y = "SCC")

Source_Pollutants_Coal_Total <- Source_Pollutants_Coal %>% group_by(year) %>% summarize(Total_Coal = sum(Emissions, na.rm = TRUE))

plot <- ggplot(data = Source_Pollutants_Coal_Total, aes(year, Total_Coal))

plot <- plot + geom_point(color = "purple", size = 3.267, alpha = 0.625) + xlab("Year") + ylab("Total Emissions (tonnes)") + ggtitle("Total Annual Coal Combustion Emissions")
png("plot4.png")
plot
dev.off()