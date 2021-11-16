PHONY: clean

clean:
	rm derived_data/*
	rm figures/*
  
derived_data/Athlete_Data.csv:\
 source_data/athlete_events.csv source_data/death-rates-from-air-pollution.csv\
 source_data/gdp_csv.csv DataSets611.R
 Rscript DataSets611.R

figures/China_Medals.png:\ 
 source_data/athlete_events.csv source_data/death-rates-from-air-pollution.csv\
 source_data/gdp_csv.csv DataSets611.R Figures611.R
 Rscript Figures611.R
	
