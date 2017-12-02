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

baltimore_data <- filter(NEI_SCC_data, fips == "24510")
vehicle_bol <- grepl("vehicle", baltimore_data$EI.Sector, ignore.case = TRUE)
baltimore_vehicle_data <- baltimore_data[vehicle_bol, ]
png("plot5.png", width = 480, height = 480)
plot5 <- ggplot(baltimore_vehicle_data, aes(factor(year), Emissions)) +
    geom_bar(stat = "identity", fill = "deepskyblue4", show.legend = FALSE) +
    labs(x = "Year") +
    labs(y = expression(paste(PM[2.5], " Emissions (tons)"))) +
    labs(title = "Total Motor Vehicle Emissions for Baltimore, Maryland")
print(plot5)
dev.off()