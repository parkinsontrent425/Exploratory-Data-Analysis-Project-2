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
baltimore_totals <- aggregate(Emissions ~ year, data = baltimore_data, sum)
png("plot2.png", width = 480, height = 480)
par(mar = c(4.1,4.5,2,1))
barplot(baltimore_totals$Emissions/(10^3),
        names.arg = baltimore_totals$year,
        xlab = "Year",
        ylab = expression(paste(PM[2.5], " Emissions (",10^3," tons)")),
        main = expression(paste("Total Emissions in Baltimore, Maryland for ",PM[2.5])),
        col = "#003366")
dev.off()