library(readr);
library(ggplot2);

GDP_vs_MedalCount <- read.csv("derived_data/GDP_vs_MedalCount.csv");
GDP_vs_Ratio <- read.csv("derived_data/GDP_vs_Ratio.csv");
Pollution_vs_MedalCount <- read.csv("derived_data/Pollution_vs_MedalCount.csv");
Pollution_vs_Ratio <- read.csv("derived_data/Pollution_vs_Ratio.csv");
MedalCount_China <- read.csv("derived_data/MedalCount_China.csv");
MedalCount_Russia_All <- read.csv("derived_data/MedalCount_Russia_All.csv");
MedalCount_USA <- read.csv("derived_data/MedalCount_USA.csv");
MedalCount_GBR <- read.csv("derived_data/MedalCount_GBR.csv");
MedalCount_GER <- read.csv("derived_data/MedalCount_GER.csv");

p1 <- ggplot(GDP_vs_MedalCount, aes(x=gdp, y=medal_count)) + geom_point();

p2 <- ggplot(GDP_vs_Ratio, aes(x=gdp, y=ratio)) + geom_point();

p3 <- ggplot(Pollution_vs_MedalCount, aes(x=death_rate, y=medal_count)) +geom_point();

p4 <- ggplot(Pollution_vs_Ratio, aes(x=death_rate, y=ratio)) + geom_point();

p5 <- ggplot(MedalCount_China, aes(x=year, y=medal_count)) + geom_line() + geom_vline(xintercept=1988);

p6 <- ggplot(MedalCount_Russia_All, aes(x=year, y=medal_count)) + geom_line() + geom_point() + geom_vline(xintercept=1991);

p7 <- ggplot(MedalCount_USA, aes(x=year, y=medal_count)) + geom_line() + geom_vline(xintercept=c(1904, 1932, 1984, 1996));

p8 <- ggplot(MedalCount_GBR, aes(x=year, y=medal_count)) + geom_line() + geom_vline(xintercept=c(1908, 1948, 2012));

p9 <- ggplot(MedalCount_GER, aes(x=year, y=medal_count)) + geom_line() + geom_vline(xintercept=c(1936, 1972));

ensure_directory("figures");
ggsave("figures/GDP_vs_MedalCount.png", plot=p1);
ggsave("figures/GDP_vs_Ratio.png", plot=p2);
ggsave("figures/Pollution_vs_MedalCount.png", plot=p3);
ggsave("figures/Pollution_vs_Ratio.png", plot=p4);
ggsave("figures/China_Medals.png", plot=p5);
ggsave("figures/Russia_Medals.png", plot=p6);
ggsave("figures/USA_Medals.png", plot=p7);
ggsave("figures/GBR_Medals.png", plot=p8);
ggsave("figures/GER_Medals.png", plot=p9)








