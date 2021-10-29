library(ggplot2);
library(readr);

source("DataSets611.R");

MedalCount_vs_GDP <- read.csv("derived_data/MedalCount_vs_GDP.csv");
MedalCount_vs_GDP <- read.csv("derived_data/gdp_ratio_vs_medal_count_ratio.csv");

gdp_vs_medalcount <- ggplot(MedalCount_vs_GDP, aes(x=GDP, y=medal_count)) + geom_point();

gdp_ratio_vs_medal_count_ratio <- ggplot(MedalCountRatio_vs_GDPRatio, aes(x=gdp_ratio, y=medal_count_ratio)) + geom_point();

ensure_directory("figures");
ggsave("figures/gdp_vs_medalcount.png", gdp_vs_medalcount);
ggsave("figures/gdp_ratio_vs_medal_count_ratio.png", gdp_ratio_vs_medal_count_ratio)
