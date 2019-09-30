install.packages(c("dplyr", "devtools", "rstudioapi", "tidyverse","rvest","httr","readxl","janitor","glue","Hmisc"), dependencies=TRUE, repos=c("http://rstudio.org/_packages", "http://cran.rstudio.com"))
devtools::install_github(repo = "FantasyFootballAnalytics/ffanalytics", build_vignettes = TRUE)
