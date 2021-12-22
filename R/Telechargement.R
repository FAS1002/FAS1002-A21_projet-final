## FAS1002 - Projet Final ##
# Script de téléchargement des données initiales: RAW

# 1 Our World in Data (OWID)
# 1.1 Données de vaccination covid-19


ListeVac <- list.files("Data/Raw/", pattern = "Vaccination")
DateVac <- as.Date(str_extract(ListeVac,"\\d{4}-\\d{2}-\\d{2}" ))

if(DateVac = today())
    download.file("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv",
                  destfile = paste0("./Data/Raw/Vaccination", Sys.Date(), ".csv"))
    file.remove(paste0("./Data/Raw/Vaccination", DateVac, ".csv"))
    print("La mise-à-jour des données a été effectuée")

    
