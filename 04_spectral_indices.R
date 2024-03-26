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

