# Come fare analisi multivariate in R con dati di remote sensing
# Immagini iperspettrali con centinaia di bande, spesso non è possibile andare a scegliere la banda singola

library(terra)
library(imageRy)
library(viridis)

im.list()

# Importo i dati --> bande del Sentinel-2 delle Dolomiti
b2 <- im.import("sentinel.dolomites.b2.tif")  # Blu
b3 <- im.import("sentinel.dolomites.b3.tif")  # Verde
b4 <- im.import("sentinel.dolomites.b4.tif")  # Rosso
b8 <- im.import("sentinel.dolomites.b8.tif")  # NIR

# Stack delle immagini delle Dolomiti
sentdo <- c(b2, b3, b4, b8)

# Plotto lo stack, NIR sul verde
im.plotRGB(sentdo, 3, 4, 2)

# Calcolo le correlazioni tra i dati (bande), usando l'indice di Pearson (1 = correlazione positiva, -1 = correlazione negativa)
pairs(sentdo)

# PCA
# Funzione che compatta il set in poche dimensioni
# Porta un'immagine con tante bande ad una banda sola
# Restituisce le componenti

# 1. Sample
# sample <- spatSample(sentdo, 100)
# sample

# 2. PCA
# pca <- prcomp(sample)

# variance explained
# summary(pca)

# 3. PCA map
# pcmap <- predict(sentdo, pca, index=c(1:4))

pcimage <- im.pca(sentdo)

# [1] 1719.25654  626.98962   54.63642   34.92315
tot <- sum(1719.25654,626.98962,54.63642,34.92315)
1719.25654*100 / tot

# Plotto l'immagine
# PC1 è al 70% 
plot(pcimage, col=viridis(100))

# Plot con la palette Magma
plot(pcimage, col=magma(100))


