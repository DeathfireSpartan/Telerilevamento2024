# CARICAMENTO PACKAGES

library(terra)
library(imageRy)
library(viridis)
library(paletteer)
library(ggplot2)
library(patchwork)



# IMPORTAZIONE E PLOT INIZIALE

# Imposto la working directory per le immagini normali
setwd("C:/Users/cucap/Desktop/Luca/True")

# Carico le varie immagini --> True colors
sett2018 <- rast("26-09-2018.jpg")
ott2018 <- rast("21-10-2018.jpg")
nov2018 <- rast("15-11-2018.jpg")
sett2023 <- rast("25-09-2023.jpg")
apr2024 <- rast("12-04-2024.jpg")

# Imposto la working directory per le immagini in NIR
setwd("C:/Users/cucap/Desktop/Luca/NIR")

# Carico le varie immagini --> False colors
sett2018N <- rast("26-09-2018.jpg")
ott2018N <- rast("21-10-2018.jpg")
nov2018N <- rast("15-11-2018.jpg")
sett2023N <- rast("25-09-2023.jpg")
apr2024N <- rast("12-04-2024.jpg")

# Plotto le 4 immagini principali in una griglia 2x2
par(mfrow=c(2,2))
plotRGB(sett2018, 1, 2, 3)
plotRGB(ott2018, 1, 2, 3)
plotRGB(nov2018, 1, 2, 3)
plotRGB(sett2023, 1, 2, 3)

# Plotto le 4 immagini, in NIR, principali in una griglia 2x2
par(mfrow=c(2,2))
plotRGB(sett2018N, 1, 2, 3)
plotRGB(ott2018N, 1, 2, 3)
plotRGB(nov2018N, 1, 2, 3)
plotRGB(sett2023N, 1, 2, 3)



# PULIZIA
dev.off()



# PALETTES

# Imposto 2 palette di colori, una normale e una per i daltonici
# Imposto la palette di colori per assomigliare a quella presente sul sito Copernicus
col <- paletteer_c("grDevices::Purple-Green", 30)
# Creo la palette di coloro per i daltonici
viridisc <- colorRampPalette(viridis(7))(255)



# DIFFERENZE

# Calcolo le differenze tra le varie immagini in NIR
diffSO2018 <- ott2018N[[1]] - sett2018N[[1]]
diffNO2018 <- nov2018N[[1]] - ott2018N[[1]]
diffSN2023 <- sett2023N[[1]] - nov2018N[[1]]
diffPrePost <- sett2023N[[1]] - sett2018N[[1]]

# Plotto le differenze in una griglia 2x2
stackdiff <- c(diffSO2018, diffNO2018, diffSN2023,diffPrePost)
plot(stackdiff, col=viridisc)
# Settebre - Ottobre 2018 --> Non ci sono praticamente differenze tra le immagini (a parte il passaggio di qualche nuvola)
# Ottobre - Novembre 2018 --> Si nota una maggiore differenza dopo il passaggio della tempesta
# Novembre 2018 - Settembre 2023 --> In 5 anni gli alberi caduti e danneggiati sono stati rimossi, 
# Settebre 2018 - Settembre 2023 --> Si notano perfettamente le aree danneggiate dalla tempesta di 5 anni prima

# Plotto le differenze in una griglia 2x2 (colori diversi)
plot(stackdiff, col=col)



# CLASSIFICAZIONE

# Classifico le immagini
sett2018Ncc <- im.classify(sett2018N, num_clusters=2)
sett2023Nccc <- im.classify(sett2023N, num_clusters=2)

# Plotto le immagini in uno stack 
steck2 <- c(sett2018N[[1]], sett2018Ncc[[1]], sett2023N[[1]], sett2023Nccc[[1]])
plot(steck2)

# Calcolo le frequenze, il numero di celle e le percentuali delle 2 classi nelle immagini
f2018 <- freq(sett2018Ncc)
f2023 <- freq(sett2023Nccc)

# 2018
tot2018 <- ncell(sett2018Ncc)
prop2018 = f2018 / tot2018
perc2018 = prop2018 * 100
perc2018

# 2023
tot2023 <- ncell(sett2023Nccc)
prop2023 = f2023 / tot2023
perc2023 = prop2023 * 100
perc2023

# Costruisco un dataframe (tabella) con 2 classi e i rispettivi valori
class <- c("Prato", "Bosco")
p2018 <- c(36, 64)
p2023 <- c(55, 45)

# Funzione data.frame, creo e visualizzo una tabella
tabout <- data.frame(class, p2018, p2023)
View(tabout) 

# Plotto il grafico usando il pacchetto ggplot2
# Funzione ggplot(dati, aes(x=class, y=p2018 oppure p2023, color=class)) + geom_bar(stat="identity", fill="black")
# aes --> estetica --> come costruire il grafico
# geom_bar --> tipo di geometria, in questo caso istogramma --> gli argomenti della funzione indicano le statistiche e il colore
ggplot(tabout, aes(x=class, y=p2018, color=class)) + geom_bar(stat="identity", fill="black")
ggplot(tabout, aes(x=class, y=p2023, color=class)) + geom_bar(stat="identity", fill="black")

# Uso il pacchetto patchwork per mettere i grafici a confronto
# Funzione ylim() per eguagliare gli assi dei due grafici
p1 <- ggplot(tabout, aes(x=class, y=p2018, color=class)) + geom_bar(stat="identity", fill="black") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2023, color=class)) + geom_bar(stat="identity", fill="black") + ylim(c(0,100))
p1 + p2



# NDVI

# Calcolo NDVI (versione rapida)
sett2018NDVI <- im.ndvi(sett2018N, 1, 2)
ott2018NDVI <- im.ndvi(ott2018N, 1, 2)
nov2018NDVI <- im.ndvi(nov2018N, 1, 2)
sett2023NDVI <- im.ndvi(sett2023N, 1, 2)
apr2024NDVI <- im.ndvi(apr2024N, 1, 2)

# Calcolo NDVI (versione lenta e didattica)
sett2018NDVI = (sett2018N[[1]] - sett2018N[[2]])/(sett2018N[[1]] + sett2018N[[2]])
ott2018NDVI = (ott2018N[[1]] - ott2018N[[2]])/(ott2018N[[1]] + ott2018N[[2]])
nov2018NDVI = (nov2018N[[1]] - nov2018N[[2]])/(nov2018N[[1]] + nov2018N[[2]])
sett2023NDVI = (sett2023N[[1]] - sett2023N[[2]])/(sett2023N[[1]] + sett2023N[[2]])
apr2024NDVI = (apr2024N[[1]] - apr2024N[[2]])/(apr2024N[[1]] + apr2024N[[2]])

# Plotto in una griglia 2x2 le 4 immagini principali in NDVI
stackNDVI <- c(sett2018NDVI, ott2018NDVI, nov2018NDVI, sett2023NDVI)
plot(stackNDVI, col=col)



# VARIABILITA'

# Voglio calcolare la variabilità dell'immagine, con il metodo della "moving window" --> calcolo la deviazione standard di una finestra mobile di 6 pixel e la associo al pixel centrale -->
# --> poi sposto la finestra di 1 pixel, rifaccio il calcolo e lo associo al nuovo pixel centrale
# Posso calcolare la variabilità per una singola banda --> devo decidere quale banda (in questo esercizio uso il NIR)

# Creo uno stack con la prima banda di ogni immagine
stack <- c(sett2018N[[1]], ott2018N[[1]], nov2018N[[1]], sett2023N[[1]])

# Creo la palette di colori e plotto lo stack
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(stack, col=cl)

# Uso la funzione "focal()" per estrarre delle statistiche focali da un gruppo di valori, fa il calcolo della deviazione standard nella finestra di pixel da noi indicata
# matrix(1, 2, 3) --> crea una matrice, cioè la mia finestra di calcolo --> moving window
# Il primo valore definisce l'unità della matrice, il secondo e il terzo mi indicano rispettivamente le righe e le colonne della matrice
# fun=sd --> indico che la funzione che voglio utilizzare è la deviazione standard
focalimage <- focal(stack, matrix(1/9, 3, 3), fun=sd)
plot(focalimage)



# ANALISI MULTIVARIATA

# Necessito delle immagini con le 4 bande principali
# Preparo degli stack che contengono le bande che mi servono: Blu, Verde, Rosso e NIR
ssett2018 <- c(sett2018[[3]], sett2018[[2]], sett2018[[1]], sett2018N[[1]])
sott2018 <- c(ott2018[[3]], ott2018[[2]], ott2018[[1]], ott2018N[[1]])
snov2018 <- c(nov2018[[3]], nov2018[[2]], nov2018[[1]], nov2018N[[1]])
ssett2023 <- c(sett2023[[3]], sett2023[[2]], sett2023[[1]], sett2023N[[1]])

# Provo a plottare lo stack in False colors --> uguale all'immagine caricata
# Non uso im.plotRGB() perchè l'output non è decente
plotRGB(ssett2018, 4, 3, 2)

# Calcolo le correlazioni tra i dati (bande), usando l'indice di Pearson (1 = correlazione positiva, -1 = correlazione negativa)
pairs(ssett2018)
pairs(ssett2023)
