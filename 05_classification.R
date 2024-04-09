# Quantificare la variabilità della copertura del suolo

# Installo pacchetti nuovi
# install.packages("ggplot2")
# install.packages("patchwork")

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

# La solita lista di immagini
im.list()

# https://www.esa.int/ESA_Multimedia/Images/2020/07/Solar_Orbiter_s_first_views_of_the_Sun6
# additional images: https://webbtelescope.org/contents/media/videos/1102-Video?Tag=Nebulas&page=1

# Importo l'immagine
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# Classifico le immagini --> im.classify() --> richiede l'immagine originale e il numero di cluster/classi che secondo noi sono valide
sunc <- im.classify(sun, num_clusters=3)

# Importo le immagini del Mato Grosso
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Classifico le immagini
m1992c <- im.classify(m1992, num_clusters=2)

# 1992
# Le classi possono essere invertite
# classe 1 = foresta
# classe 2 = umani

m2006c <- im.classify(m2006, num_clusters=2)

# 2006
# classe 1 = foresta
# classe 2 = umani

# Frequenze 1992
f1992 <- freq(m1992c)

# Proporzioni 1992 = numero di pixel di una classe rispetto al totale
tot1992 <- ncell(m1992c)
prop1992 = f1992 / tot1992

# Percentuali 1992
perc1992 = prop1992 * 100

# Foresta = 83%
# Umani = 17%

# Frequenze 2006
f2006 <- freq(m2006c)

# Proporzioni 2006
tot2006 <- ncell(m2006c)
prop2006 = f2006 / tot2006

# Percentuali 2006
perc2006 = prop2006 * 100

# 1992: 17% umani, 83% foresta
# 2006: 55% umani, 45% foresta

# Costruisco un dataframe (tabella) con le 2 classi e i rispettivi valori
class <- c("Foresta", "Umani") # Uso le virgolette perchè è un testo
p1992 <- c(83, 17)
p2006 <- c(45, 55)

# Funzione data.frame(classi, dato1, dato2, ...)
tabout <- data.frame(class, p1992, p2006)
View(tabout) # Visualizzo la tabella

# Plotto il grafico usando il pacchetto ggplot2
# Funzione ggplot(dati, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
# aes --> estetica --> come costruire il grafico
# geom_bar --> tipo di geometria, in questo caso istogramma --> gli argomenti della funzione indicano le statistiche e il colore
ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")

# Uso il pacchetto patchwork --> posso mettere i grafici a confronto
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white")
p1 + p2

# Funzione ylim() per eguagliare gli assi dei due grafici
p1 <- ggplot(tabout, aes(x=class, y=p1992, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 <- ggplot(tabout, aes(x=class, y=p2006, color=class)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2


