# Bios-611-Project

Welcome to my project on data in the Olympics. In this project, we have data on all of the athletes who competed in the Olympics this past century. It shows what years they competed, what medals they won, what team they are in, what gender they are, etc. In this project, we will be using the Olympics data along  with some other datasets to see what associations we can find, especially ones that involve number of medals a country wins in a given year. Let's get started.

## Docker

In the VCL terminal, run the following code to build the docker:
```
git clone https://github.com/GaryLuUNC/bios-611-project.git

cd bios-611-project

docker build . -t project-env

docker run -v $(pwd):/home/rstudio/project \
-p 8787:8787 \
-p 8722:22 \
-e PASSWORD=hello123 \ 
-it project-env \bin\bash
```

## Makefile

After you built and ran the docker, you should be inside the root in the terminal. Before you run make, you need to transfer ownership of the files to the RStudio user:

```
chown -R 755 /home/rstudio/project
```

Now, you can run Makefile in the RStudio terminal. You can start the RStudio terminal in VCL by running 

```
cd /home/rstudio/project
```

To run Makefile, you use the ```make``` command and you type what file you want to make. For example, ```make derived_data/GDP_vs_MedalCount.csv```. You can also run ```make clean``` to clear everything Makefile created.

## Shiny

This interactive visualization allows you to choose a year on the slider that a Summer Olympics took place in and the bar plot will show how many medals each country won in the Summer Olympics in that year. You can also select boxes to select properties so that only the medals that satisfy these properties will be included in the plot. You can also decide whether or not to include all countries or only those countries that were in all of the Summer Olympics from 1976 to 2008.

To run the visualization:

1. Download Shiny.R and Summer-Olympic-medals-1976-to-2008.csv from this repository. If you are on github.com, you can do it by clicking on Code above the repository and then clicking on Download ZIP.
2. Open up RStudio.
3. Run the line of code getwd() in RStudio to see which folder does R look for files.
4. Save Shiny.R and Summer-Olympic-medals-1976-to-2008.csv to said folder.
5. Open up Shiny.R in RStudio and run the script.

Note: It is recommended that you view this visualization in full screen.

