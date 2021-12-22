# FAS1002 - Projet final
## Ouverture et manipulation des banques de données
## Ouvrir/exécuter ce document après le script de téléchargement (mise-à-jour)

# Utilisation de readxl
library(readxl)

# 1 OWID 
# 1.1 données de vaccination

# Aller chercher le nom du fichier qui change en fonction de la date
# Avant de l'ouvrir
VacFile <- list.files("Data/Raw/", pattern = "Vaccination")
DataVaccin <- read.csv(paste0("./Data/Raw/", VacFile))


# 2 Gapminder
# 2.1 Données de population

# Aller chercher le nom du fichier qui change en fonction de la date
# Avant de l'ouvrir
PopFile <- list.files("Data/Raw/", pattern = "GapminderPop")

# Lire les différentes feuilles du fichier excel
# Attribuer un objet par feuille
DataGapWorldPop <- read_excel(paste0("./Data/Raw/", PopFile), sheet = 2)
DataGapRegionPop <- read_excel(paste0("./Data/Raw/", PopFile), sheet = 3)
DataGapCountriesPop <- read_excel(paste0("./Data/Raw/", PopFile), sheet = 4)

# 2.1 Données de PIB

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

# Manipulations des données

