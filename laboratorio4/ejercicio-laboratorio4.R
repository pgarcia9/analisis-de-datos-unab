# Diccionario de variables
# http://observatorio.ministeriodesarrollosocial.gob.cl/documentos/Libro_de_Codigos_Casen_2013_Base_Principal_Metodologia_Nueva.pdf

###

# Definir carpeta de trabajo, librerías y archivos

setwd("/Users/pacha/analisis-de-datos-unab/laboratorio4/")
list.files()

library(foreign)
library(plyr)
library(dummy)

unzip("casen2013.dta.zip")
casen <- read.dta("casen2013.dta")

###

# Limpiar datos y generar variables

data <- casen

keep <- c("expr", "yoprcor", "edad", "esc", "sexo", "region", "o10")
data <- data[keep]

data <- na.omit(data)

data <- rename(data, c("expr"="pondera", "yoprcor"="yopraj"))

data <- data[data$o10 > 30,]
data$WHP <- (data$yopraj*12)/(data$o10*52)
data$logWHP <- log(data$WHP)

data <- data[(data$edad >= 35 & data$edad <= 45),]

data$exp <- data$edad - data$esc - 5
data <- data[data$exp >= 0,]
data$exp2 <- (data$exp)^2

levels(data$region)

for(i in unique(data$region)) {
  data[paste(i, sep="")] <- ifelse(data$region == i, 1, 0)
}

# Regresiones

summary(lm(logWHP ~ sexo + esc + exp + exp2 + metropolitana, data = data))

summary(lm(logWHP ~ sexo + esc + exp + exp2 + metropolitana, data = data, weights = pondera))