# Misuro la variabilità di un'immagine satellitare
library(imageRy)
library(terra)
# install.packages("viridis") --> per chi soffre di daltonismo
library(viridis)

# Ancora una volta la lista delle immagini
im.list()

# Carico l'immagine di Sentinel-2
sent <- im.import("sentinel.png")

# Plotto l'immagine nelle 3 bande
im.plotRGB(sent, 1, 2, 3)

# NIR = banda 1
# Rosso = banda 2
# Verde = banda 3

# Plotto con il NIR sul verde
im.plotRGB(sent, r=2, g=1, b=3)

# Voglio calcolare la variabilità dell'immagine
# Metodo "moving window" --> calcolo la deviazione standard di una finestra mobile di 6 pixel e la associo al pixel centrale -->
# --> poi sposto la finestra di 1 pixel, rifaccio il calcolo e lo associo al nuovo pixel centrale
# Posso calcolare la variabilità per una singola banda --> devo decidere quale banda (in questo esercizio uso il NIR)

# Associo ad una variabile l'elemento 1 (associo la banda 1 ad un oggetto)
nir <- sent[[1]]
# Creo la palette di colori e plotto l'immagine
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(nir, col=cl)

# Funzione "focal(nomeimmagine, matrix(1/9, 3, 3), fun=sd )", estrae delle statistiche focali da un gruppo di valori --> fa il calcolo della deviazione standard nella finestra di pixel da noi indicata
# matrix(1, 2, 3) --> crea una matrice, cioè la mia finestra di calcolo --> moving window
# Il primo valore definisce l'unità della matrice, il secondo e il terzo mi indicano rispettivamente le righe e le colonne della matrice
# fun=sd --> indico che la funzione che voglio utulizzare è la deviazione standard
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

# Pacchetto che mi permette di usare le palettes per i daltonici
viridisc <- colorRampPalette(viridis(7))(256)
plot(sd3, col=viridisc)

# Deviazione standard di una matrice 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# Deviazione standard di una matrice 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)
plot(sd13, col=viridisc)

# Stack delle 3 immagini
stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col=viridisc)

