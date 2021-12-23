## FAS1002 - Projet Final ##
# Script de téléchargement des données initiales: RAW

# 1 Our World in Data (OWID)
# 1.1 Données de vaccination covid-19

library(lubridate)
library(tidyverse)

ListeVac <- list.files("Data/Raw/", pattern = "Vaccination")
DateVac <- as_date(str_extract(ListeVac,"\\d{4}-\\d{2}-\\d{2}"), tz = NULL)

if(DateVac != Sys.Date()){
    download.file("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv",
                  destfile = paste0("./Data/Raw/Vaccination", Sys.Date(), ".csv"))
    file.remove(paste0("./Data/Raw/Vaccination", DateVac, ".csv"))
    }
        
# 2 Gapminder
# 2.1 Données de la population

ListePop <- list.files("Data/Raw/", pattern = "GapminderPop")
DatePop <- as.Date(str_extract(ListeVac,"\\d{4}-\\d{2}-\\d{2}" ))
DatePopMois <- DatePop + months(1)

if(DatePopMois < Sys.Date()){
    download.file("https://docs.google.com/spreadsheets/d/14_suWY8fCPEXV0MH7ZQMZ-KndzMVsSsA5HdR-7WqAC0/export?format=xlsx",
                               destfile = paste0("./Data/Raw/GapminderPop", Sys.Date(), ".xlsx"))
    file.remove(paste0("./Data/Raw/GapminderPop", DatePop, ".xlsx"))
}

# 2.2 Données de P.I.B. (G.D.P.)
ListeGDP <- list.files("Data/Raw/", pattern = "GapminderGDP")
DateGDP <- as.Date(str_extract(ListeVac,"\\d{4}-\\d{2}-\\d{2}" ))
DateGDPMois <- DateGDP + months(1)
    
if(DateGDPMois < Sys.Date()){
        download.file("https://docs.google.com/spreadsheets/d/1h3z8u0ykcUum8P9FV8EHF9fszDYr7iPDZQ-fgE3ecls/export?format=xlsx",
                      destfile = paste0("./Data/Raw/GapminderGDP", Sys.Date(), ".xlsx"))
    file.remove(paste0("./Data/Raw/GapminderGDP", DateGDP, ".xlsx"))
}

# Enlever les objets qui ne seront pas réutilisés
rm(DateGDP, DateGDPMois, DatePop, DatePopMois, DateVac, ListeGDP, ListePop, ListeVac)

# Fin
print("Mise-à-jour effectuée. Fin des téléchargements")
