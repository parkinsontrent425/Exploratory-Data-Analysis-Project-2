library(data.table)
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

coal_bol <- grepl("coal",NEI_SCC_data$EI.Sector, ignore.case = TRUE)
coal_subset <- NEI_SCC_data[coal_bol, ]
comb_bol <- grepl("comb", coal_subset$EI.Sector, ignore.case = TRUE)
coal_comb_subset <- coal_subset[comb_bol, ]
png("plot4.png", width = 480, height = 480)
plot4 <- ggplot(coal_comb_subset, aes(factor(year), Emissions/1000)) +
    geom_bar(stat = "identity", fill = "deepskyblue4", show.legend = FALSE) +
    labs(x = "Year") +
    labs(y = expression(paste(PM[2.5], " Emissions (",10^3," tons)"))) +
    labs(title = "Total Coal Combustion Emissions for the USA")
print(plot4)
dev.off()