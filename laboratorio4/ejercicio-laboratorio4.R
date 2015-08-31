# Diccionario de variables
# http://observatorio.ministeriodesarrollosocial.gob.cl/documentos/Libro_de_Codigos_Casen_2013_Base_Principal_Metodologia_Nueva.pdf

###

# Definir carpeta de trabajo, librerías y archivos

setwd("/Users/pacha/analisis-de-datos-unab/laboratorio4/")
list.files()

library(foreign)
library(plyr)

unzip("casen2013.dta.zip")
casen <- read.dta("casen2013.dta")

###

# Limpiar datos y generar variables

data <- casen

keep <- c("expr", "yoprcor", "edad", "esc", "sexo", "region", "rama1", "o10")
data <- data[keep]

data <- data[data$o10 > 30,]
data$WHP <- (data$yoprcor*12)/(data$o10*52)
data$logWHP <- log(data$WHP)

data <- data[(data$edad >= 35 & data$edad <= 45),]

data$exp <- data$edad - data$esc - 5
data <- data[data$exp >= 0,]
data$exp2 <- (data$exp)^2

levels(data$region)
for(i in unique(data$region)) {
  data[paste(i, sep="")] <- ifelse(data$region == i, 1, 0)
}

levels(data$rama1)
data<-data[data$rama1 != "x. no bien especificado",]
data$rama1 <- factor(data$rama1) 
levels(data$rama1)
for(i in unique(data$rama1)) {
  data[paste(i, sep="")] <- ifelse(data$rama1 == i, 1, 0)
}
data <- rename(data, c("l.administrasci\xf3n p\xfablica y defensa" = "admpublica"))

drop <- c("NA")
data <- data[,!(names(data) %in% drop)]

data <- data[complete.cases(data),]

# Regresiones

summary(lm(logWHP ~ sexo + esc + exp + exp2 + metropolitana + admpublica, data = data))

summary(lm(logWHP ~ sexo + esc + exp + exp2 + metropolitana + admpublica, data = data, weights = expr))