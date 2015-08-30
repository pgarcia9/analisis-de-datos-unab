setwd("/Users/pacha/analisis-de-datos-unab/laboratorio4/")
list.files()

library(foreign)

data <- read.dta("ejemplo-casen2013.dta")
str(data)

summary(lm(ln_HW ~ sexo + esc + exp + exp2, data = data))

summary(lm(ln_HW ~ sexo + esc + exp + exp2, data = data, weights = pondera))
