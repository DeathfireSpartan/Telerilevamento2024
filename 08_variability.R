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
cl <- colorRampPalette(c("black", "blue", "green", "yellow"))(4)
plot(nir, col=cl)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

viridisc <- colorRampPalette(viridis(7))(256)
plot(sd3, col=viridisc)

# Standard deviation 7x7
sd7 <- focal(nir, matrix(1/49, 7, 7), fun=sd)
plot(sd7, col=viridisc)

# stack
stacksd <- c(sd3, sd7)
plot(stacksd, col=viridisc)

# Standard deviation 13x13
sd13 <- focal(nir, matrix(1/169, 13, 13), fun=sd)

stacksd <- c(sd3, sd7, sd13)
plot(stacksd, col=viridisc)
