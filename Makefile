PHONY: clean

clean:
	rm derived_data/*
	rm figures/*
	rm report.pdf

derived_data/GDP_vs_MedalCount.csv\
derived_data/GDP_vs_Ratio.csv\
derived_data/Pollution_vs_MedalCount.csv\
derived_data/Pollution_vs_Ratio.csv\
derived_data/MedalCount_China.csv\
derived_data/MedalCount_Russia_All.csv\
derived_data/MedalCount_USA.csv\
derived_data/MedalCount_GBR.csv\
derived_data/MedalCount_GER.csv:\
source_data/athlete_events.csv\
source_data/death-rates-from-air-pollution.csv\
source_data/gdp_csv.csv\
utils.R\
DataSets611.R
	Rscript DataSets611.R

figures/GDP_vs_MedalCount.png\
figures/GDP_vs_Ratio.png\
figures/Pollution_vs_MedalCount.png\
figures/Pollution_vs_Ratio.png\
figures/China_Medals.png\
figures/Russia_Medals.png\
figures/USA_Medals.png\
figures/GBR_Medals.png\
figures/GER_Medals.png:\
derived_data/GDP_vs_MedalCount.csv\
derived_data/GDP_vs_Ratio.csv\
derived_data/Pollution_vs_MedalCount.csv\
derived_data/Pollution_vs_Ratio.csv\
derived_data/MedalCount_China.csv\
derived_data/MedalCount_Russia_All.csv\
derived_data/MedalCount_USA.csv\
derived_data/MedalCount_GBR.csv\
derived_data/MedalCount_GER.csv\
Figures611.R
	Rscript Figures611.R

report.pdf:\
source_data/athlete_events.csv\
source_data/gdp_csv.csv\
source_data/death-rates-from-air-pollution.csv\
preamble.tex\
figures/GDP_vs_MedalCount.png figures/GDP_vs_Ratio.png\
figures/Pollution_vs_MedalCount.png\
figures/Pollution_vs_Ratio.png\
figures/China_Medals.png\
figures/Russia_Medals.png\
figures/USA_Medals.png\
figures/GBR_Medals.png\
figures/GER_Medals.png\
report.Rmd
	Rscript -e 'rmarkdown::render("report.Rmd")'
