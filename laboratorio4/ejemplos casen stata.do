clear all
cd "/Users/pacha/analisis-de-datos-unab/laboratorio4/"
set mem 3000m
use casen2013
set more off
keep expr yoprcor edad esc rama1 region sexo o10
drop if yoprcor == .
drop if region == .
drop if o10 == .
drop if edad == .
drop if rama1 == 99
drop if rama1 == .
drop if esc == .
drop if sexo == .

rename expr pondera
rename yoprcor yopraj

* Ingreso por hora
gen HW=((yopraj*12)/52)/o10
gen ln_HW=ln(HW+1)

* Experiencia
gen exp=edad-esc-5 if edad>=15
replace exp=0 if exp<0 & exp!=.

* Experiencia al cuadrado
gen exp2=exp*exp

* Controles (Rama, Oficio, Categoría, Región, Educ, Tamaño Empresa)
quietly tabulate rama1, generate(rama1_)
quietly tabulate region, generate(region_)

reg ln_HW esc exp exp2 sexo $rama_d [pw=pondera]

reg ln_HW esc exp exp2 sexo rama* [pw=pondera]

keep ln_HW esc exp exp2 sexo rama*
