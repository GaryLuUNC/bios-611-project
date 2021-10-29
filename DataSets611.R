library(readr);
library(dplyr);
source("utils.R");

Medal_Data <- read.csv("Summer-Olympic-medals-1976-to-2008.csv");

GDP_Data <- read.csv("gdp_csv.csv")

names(Medal_Data) <- simplify_strings(names(Medal_Data));
names(GDP_Data) <- simplify_strings(names(GDP_Data));
GDP_Data <- GDP_Data %>% select(-country_name) %>% rename(GDP=value);

Medal_Data_WithGDP <- Medal_Data %>% inner_join(GDP_Data, by=c("year", "country_code")) %>% select(-athlete);

ensure_directory("derived_data");
write_csv(Medal_Data_WithGDP, "derived_data/project_data.csv")