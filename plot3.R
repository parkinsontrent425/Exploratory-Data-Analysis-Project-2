library(data.table)

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

library(dplyr)

baltimore_data <- filter(NEI_data, fips == "24510")

library(ggplot2)

png("plot3.png", width = 480, height = 480)
plot3 <- ggplot(baltimore_data, aes(factor(year), Emissions, fill = type)) +
    facet_grid(.~type) +
    geom_bar(stat = "identity", show.legend = FALSE) +
    labs(title = expression(paste("Total Emissions in Baltimore, Maryland for ",
                                  PM[2.5], " by Type"))) +
    labs(x = "Year") +
    labs(y = expression(paste(PM[2.5], " Emissions (tons)")))
print(plot3)
dev.off()