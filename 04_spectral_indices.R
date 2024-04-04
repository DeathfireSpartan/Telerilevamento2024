# Indici spettrali

library(imageRy)
library(terra)

# Classica lista dei file
im.list()

# Importare i dati
# Immagine presa da internet
# https://visibleearth.nasa.gov/images/35891/deforestation-in-mato-grosso-brazil/35892l
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# Bande usate
# Banda 1 = Infrarosso vicino --> R
# Banda 2 = rosso --> G
# Banda 3 = verde --> B

# Plotto l'immagine salvata usando come bande quelle scelta sopra
im.plotRGB(m1992, 1, 2, 3)

# Metto l'infrarosso nella banda del verde
im.plotRGB(m1992, 2, 1, 3)

# Metto l'infrarosso nella banda del blu --> aree deforestate in giallo
im.plotRGB(m1992, 2, 3, 1)

# Importo l'immagine di prima, ma del 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Plotto le due immagini affianco
par(mfrow=c(1, 2))
im.plotRGB(m1992, 1, 2, 3)
im.plotRGB(m2006, 1, 2, 3)

# Immagine del 2006 --> infrarosso sul verde
im.plotRGB(m2006, 2, 1, 3)
# Immagine del 2006 --> infrarosso sul blu
im.plotRGB(m2006, 2, 3, 1)

# Multiframe con le 6 immagini l'una affianco all'altra 
par(mfrow=c(2,3))
im.plotRGB(m1992, 1, 2, 3) # nir sul rosso 1992
im.plotRGB(m1992, 2, 1, 3) # nir sul verde 1992
im.plotRGB(m1992, 2, 3, 1) # nir sul blu 1992
im.plotRGB(m2006, 1, 2, 3) # nir sul rosso 2006
im.plotRGB(m2006, 2, 1, 3) # nir sul verde 2006
im.plotRGB(m2006, 2, 3, 1) # nir sul blu 2006

# Calcolo del DVI (Difference Vegetation Index)
# L'indice varia tra 255 e -255 (perchè ogni pixel è pari a 2^8 = 256)
# Prendo la banda dell'infrarosso 1 e sottraggo quella del rosso 2
dvi1992 = m1992[[1]] - m1992[[2]]

# Palette di colori e plot
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)
plot(dvi1992, col=cl)

# Calcolo il DVI del 2006 e lo plotto
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
dvi2006 = m2006[[1]] - m2006[[2]]
plot(dvi2006, col=cl)

# Ex: PLottare il DVI del 1992 accanto a quello del 2006
par(mfrow=c(1,2))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# Facciamo una normalizzazione --> NDVI (Normalise Difference Vegetation Index) --> NDVI = (NIR - RED) / (NIR + RED) --> 
# (255-0)/(255+0) = 1 e (0-255)/(0-255) = -1 
# NDVI varia da 1 a -1
ndvi1992 = dvi1992 / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])

# Plotto gli NDVI
dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# Funzione per fare tutto questo + velocemente
# im.dvi(immagine, 1, 2) e im.ndvi(immagine, 1, 2) --> Sono indicate le bande del NIR e del rosso
matodvi <- im.dvi("matogrosso_ast_2006209_lrg.jpg", 1, 2)
