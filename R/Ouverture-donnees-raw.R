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
VacFile <- list.files("./Data/Raw/", pattern = "Vaccination")
DataVaccin <- read.csv(paste0("./Data/Raw/", VacFile), stringsAsFactors = TRUE)

#Au départ, il n'y avait pas de colonne avec une valeur X, cela semble jouer 
# avec mon code qui était fonctionnel il y a 2 heures... Ainsi
DataVaccin <- subset(DataVaccin, select = -(X))

# 1.2 Gapminder
# 1.2.1 Données de population

# Aller chercher le nom du fichier qui change en fonction de la date
# Avant de l'ouvrir
PopFile <- list.files("./Data/Raw/", pattern = "GapminderPop")

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

#Obtenir les vaccins par région et enlever les autres niveaux
RegionVaccin <- subset(DataVaccin, geo=="OWID_AFR" | geo=="OWID_ASI" | geo=="OWID_EUR" | geo=="OWID_NAM" | geo=="OWID_OCE" | geo=="OWID_SAM")

 
# Mettre les données mondiales dans un autre objet avant de les enlever
# Enlever la colonne geo (info. redondante)
# location gardée pour le moment au cas où serait utile
WorldVaccin <- subset(DataVaccin, geo == "OWID_WRL")
WorldVaccin <- subset(WorldVaccin, select = -(geo))

# Utiliser stringr pour sélectionner les codes iso (geo) OWID
# qui correspondent à des régions, sous-catégories, etc. et les enlever du df principal
DataVaccin <- DataVaccin %>% 
    filter(!str_detect(geo, "OWID"))


# Création d'une nouvelle colonne avec l'année de vaccination pour simplifier
# la fusion avec Gapminder qui a des données par années et l'exploration des données


DataVaccin <- DataVaccin %>% 
    mutate(year = year(date)) %>% 
    relocate(year, .after = "geo")

WorldVaccin <- WorldVaccin %>% 
mutate(year = year(date)) %>% 
    relocate(year, .after = "location")

RegionVaccin <- RegionVaccin %>% 
    mutate(year = year(date)) %>%  
    relocate(year, .after = "geo")

# 2.2 Gapminder
# 2.2.1 Données de population

# Les données qui débutent en 1800 et terminent avec les projections de l'an 2100
# Enlever les années qui précèdent le début de la vaccination (enlever avant 2020)
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


# 3 Ajout de la variable continent
# Lire le fichier CSV avec les continents/codes ISO
Continents <- read.csv("./Data/Raw/ContinentsOWID.csv", stringsAsFactors = TRUE)

# Nettoyage pour n'avoir que les codes et continents
#Enlever la date de la dernière mise-à-jour (colomne 3) qui est inutile ici.
Continents <- subset(Continents, select = -c(3))
# Enlever entity pour éviter d'ajouter une autre colonne avec les noms de pays/entités
Continents <- subset(Continents, select = -c(1))
# Changer le nom de la colonne Code pour qu'elle concorde avec geo
colnames(Continents)[1] <- "geo"

# Ajout des continents aux données de vaccination par pays
DataVaccination<- left_join(DataVaccin, Continents, by = "geo", all.x = TRUE)

DataVaccination <- DataVaccination %>% 
    relocate(Continent, .after = "geo")

# Création d'une nouvelle variable pour les continents
# Continent7 aura 7 continents tel que décrit par la liste OWID
# Continent regroupera l'Amérique du Nord et l'Amérique du Sud sous Americas
DataVaccination <- DataVaccination %>% 
    mutate(DataVaccination, Continent7 = Continent) %>% 
    relocate(Continent7, .before = "Continent")

DataVaccination <- DataVaccination %>%
    mutate(Continent = fct_collapse(Continent,
                                    "Americas" = c("North America", "South America")))

# 4 Finir le nettoyage afin de fusionner les df entre-eux
# 4.1 Enlever la variable name de DataGapCountriesGDP et de DataGapCountriesPop pour éviter un doublon de variable
# les codes iso "geo" seront utilisés pour "merge" les df, car ils sont standardisés
DataGapCountriesPop <- subset(DataGapCountriesPop, select = -c(2))
DataGapCountriesGDP <- subset(DataGapCountriesGDP, select = -c(2))

# 4.2 Renommer the Americas pour Americas dans les données Gapminder
DataGapRegionGDP <- DataGapRegionGDP %>% 
    mutate(name = str_replace_all(name, "The Americas", "Americas"))

DataGapRegionPop <- DataGapRegionPop %>% 
    mutate(name = str_replace_all(name, "The Americas", "Americas"))

# 4.3 Renommer les variables name des données Gapminder pour Continent et year 
colnames(DataGapRegionPop)[2] <- "Continent"
colnames(DataGapRegionGDP)[2] <- "Continent"
colnames(DataGapRegionPop)[3] <- "year"
colnames(DataGapRegionGDP)[3] <- "year"


colnames(DataGapCountriesPop)[2] <- "year"
colnames(DataGapCountriesGDP)[2] <- "year"

colnames(RegionVaccin)[1] <- "Continent"

colnames(DataGapWorldPop)[3] <- "year"
colnames(DataGapWorldGDP)[3] <- "year"

# 4.4 préparer les données mondiales pour la fusion
# Retrait des colonnes geo et name, informations redondantes
DataGapWorldPop <- subset(DataGapWorldPop, select = -c(1,2))
DataGapWorldGDP <- subset(DataGapWorldGDP, select = -c(1,2))

# 5 Fusion des dataframes pour avoir les documents " data processed" finaux
# 5.1 Vaccin par pays avec GDP et population par pays
# inclu maintenant les nouvelles variables de continents!
DataVacGDPPopCountry <- left_join(DataVaccination, DataGapCountriesGDP, 
                                  by = c("geo", "year"), all.x = TRUE)
DataVacGDPPopCountry <- left_join(DataVacGDPPopCountry, DataGapCountriesPop,
                                  by = c("geo", "year"), all.x = TRUE)

# 5.2 Vaccin par région/continent avec GDP et population
DataVacGDPPopRegion <- left_join(RegionVaccin, DataGapRegionGDP,
                                 by = c("Continent", "year"), all.x = TRUE)
DataVacGDPPopRegion <- left_join(DataVacGDPPopRegion, DataGapRegionPop, 
                                 by = c("Continent", "year"), all.x = TRUE)

# 5.3 Vaccins informations mondiales avec GDP et population
DataVacGDPPopWorld <- left_join(WorldVaccin, DataGapWorldPop,
                         by = "year", all.x = TRUE)

DataVacGDPPopWorld  <- left_join(DataVacGDPPopWorld , DataGapWorldGDP,
                         by = "year")
DataVacGDPPopWorld <- subset(DataVacGDPPopWorld, select = -c(18))

#6 Transfert des df en .csv et nom de colonnes/variables
# 6.1 Vaccin par pays avec GDP et population par pays
write.csv(DataVacGDPPopCountry, "./Data/Processed/VaccinationPopGDP_pays.csv")
write.csv(DataVacGDPPopRegion, "./Data/Processed/VaccinationPopGDP_continent.csv")
write.csv(DataVacGDPPopWorld, "./Data/Processed/VaccinationPopGDP_monde.csv")

# Enlever objets qui n'ont pas à être réutilisés
rm(Continents, DataGapCountriesGDP, DataGapCountriesPop, DataGapRegionGDP, DataGapRegionPop, DataGapWorldGDP,
   DataGapWorldPop, DataVaccin, DataVaccination, DataVacGDPPopCountry, DataVacGDPPopRegion, DataVacGDPPopWorld,
   RegionVaccin, WorldVaccin, GDPFile, PopFile, VacFile)

print("Le fichier d'ouverture et manipulation des données a terminé. Mise à jour des données processed effectuée.")
