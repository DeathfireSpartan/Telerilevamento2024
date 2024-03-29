# Visualizzazione di dati satellitari in R usando imageRy
# Pacchetto terra
# Pacchetto imageRy --> informazioni sul Github del prof (basta cercare imageRy e scaricare il pdf)

library(imageRy)
library(terra)


# Qualsiasi funzione di imageRy inizia con "im."
# Lista di tutti i dati disponibili già caricati nel pacchetto --> non c'è un argomento, ma comunque devo usare le parentesi
im.list()

# Funzione per importare/utilizzare uno dei dati all'interno della lista --> im.import("nomedato")
mato <- im.import("matogrosso_ast_2006209_lrg.jpg")
b2 <- im.import("sentinel.dolomites.b2.tif") # Immagine composta da tante bande (tanti sensori per ogni lunghezza d'onda)

# Voglio plottare i dati
plot(mato)

# Voglio cambiare la scala dei colori (scala dei grigi) --> colorRampPalette(c("nomecolore1", "nomecolore2", "...")) (valore sfumatura)
# c() serve per concatenare e creare così l'array
# Tra parentesi il numero indica la sfumatura al passaggio da un colore all'altro
clg <- colorRampPalette(c("black", "grey", "lightgrey")) (1000)

# Plotto b2 con il colore che ho scelto in clg
plot(b2, col=clg)

# La roccia riflette tutte le bande colorate, mentre la vegetazione assorbe tutta la lunghezza d'onda del blu (per il processo di fotosintesi)

# Importo le bande addizionali
# Importo la banda verde del Sentinel-2 (banda 3)
b3 <- im.import("sentinel.dolomites.b3.tif") 
plot(b3, col=clg)

# Importo la banda rossa del Sentinel-2 (banda 4)
b4 <- im.import("sentinel.dolomites.b4.tif") 
plot(b4, col=clg)

# Importo la banda del vicino infrarosso NIR del Sentinel-2 (banda 8)
b8 <- im.import("sentinel.dolomites.b8.tif") 
plot(b8, col=clg)

# Voglio mettere tutte le bande insieme in un unico plot --> multiframe
# Funzione par(mfrow=c(righe,colonne)) --> 2 righe e 2 colonne --> par(mfrow=c(2,2))
par(mfrow=c(2,2))
plot(b2, col=clg)
plot(b3, col=clg)
plot(b4, col=clg)
plot(b8, col=clg)

# Esercizio: plottare le 4 bande in una singola riga
par(mfrow=c(1,4))
plot(b2, col=clg)
plot(b3, col=clg)
plot(b4, col=clg)
plot(b8, col=clg)

# Considero le immagini come facenti parte di un unico array
stacksent <- c(b2, b3, b4, b8)
plot(stacksent, col=clg)

# Plotto solo un elemento specifico dell'array --> selezione l'elemento con la parentesi quadre
# Uso 2 parentesi quadre perchè sto lavorando con una matrice
# Plotto solo il quarto elemento --> banda 8
plot(stacksent[[4]], col=clg)

# Anniento l'immagine precedente --> dev.off()
# Cancello il comando par() precedente
dev.off()

# Plottaggio RGB
# b2 --> banda del blu --> stacksent[[1]]=b2=blu
# b3 --> banda del verde --> stacksent[[2]]=b3=verde
# b4 --> banda del rosso --> stacksent[[3]]=b4=rosso
# b8 --> banda del infrarosso vicino --> stacksent[[4]]=b8=infrarosso vicino

# Funzione im.plotRGB(immagine, rosso, verde, blu), vado ad associare ad ogni banda un colore e quindi un numero (3,2,1)
im.plotRGB(stacksent,3,2,1) #3=rosso, 2=verde, blu=1

# Al posto del rosso e quindi di 3 nel codice mettiamo la banda dell'infrarosso vicino che è 4
im.plotRGB(stacksent,4,2,1) # dall'immagine si vede meglio la vegetazione, l'infrarosso potenzia la visione
im.plotRGB(stacksent, 4, 3, 1) # Ho cambiato anche il verde, ma sarà praticamente uguale all'immagine precedente. L'infrarosso è quello che si nota meglio
im.plotRGB(stacksent, 3, 4, 2) # Sostituisco l'infrarosso al verde
im.plotRGB(stacksent, 3, 2, 4) # Sostituisco l'infrarosso al blu

# Esercizio: plotta le 4 immagini precedenti in una matrice
par(mfrow=c(2,2))
im.plotRGB(stacksent, 3, 2, 1) # Colori naturali
im.plotRGB(stacksent, 4, 2, 1) # Infrarosso sul rosso
im.plotRGB(stacksent, 3, 4, 2) # Infrarosso sul verde
im.plotRGB(stacksent, 3, 2, 4) # Infrarosso sul blu

# Funzione pairs(immagine)
# Produce vari grafici con tante informazioni (indice di correlazione di Pearson, boh)
pairs(stacksent)

# Exercise: plot in a multiframe the bands with different color ramps
par(mfrow=c(2,2))

clb <- colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(b2, col=clb)

clg <- colorRampPalette(c("dark green", "green", "light green")) (100)
plot(b3, col=clg)

clr <- colorRampPalette(c("dark red", "red", "pink")) (100)
plot(b4, col=clr)

cln <- colorRampPalette(c("brown", "orange", "yellow")) (100)
plot(b8, col=cln)



pairs(stacksent)
