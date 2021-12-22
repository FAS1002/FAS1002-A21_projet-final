# FAS1002 - Projet final
## Ouverture et manipulation des banques de données
## Ouvrir/exécuter ce document après le script de téléchargement (mise-à-jour)

# Utilisation de readxl
library(tidyverse)

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

# Enlever objets inutiles
rm(VacFile, PopFile, GDPFile)

# 2 Manipulation des données
# 2.1 OWID
# 2.1.1 Données de vaccination

# Changer le titre de la colonne iso_code
# Mettre même titre que celui utilisé par Gapminder
DataVaccin <- rename(DataVaccin, geo = iso_code)

# Mettre les données mondiales dans un autre objet avant de les enlever
# Enlever la colonne geo (info. redondante)
# location gardée pour le moment au cas où serait utile
WorldVaccine <- subset(DataVaccin, geo == "OWID_WRL")
WorldVaccine <- subset(WorldVaccine, select = -c(2))

# Utiliser stringr pour sélectionner les codes iso (geo) OWID
# qui correspondent à des régions, sous-catégories, etc.

DataVaccin <- DataVaccin %>% 
    filter(!str_detect(geo, "OWID"))





# Lire le fichier CSV avec les continents/codes ISO
Continents <- read.csv("./Data/Raw/ContinentsOWID.csv", stringsAsFactors = TRUE)

# Nettoyage pour n'avoir que les codes et continents
#Enlever la date de la dernière mise-à-jour (colomne 3) qui est inutile ici.
Continents <- subset(Continents, select = -c(3))
# Enlever entity pour éviter d'ajouter une autre colonne avec les noms de pays/entités
Continents <- subset(Continents, select = -c(1))



