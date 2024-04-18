# Come importare dati esterni in R

install.packages("ncdf4")
library(ncdf4) # Neccessario per leggere i file dal satellite Copernicus
install.packages("RNetCDF")
library(RNetCDF) # Altro pacchetto perchè a Francesco non andava il precedente
library(terra)
library(imageRy)

# Setto la "working directory", da dove vado a prendere i dati
# setwd("indirizzocartella")
# Windows: C:\\path\Downloads -> C://path/Downloads
setwd("C://Users/cucap/Downloads")

# Carico l'immagine
eclissi <- rast("eclissi.png")  # rast() come in im.import()

# Su "terra" uso direttamente la funzione plotRGB(nomeimmagine, r=1, g=2, b=3)
plotRGB(eclissi, r=1, g=2, b=3) # come im.plotRGB

# Metodi differenti di plot
# L'immagine potrebbe apparire leggermente diversa a causa dello stretch
par(mfrow=c(1,2))
plotRGB(eclissi, r=1, g=2, b=3)
im.plotRGB(eclissi, r=1, g=2, b=3)

# Differenziazione delle bande
diff = eclissi[[1]] - eclissi [[2]] # Differenza tra la prima e la seconda banda
plot(diff)

# Esercizio: Scarica una seconda immagine da un sito a caso e caricala su R
kha <- rast("Khazix_79.webp")
plotRGB(kha, r=1, g=2, b=3)

par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3) # im-plotRGB
plotRGB(najaaug, r=1, g=2, b=3)

# Carico un'immagine da Copernicus
soil <- rast("c_gls_SSM1km_202403280000_CEURO_S1CSAR_V1.2.1.nc")
plot(soil[[1]]) # plotto il primo livello

# Croppo i dati
# crop --> ritagliare l'immagine
ext <- c(25, 35, 58, 62) # descrivo l'estensione che voglio, indico l'intervallo di latitudine e longitudine
# Essenzialmente gli dico che area ritagliare
soilcrop <- crop(soil, ext)
plot(soilcrop[[1]])

# multitemporal change detection
najadif = naja[[1]] - najaaug[[1]] 
cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(najadif, col=cl)

# Download your own preferred image:
typhoon <- rast("mawar_vir2_2023144_lrg.jpg")

plotRGB(typhoon, r=1, g=2, b=3)
plotRGB(typhoon, r=2, g=1, b=3)
plotRGB(typhoon, r=3, g=2, b=1)


# The Mato Grosso image can be downloaded directly from EO-NASA:

mato <- rast("matogrosso_l5_1992219_lrg.jpg")
plotRGB(mato, r=1, g=2, b=3) 
plotRGB(mato, r=2, g=1, b=3) 
