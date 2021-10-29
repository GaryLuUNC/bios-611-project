library(ggplot2);
source("DataSets611.R");

MedalCount <- Medal_Data %>% group_by(country_code, year) %>% summarise(medal_count=n()); 

MedalCount_vs_GDP <- MedalCount %>% inner_join(GDP_Data, by=c("country_code", "year"));

MedalCount_vs_GDP_First_And_Last_Year <- MedalCount_vs_GDP %>% group_by(country_code) %>% mutate(min_year_by_country=min(year, na.rm = TRUE), 
                                                                                                 max_year_by_country=max(year, na.rm = TRUE)) %>%
  filter(year==min_year_by_country | year==max_year_by_country) %>% arrange(country_code, year, ascending=TRUE);

MedalCountRatio_vs_GDPRatio <- MedalCount_vs_GDP_First_And_Last_Year %>% filter(min_year_by_country != max_year_by_country) %>% 
  mutate(GDP_2 = lag(GDP), medal_count_2=lag(medal_count)) %>% filter(year==max_year_by_country) %>% 
  mutate(medal_count_ratio=medal_count_2/medal_count, gdp_ratio=GDP_2/GDP) %>% select(country_code, medal_count_ratio, gdp_ratio);

gdp_vs_medalcount <- ggplot(MedalCount_vs_GDP, aes(x=GDP, y=medal_count)) + geom_point();

gdp_ratio_vs_medal_count_ratio <- ggplot(MedalCountRatio_vs_GDPRatio, aes(x=gdp_ratio, y=medal_count_ratio)) + geom_point();


ensure_directory("figures");
ggsave("figures/gdp_vs_medalcount.png", gdp_vs_medalcount);
ggsave("figures/gdp_ratio_vs_medal_count_ratio.png", gdp_ratio_vs_medal_count_ratio)