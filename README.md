# FAS1002-A21_projet-final

Ce répertoire se veut exemple typique d'un rapport fonctionnel à remettre pour
le projet final du cours [FAS1002 - Initiation à la programmation en sciences
sociales](https://admission.umontreal.ca/cours-et-horaires/cours/fas-1002/) qui
est offert dans le cadre du [Microprogramme de 1er cycle en analyse des
mégadonnées en sciences humaines et
sociales](https://admission.umontreal.ca/programmes/microprogramme-de-1er-cycle-en-analyse-des-megadonnees-en-sciences-humaines-et-sociales/structure-du-programme/).
Par le fait même, ce répertoire est aide en indiquant aux étudiant.e.s permet
aux étudiant.e.s qui doivent construire un rapport de toute pièce les éléments
à changer en plus d'offrir une structure relativement de base. Il manque
certains dossiers cruciaux, mais ils n'y sont pas à des fins éducatives!

## Instructions

1.  Pour démarrer avec ce répertoire, vous n'avez qu'à *fork* ce répertoire.

2.  Ensuite, vous devez activer *GitHub Pages* et choisir la branche `main` et
    la source `/docs`. La première version que vous verrez sera la version
    originale trouvable au <https://fas1002.github.io/FAS1002-A22_projet-final/>.

3.  N'oubliez pas de modifier votre section `About` en haut à droite de votre
    répertoire pour faciliter la visite de votre site web.

4.  Pour commencer à coder le plus rapidement, le plus simple est d'importer le
    répertoire à travers les menus de RStudio en créant un nouveau
    `Project >  Version Control > votre répertoire`.

    1.  Pour les plus téméraires, vous pouvez
        `git clone https://github.com/USERNAME/votre-repertoire` à partir de
        votre terminal.
    2.  N'oubliez pas de *commit* périodiquement en tenant compte de la
        fonctionnalité de vos ajouts. Je vous invite à révisiter le guide
        [GitHub
        flow](https://docs.github.com/en/get-started/quickstart/github-flow)
        pour en apprendre davtange.

5.  Enfin, pour mettre à jour votre site web, la façon le plus simple est de
    regénérer le contenu de votre site localement (sur votre ordinateur) en
    cliquant sur `Build Website` ou en utilisant la commande
    `rmarkdown::render_site(encoding = 'UTF-8')` dans la console. Il vous
    faudra *commit* vos changements et de *push* le tout sur GitHub.

## Structure du répertoire

``` bash
├── 1-intro.Rmd
├── 2-import.Rmd
├── 3-exploration.Rmd
├── contact.Rmd
├── docs
├── FAS1002-A22_projet-final.Rproj
├── _footer.html
├── index.Rmd
├── README.md
├── references.bib
├── _site.yml
└── static
    ├── images
    │   └── FAS1002.png
    └── theme.css
```

Tous les fichiers `.Rmd` seront amenés à être modifiés; ils ne sont que des
exemples très, très brefs. Ceux-ci constituent la base de votre rapport. Vous
pouvez les nommer et les utiliser comme vous les voulez. Ainsi, vous pourrez
diviser en différentes parties le processus d'analyses de façons stratégiques
au lieu d'avoir un seul document avec des milliers de lignes. Le nombre est
également arbitraire, à vous de décider la quantité qui vous convient.
Cependant, pour faciliter le travail avec les données, il vous faudra créer
quelques dossiers supplémentaires en suivant la structure du [template
ISDS](https://github.com/osumontreal/template_r), notamment pour les dossiers
`data`, `R` et `figures`.

Pour plus de détails sur la structure et les modifications possibles en
fonction des fichiers, veuillez consulter le site web de
[distill](https://rstudio.github.io/distill/). Tout y est pour modifier le
look, etc.

## Principaux packages R utilisés dans l'exemple:

-   R Core Team (2020). R: A language and environment for statistical
    computing. R Foundation for Statistical Computing, Vienna, Austria.
    <https://www.R-project.org/>

-   JJ Allaire, Rich Iannone, Alison Presmanes Hill and Yihui Xie (2021).
    distill: 'R Markdown' Format for Scientific and Technical Writing. R
    package version 1.3. <https://CRAN.R-project.org/package=distill>

-   H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag
    New York, 2016. <https://ggplot2.tidyverse.org>

-   Joe Cheng, Bhaskar Karambelkar and Yihui Xie (2021). leaflet: Create
    Interactive Web Maps with the JavaScript 'Leaflet' Library. R package
    version 2.0.4.1. <https://CRAN.R-project.org/package=leaflet>

-   C. Sievert. Interactive Web-Based Data Visualization with R, plotly, and
    shiny. Chapman and Hall/CRC. Florida, 2020. <https://plotly-r.com>

-   Jennifer Bryan (2017). gapminder: Data from Gapminder. R package version
    0.3.0. <https://CRAN.R-project.org/package=gapminder>

