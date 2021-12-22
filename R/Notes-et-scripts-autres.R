# FAS1002 - Projet final
## Notes et scripts autres utilisés (brouillon)
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



## Note sur regex: ne pas oublier d'échapper une fois de plus avec \ le tiret pour la date
## Donc Regex date utilisé dans RStudio: \\d{4}-\\d{2}-\\d{2}



## Gapminder 
## POPULATION Download initial des données:
download.file("https://docs.google.com/spreadsheets/d/14_suWY8fCPEXV0MH7ZQMZ-KndzMVsSsA5HdR-7WqAC0/export?format=xlsx", destfile = paste0("./Data/Raw/GapminderPop", Sys.Date(), ".xlsx") )

##Version avec date bidon pour tester regex et if
download.file("https://docs.google.com/spreadsheets/d/14_suWY8fCPEXV0MH7ZQMZ-KndzMVsSsA5HdR-7WqAC0/export?format=xlsx", destfile = paste0("./Data/Raw/GapminderPop", "2021-12-21", ".xlsx") )

## GDP Download initial des données:
download.file("https://docs.google.com/spreadsheets/d/1h3z8u0ykcUum8P9FV8EHF9fszDYr7iPDZQ-fgE3ecls/export?format=xlsx", destfile = paste0("./Data/Raw/GapminderGDP", Sys.Date(), ".xlsx"))

##Version avec date bidon pour tester regex et if
download.file("https://docs.google.com/spreadsheets/d/1h3z8u0ykcUum8P9FV8EHF9fszDYr7iPDZQ-fgE3ecls/export?format=xlsx", destfile = paste0("./Data/Raw/GapminderGDP", "2021-12-21", ".xlsx"))


