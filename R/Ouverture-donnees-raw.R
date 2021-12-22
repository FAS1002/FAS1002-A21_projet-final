# FAS1002 - Projet final
## Ouverture et manipulation des banques de données
## Ouvrir/exécuter ce document après le script de téléchargement (mise-à-jour)

# Utilisation de readxl
library(tidyverse)
library(lubridate)

# 1 OUVERTURE DES DONNÉES
# 1.1 OWID 
# 1.1.1 Données de vaccination

# Aller chercher le nom du fichier qui change en fonction de la date
# Avant de l'ouvrir
VacFile <- list.files("Data/Raw/", pattern = "Vaccination")
DataVaccin <- read.csv(paste0("./Data/Raw/", VacFile), stringsAsFactors = TRUE)


# 1.2 Gapminder
# 1.2.1 Données de population

# Aller chercher le nom du fichier qui change en fonction de la date
# Avant de l'ouvrir
PopFile <- list.files("Data/Raw/", pattern = "GapminderPop")

# Lire les différentes feuilles du fichier excel
# Attribuer un objet par feuille
DataGapWorldPop <- read_excel(paste0("./Data/Raw/", PopFile), sheet = 2)
DataGapRegionPop <- read_excel(paste0("./Data/Raw/", PopFile), sheet = 3)
DataGapCountriesPop <- read_excel(paste0("./Data/Raw/", PopFile), sheet = 4)

# 1.2.2 Données de PIB

# Aller chercher le nom du fichier qui change en fonction de la date
# Avant de l'ouvrir
GDPFile <- list.files("Data/Raw/", pattern = "GapminderGDP")

# Lire les différentes feuilles du fichier excel
# Attribuer un objet par feuille
DataGapWorldGDP <- read_excel(paste0("./Data/Raw/", GDPFile), sheet = 2)
DataGapRegionGDP <- read_excel(paste0("./Data/Raw/", GDPFile), sheet = 3)
DataGapCountriesGDP <- read_excel(paste0("./Data/Raw/", GDPFile), sheet = 4)

# 2 Manipulation des données
# 2.1 OWID
# 2.1.1 Données de vaccination

# Changer le titre de la colonne iso_code
# Mettre même titre que celui utilisé par Gapminder
DataVaccin <- rename(DataVaccin, geo = iso_code)
# Changer le format pour une date
DataVaccin$date <- as_date(DataVaccin$date)

#Obtenir les quantités de vaccins par région
RegionVaccin <- subset(DataVaccin, geo=="OWID_AFR" | geo=="OWID_ASI" | geo=="OWID_EUR" | geo=="OWID_NAM" | geo=="OWID_OCE" | geo=="OWID_SAM")

 
# Mettre les données mondiales dans un autre objet avant de les enlever
# Enlever la colonne geo (info. redondante)
# location gardée pour le moment au cas où serait utile
WorldVaccine <- subset(DataVaccin, geo == "OWID_WRL")
WorldVaccine <- subset(WorldVaccine, select = -c(2))

# Utiliser stringr pour sélectionner les codes iso (geo) OWID
# qui correspondent à des régions, sous-catégories, etc. et les enlever du df principal
DataVaccin <- DataVaccin %>% 
    filter(!str_detect(geo, "OWID"))


# Création d'une nouvelle colonne avec l'année de vaccination pour simplifier
# la fusion avec Gapminder qui a des données par années et l'exploration des données


DataVaccin <- DataVaccin %>% 
    mutate(year = year(date)) %>% 
    relocate(year, .after = "geo")

WorldVaccine <- WorldVaccine %>% 
mutate(year = year(date)) %>% 
    relocate(year, .after = "location")

RegionVaccin <- RegionVaccin %>% 
    mutate(year = year(date)) %>%  
    relocate(year, .after = "geo")

# 2.2 Gapminder
# 2.2.1 Données de population

# Les données débutent en 1800 et terminent avec les projections de l'an 2100
# Enlever les années précédent le début de la vaccination (enlever avant 2020)
DataGapCountriesPop <- subset(DataGapCountriesPop, time >= 2020)
DataGapRegionPop <- subset(DataGapRegionPop, time >= 2020)
DataGapWorldPop <- subset(DataGapWorldPop, time >= 2020)

#Garder 2020, 2021 et 2022 (car débute dans quelques jours, donc enlever après 2022)
DataGapCountriesPop <- subset(DataGapCountriesPop, time <= 2022)
DataGapRegionPop <- subset(DataGapRegionPop, time <= 2022)
DataGapWorldPop <- subset(DataGapWorldPop, time <= 2022)

# Standardiser la casse des lettres de la variable geo pour que ça concorde
# avec celle utilisé dans le jeu de données de OWID
DataGapCountriesPop$geo <- str_to_upper(DataGapCountriesPop$geo)

# 2.2 Gapminder
# 2.2.2 GDP

# Les données débutent en 1800 et terminent avec les projections de l'an 2100
# Enlever les années précédent le début de la vaccination (enlever avant 2020)
DataGapCountriesGDP <- subset(DataGapCountriesGDP, time >= 2020)
DataGapRegionGDP <- subset(DataGapRegionGDP, time >= 2020)
DataGapWorldGDP <- subset(DataGapWorldGDP, time >= 2020)

#Garder 2020, 2021 et 2022 (car débute dans quelques jours, donc enlever après 2022)
DataGapCountriesGDP <- subset(DataGapCountriesGDP, time <= 2022)
DataGapRegionGDP <- subset(DataGapRegionGDP, time <= 2022)
DataGapWorldGDP <- subset(DataGapWorldGDP, time <= 2022)

# Standardiser la casse des lettres de la variable geo pour que ça concorde
# avec celle utilisé dans le jeu de données de OWID
DataGapCountriesGDP$geo <- str_to_upper(DataGapCountriesGDP$geo)

# Renommer la dernière colonne (6e) de DataGapCountriesGDP en utilisant la position
# car la chaîne de caractère est longue
colnames(DataGapCountriesGDP)[6] <- "Annual GDP per capita growth"


# Lire le fichier CSV avec les continents/codes ISO
Continents <- read.csv("./Data/Raw/ContinentsOWID.csv", stringsAsFactors = TRUE)

# Nettoyage pour n'avoir que les codes et continents
#Enlever la date de la dernière mise-à-jour (colomne 3) qui est inutile ici.
Continents <- subset(Continents, select = -c(3))
# Enlever entity pour éviter d'ajouter une autre colonne avec les noms de pays/entités
Continents <- subset(Continents, select = -c(1))
# Changer le nom de la colonne Code pour qu'elle concorde avec geo
colnames(Continents)[1] <- "geo"


# Enlever objets inutiles
rm(VacFile, PopFile, GDPFile)
