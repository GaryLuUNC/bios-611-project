library(readr);
library(dplyr);
source("utils.R");

Medal_Data <- read.csv("Summer-Olympic-medals-1976-to-2008.csv");

GDP_Data <- read.csv("gdp_csv.csv")

names(Medal_Data) <- simplify_strings(names(Medal_Data));
names(GDP_Data) <- simplify_strings(names(GDP_Data));
GDP_Data <- GDP_Data %>% select(-country_name) %>% rename(GDP=value);

Medal_Data_WithGDP <- Medal_Data %>% inner_join(GDP_Data, by=c("year", "country_code")) %>% select(-athlete);

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

ensure_directory("derived_data");
write_csv(Medal_Data_WithGDP, "derived_data/project_data.csv");
write_csv(MedalCount_vs_GDP, "derived_data/MedalCount_vs_GDP.csv");
write_csv(MedalCountRatio_vs_GDPRatio, "derived_data/MedalCountRatio_vs_GDPRatio.csv")
