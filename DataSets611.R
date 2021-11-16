library(readr);
library(dplyr);
source("utils.R");

Athlete_Data <- read.csv("source_data/athlete_events.csv");

GDP_Data <- read.csv("source_data/gdp_csv.csv");

Pollution_Data <- read.csv("source_data/death-rates-from-air-pollution.csv");

names(Athlete_Data) <- simplify_strings(names(Athlete_Data));
names(GDP_Data) <- simplify_strings(names(GDP_Data));
names(Pollution_Data) <- simplify_strings(names(Pollution_Data));

Medal_Data<-Athlete_Data %>% filter(season=="Summer" & !is.na(medal)) %>% rename(country_code=noc)

GDP_Data <- GDP_Data %>% rename(gdp=value);
Pollution_Data <- Pollution_Data %>% rename(country_code=code)

Pollution_Data <- Pollution_Data %>% rename(death_rate=deaths_air_pollution_sex_both_age_age_standardized_rate_) %>% select(country_code, year, death_rate)

MedalCount <- Medal_Data %>% group_by(country_code, year) %>% summarise(medal_count=n()); 

GDP_vs_MedalCount <- MedalCount %>% inner_join(GDP_Data, by=c("country_code", "year"));

Athlete_Count<-Athlete_Data %>% group_by(year, noc) %>% summarise(athlete_count=n()) %>% rename(country_code=noc);

GDP_vs_Ratio <- GDP_vs_MedalCount %>% inner_join(Athlete_Count, by=c("year", "country_code")) %>% mutate(ratio=medal_count/athlete_count);

Pollution_vs_MedalCount <- MedalCount %>% inner_join(Pollution_Data, by=c("country_code", "year"));

Pollution_vs_Ratio <- Pollution_vs_MedalCount %>% inner_join(Athlete_Count, by=c("year", "country_code")) %>% mutate(ratio=medal_count/athlete_count);

MedalCount_China <- MedalCount %>% filter(country_code == "CHN")

MedalCount_USSR <- MedalCount %>% filter(country_code=="URS");
MedalCount_Russia <- MedalCount %>% filter(country_code=="RUS");
MedalCount_Russia_All <- rbind(MedalCount_USSR, MedalCount_Russia);

MedalCount_USA <- MedalCount %>% filter(country_code=="USA");

MedalCount_GBR <- MedalCount %>% filter(country_code=="GBR");

MedalCount_GER <- MedalCount %>% filter(country_code=="GER");

ensure_directory("derived_data");
write_csv(GDP_vs_MedalCount, "derived_data/GDP_vs_MedalCount.csv");
write_csv(GDP_vs_Ratio, "derived_data/GDP_vs_Ratio.csv");
write_csv(Pollution_vs_MedalCount, "derived_data/Pollution_vs_MedalCount.csv");
write_csv(Pollution_vs_Ratio, "derived_data/Pollution_vs_Ratio.csv");
write_csv(MedalCount_China, "derived_data/MedalCount_China.csv");
write_csv(MedalCount_Russia_All, "derived_data/MedalCount_Russia_All.csv");
write_csv(MedalCount_USA, "derived_data/MedalCount_USA.csv");
write_csv(MedalCount_GBR, "derived_data/MedalCount_GBR.csv");
write_csv(MedalCount_GER, "derived_data/MedalCount_GER.csv")
