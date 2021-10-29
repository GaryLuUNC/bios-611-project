PHONY: clean

clean:
	rm derived_data/*
	rm figures/*
  
derived_data/project_data.csv derived_data/MedalCount_vs_GDP.csv derived_data/MedalCountRatio_vs_GDPRatio.csv:
  Summer-Olympic-medals-1976-to-2008.csv gdp_csv.csv DataSets611.R
	Rscript DataSets611.R
	
figures/gdp_vs_medalcount.png figures/gdp_ratio_vs_medal_count_ratio.png: Summer-Olympic-medals-1976-to-2008.csv gdp_csv.csv DataSets611.R derived_data/MedalCount_vs_GDP.csv
	derived_data/MedalCountRatio_vs_GDPRatio.csv GDP_vs_MedalCount.R
	Rscript GDP_vs_MedalCount.R
	
