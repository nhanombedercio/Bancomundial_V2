##Criar base de dados 

setwd("C:/Users/Dercio/OneDrive - ASSOCIAÇÃO PARA O EMPODERAMENTO DA RAPARIGA-MUVA/Linkadosssss 2023/PROJECTOS/SISTEMA DE MONITORIA/Bancomundial_V2")

## gravar as base de dados.
all_presencas <- readRDS("data/1.zoho/3.clean/all_presencas.rds")
fnm_presenca <- readRDS("data/1.zoho/3.clean/fnm.rds")
sgr_presencas <- readRDS("data/1.zoho/3.clean/sgr.rds")

emprendedoras <- readRDS("data/0look_ups/emprendedoras.rds")

emprendedoras_cresca=emprendedoras %>% dplyr::filter(grupo_accronym=="SGR")

## 
#install.packages("rio")
library(rio)
#export_excel(all_presencas, "exemplo.xlsx")
export(all_presencas,  tempfile(fileext = "der.xlsx"))
