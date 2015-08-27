##Pregunta 1
#Considere el vector

x <- c(0.18, -1.54, 0.42, 0.95)

#y los ponderadores

w <- c(2, 1, 3, 1)

#Encuentre el valor de $\mu$ que minimiza la ecuación de mínimos cuadrados $\Sigma_{i=1}^n w_i(x_i-\mu)^2$. Hágalo de las siguientes formas:

#1. Algebraicamente
#2. En Excel (el archivo con los datos es <a href="http://pachamaltese.github.io/econometria/laboratorio2/laboratorio2-pregunta1.xlsx">laboratorio2-pregunta1</a>)
#3. En R

###Desarrollo

####Algebraicamente

#Sea $S = \displaystyle\Sigma_{i=1}^n w_i(x_i-\mu)^2$

#$S = \displaystyle\Sigma_{i=1}^n w_i(x_i^2-2x_i\mu+\mu^2)$

#$S = \displaystyle\Sigma_{i=1}^n w_ix_i^2 -2\mu\displaystyle\Sigma_{i=1}^n w_ix_i +\mu^2\displaystyle\Sigma_{i=1}^n w_i$

#$\displaystyle \frac{dS}{d\mu} = 0 \Leftrightarrow -2\displaystyle\Sigma_{i=1}^n w_ix_i +2\mu^* \displaystyle\Sigma_{i=1}^n w_i = 0$ 

#$\displaystyle \frac{dS}{d\mu} = 0 \Leftrightarrow \mu^* = \frac{\Sigma_{i=1}^n w_ix_i}{\Sigma_{i=1}^n w_i}$

####Excel
#Ver archivo <a href="http://pachamaltese.github.io/econometria/laboratorio2/laboratorio2-desarrollo-pregunta1.xlsx">laboratorio2-desarrollo-pregunta1.xlsx</a>

####R
#El promedio ponderado se obtiene con el siguiente comando

weighted.mean(x, w) # 0.1471


##Pregunta 2
#Considere los vectores

y <- c(12.96, 5.15, 9.07, 5.36, 13.68, 11.86, 22.49, 6.54, 17.98, 11.43, 9.73, 5.44, 5.73, 8.84, 3.78, 4.74, 4.62, 3.92, 5.2)
x1 <- c(2, 6, 3, 5, 3, 3, 0, 4, 2, 4, 5, 7, 5, 4, 9, 6, 7, 7, 7)
x2 <- c(57.5, 83.2, 67, 92.7, 40.7, 79.8, 23.5, 81, 64.4, 65.8, 69.3, 72.9, 107.5, 92.1, 86.1, 89.4, 93.3, 107.1, 116.9)

#Obtenga el vector $\beta = (\beta_0,\beta_1,\beta_2)$ usando la ecuación $\beta = (X'X)^{-1}(X'Y)$. Resuelva usando algebra matricial.

###Desarrollo

#Vemos la dimensión de y 
length(y)

#Convertimos los vectores x1 y x2 a matrices de 19x1
X1 <- matrix(x1, ncol=1, nrow=19)
X2 <- matrix(x2, ncol=1, nrow=19)

#Hay que crear una matriz X0 de 19x1 para estimar un modelo con constante
X0 <- matrix(c(rep(1,19)), ncol=1, nrow=19)

#Armamos la matriz X a partir de X0,X1,X2
X <- cbind(X0, X1, X2) 

#Obtenemos X'X e invertimos
#Sea A = (X'X)^-1
A <- solve(t(X) %*% X)

#Obtenemos X'Y
#Sea B = X'Y
Y <- matrix(y, ncol=1, nrow=19)
B <- t(X) %*% Y

#Obtenemos ß
beta <- A %*% B
beta



##Pregunta 3
#Considere los siguientes vectores de datos

x <- c(0.8, 0.47, 0.51, 0.73, 0.36, 0.58, 0.57, 0.85, 0.44, 0.42)
y <- c(1.39, 0.72, 1.55, 0.48, 1.19, -1.59, 1.23, -0.65, 1.49, 0.05)

#Estime una regresión desde el origen y obtenga la pendiente considerando $y$ como la variable dependiente y $x$ como la variable independiente. ¿Cómo cambia su resultado si estima un modelo con constante?

###Desarrollo
#Regresión tal que $\beta_0$ pasa por el origen

fit.sc <- lm(y ~ x - 1) #modelo sin constante
summary(fit.sc) # 0.8263

fit.c <- lm(y ~ x) #modelo con constante
summary(fit.c) #-1.713


##Pregunta 4
#Usando la base de datos mtcars estime un modelo que considere mpg como variable independiente y la weight como variable independiente. Almacene la pendiente del modelo en memoria con el nombre "beta.1".

###Desarrollo

data(mtcars) #para cargar la librería en memoria
fit <- lm(mpg ~ wt, mtcars)
summary(fit) # -5.3445
beta.1 <- fit$coefficients[2]


##Pregunta 5
#A partir del archivo Excel utilizado en el Laboratorio 1 (<a href="http://pachamaltese.github.io/econometria/laboratorio1/laboratorio1.xlsx">laboratorio1.xlsx</a>) obtenga las mismas regresiones (con y sin constante) utilizando R. Para esto siga los siguientes pasos:

#1. Definir variables en memoria y cargar librerías
## + Definir el directorio de trabajo.
#  + Instalar una librería que permita leer archivos XLSX. Usaremos XLConnect cuya documentación se puede ver en <a href="https://cran.r-project.org/web/packages/XLConnect/XLConnect.pdf">https://cran.r-project.org/web/packages/XLConnect/XLConnect.pdf</a>.
#  + Cargar la librería XLConnect.
#  + Leer el archivo del Laboratorio 1.
#  + Asignar nombres <b>simples</b> a las columnas ($y$, $x_1$, $x_2$).
#2. Haga un gráfico de cada variable explicativa sobre la explicada ¿Hay correlación entre ellas?
#  + Instalar y cargar en memoria ggplot (librería para graficar)
#  + Graficar $y$ versus $x_1$ e $y$ versus $x_2$.
#  + Ver la correlación entre las variables.
#3. Calcule el estimador de los parámetros.
#  + Hacer una regresión sin constante.
#  + Hacer una regresión con constante

###Desarrollo


#1. Definir variables en memoria y cargar librerías
#Definir el directorio de trabajo
dir <- "/Users/pacha/pachamaltese.github.io/econometria/laboratorio1"

#Instalar una librería que permita leer archivos XLSX
#install.packages("XLConnect") #desmarcar si no está instalada

#Cargar la librería XLConnect
library(XLConnect)

#Leer el archivo del Laboratorio 1
file <- paste0(dir,"/laboratorio1.xlsx")
data <- readWorksheetFromFile(file, sheet = "Hoja1", region = "A2:C20", header = FALSE)
data

#Asignar nombres simples a las columnas
colnames(data) <- c("y", "x1", "x2")
data

#2. Haga un gráfico de cada variable explicativa sobre la explicada ¿Hay correlación entre ellas?

#Instalar y cargar en memoria ggplot (librería para graficar)
#install.packages("ggplot2") #desmarcar si no está instalada
library(ggplot2)

#Graficar y versus x1 e y versus x2
qplot(x1, y, data=data)
qplot(x2, y, data=data)

#Ver la correlación entre las variables
cor(data)

#Calcule el estimador de los parámetros

#Hacer una correlación sin constante
regression_nocons <- lm(y ~ x1 + x2 -1, data=data)
summary(regression_nocons) 

#Hacer una regresión con constante
regression_cons <- lm(y ~ x1 + x2, data=data)
summary(regression_cons)
