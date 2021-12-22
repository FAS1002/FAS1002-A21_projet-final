## FAS1002 - Projet Final ##
# Script de téléchargement des données initiales: RAW

# 1 Our World in Data (OWID)
# 1.1 Données de vaccination covid-19


ListeVac <- list.files("Data/Raw/", pattern = "Vaccination")
DateVac <- as.Date(str_extract(ListeVac,"\\d{4}-\\d{2}-\\d{2}" ))

DateVac <- file.info("./Data/Raw/", pattern = "^Vaccination")$ctime

TimeDiffVac <- Sys.time() - DateVac


# Créer une série de commandes pour télécharger le fichier à nouveau
# à partir d'OWID si le fichier date de plus d'une journée

if (TimeDiffVac < 24)
        download.file("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv",
                  destfile = paste0("./Data/Raw/Vaccination", Sys.Date(), ".csv"))
        file.remove(dir(paste0("./Data/Raw/Vaccination", )
        print("La mise-à-jour des données a été effectuée")

        
