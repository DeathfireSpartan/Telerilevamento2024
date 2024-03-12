# Installing new packages in R
# Installazione del pacchetto Terra
# Installazione del pacchetto devtools
# Installazione del pacchetto imageRy

# Funzione per installare pacchetti --> install.packages("nomepacchetto")
# Va già a pigliare il pacchetto da CRAN --> fa scegliere il server da cui scaricare il pacchetto --> si usano le virgolette per proteggersi al di fuori di R
install.packages("terra")

# Funzione library --> controlla che il pacchetto sia stato installato correttamente
library(terra)
# Funzione remove.packages("terra")

# Pe poter scaricare da Github bisogna aver prima scaricato il pacchetto "devtools" da CRAN
install.packages("devtools")
library(devtools)

# Installazione di un package da Github (imageRy) --> devtools::install_github("nomepacchetto")
# devtools:: serve a chi legge il codice per capire che il comando proviene dal pacchetto "devtools"
devtools::install_github("ducciorocchini/imageRy")
library(imageRy)
