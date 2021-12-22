# FAS1002 - Projet final
## Notes et scripts autres utilisés
## Afin de garder ma démarche/traçabilité et à des fins de référence, 
## n'est pas utilisé comme tel dans le "knit" du projet final

## OWID Download initial des donées/création d'un csv:
## note: download.file() a été utilisé dans le script de téléchargment

VaccinationOWID <- read.csv("https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/vaccinations/vaccinations.csv")
write.csv(VaccinationOWID,paste0("./Data/Raw/Vaccination", Sys.Date(), ".csv"))

## version sans la date pour voir si le fichier va être écrasé à la m-a-j
write.csv(VaccinationOWID,paste0("./Data/Raw/Vaccination", ".csv"))

##version avec date bidon pour tester regex

write.csv(VaccinationOWID,paste0("./Data/Raw/Vaccination2021-12-21", ".csv"))
### Résultat: OK, fichier ajouté, troubleshooting terminé!!!



## Gapminder Download initial des données:



