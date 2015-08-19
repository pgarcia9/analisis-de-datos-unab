#Definir el directorio de trabajo
setwd("/Users/pacha/Documents/ayudantias/UNAB/econometria/video1")

file <- paste0(getwd(),"/acciones.csv")
data <- read.csv(file=file, head = TRUE)
str(data)

#Ver la correlación entre las variables
X <- data.frame(data$IPSA,data$VAPORES,data$CONCHATORO)
cor(X)

#Graficos y versus x
#install.packages("ggplot2")
library(ggplot2)
qplot(data$VAPORES, data$IPSA, data=data)
qplot(data$CONCHATORO, data$IPSA, data=data)

#Regresiones: y = a + b*x1 + c*x1 + e
fit <- lm(data$IPSA ~ data$VAPORES + data$CONCHATORO)
summary(fit) 
