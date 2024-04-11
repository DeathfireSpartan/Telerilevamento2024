# Analisi delle time series
# Secondo metodo per quantificare i cambiamenti nel tempo
# Il primo metodo si basa sulla classificazione

library(imageRy)
library(terra)

im.list()

# Importo i dati di Gennaio e Marzo
# EN --> European Nitrogen --> dati già processati 
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

# Visualizzo le immagini una sotto l'altra
# im.plotRGB.auto() prende subito come bande le prime 3, non c'è da specificare
par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

# using the first element (band) of images
# Vado ad osservare la differenza tra le due immagini rispetto ad un layer specifico --> in questo caso la prima banda
difEN = EN01[[1]] - EN13[[1]]

# Creo la palette di colori e plotto la differenza
cldif <- colorRampPalette(c("blue", "white", "red")) (100)
plot(dif, col=cldif)


### New example: temperature in Greenland

g2000 <- im.import("greenland.2000.tif")
clg <- colorRampPalette(c("black", "blue", "white", "red")) (100)
plot(g2000, col=clg)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col=clg)

par(mfrow=c(1,2))
plot(g2000, col=clg)
plot(g2015, col=clg)

# stacking the data
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

# Exercise: make the differencxe between the first and the final elemnts of the stack
difg <- stackg[[1]] - stackg[[4]]
# difg <- g2000 - g2015
plot(difg, col=cldif)

# Exercise: make a RGB plot using different years
im.plotRGB(stackg, r=1, g=2, b=3)



