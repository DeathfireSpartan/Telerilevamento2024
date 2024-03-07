# First R script

# R as a calculator
a <- 42 * 117
b <- 99 * 666

a + b

# Arrays --> vettori --> funzione c(x, y, z, ...)

flowers <- c(3, 6, 8, 10, 15, 18)
flowers

insects <- c(10, 16, 25, 42, 61, 73)
insects

# Funzione plot() e argomenti per modificare il grafico

plot(flowers, insects)

# Cambiare i parametri del grafico

# Simboli
plot(flowers, insects, pch=19)

# Dimensione dei simboli (cex=2 simboli grandi il doppio, cex=0.5 simboli la metà della grandezza originale)
plot(flowers, insects, pch=19, cex=2)

# Colore simboli (col="nomecolore")
plot(flowers, insects, pch=19, cex=2, col="hotpink1")

#
