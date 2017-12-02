library(data.table)
library(dplyr)
library(ggplot2)

if(!file.exists("project2.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                  destfile = "project2.zip")
}
unzip("project2.zip")

if(!exists("SCC_map")) {
    SCC_map <- as.data.table(readRDS("Source_Classification_Code.rds"))
}

if(!exists("NEI_data")) {
    NEI_data <- as.data.table(readRDS("summarySCC_PM25.rds"))
}

if(!exists("NEI_SCC_data")) {
    NEI_SCC_data <- merge(NEI_data, SCC_map,  by="SCC")
}

los_bal_data <- filter(NEI_SCC_data, fips == "24510" | fips == "06037")
vehicle_bol <- grepl("vehicle", los_bal_data$EI.Sector, ignore.case = TRUE)
los_bal_vehicle_data <- los_bal_data[vehicle_bol, ]
los_bal_vehicle_data$fips <- gsub("24510", "Baltimore City", los_bal_vehicle_data$fips)
los_bal_vehicle_data$fips <- gsub("06037", "Los Angeles County", los_bal_vehicle_data$fips)
png("plot6.png", width = 480, height = 480)
plot6 <- ggplot(los_bal_vehicle_data, aes(factor(year), Emissions, fill = fips)) +
    facet_grid(.~fips) +
    geom_bar(stat = "identity",show.legend = FALSE) +
    labs(x = "Year") +
    labs(y = expression(paste(PM[2.5], " Emissions (tons)"))) +
    labs(title = "Total Motor Vehicle Emissions for Baltimore and Los Angeles")
print(plot6)
dev.off()