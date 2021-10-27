FROM rocker/verse
RUN apt update && apt-get install -y python3-pip
RUN pip3 install --pre --user hy
RUN pip3 install beautifulsoup4 theano keras sklearn pandas numpy pandasql
RUN R -e "install.packages(c(\"shiny\",\"deSolve\",\"signal\"))"
RUN R -e "install.packages(\"Rcpp\")";
RUN R -e "install.packages(\"reticulate\")";
RUN R -e "install.packages(\"ppclust\")";
RUN R -e "install.packages(\"readr\")";
RUN R -e "install.packages(\"dplyr\")";
RUN R -e "install.packages(\"ggplot2\")";
RUN R -e "install.packages(\"tidyr\")";
