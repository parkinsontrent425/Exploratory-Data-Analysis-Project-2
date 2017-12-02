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

totals_year <- aggregate(Emissions ~ year, data = NEI_data, sum)
png("plot1.png", width = 480, height = 480)
par(mar = c(4.1,4.5,2,1))
barplot(totals_year$Emissions/(10^6),
        names.arg = totals_year$year,
        xlab = "Year",
        ylab = expression(paste(PM[2.5], " Emissions (",10^6," tons)")),
        main = expression(paste("Total Emissions in the USA for ",PM[2.5])),
        col = "#003366")
dev.off()