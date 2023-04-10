####Grafico SGR
install_data_packages()

#presente
#######participantes 
Se_coaching<-unique(all_presencas) %>% filter(actividade=="Sessões de coaching")
 
  library(dplyr)
library(lubridate)
 
 
# criação da coluna "tipo de data"
 
sgr_presencas$tipo_sessao_coaching <- ifelse(sgr_presencas$Emprendedora == lag(sgr_presencas$Emprendedora) & 
                                       sgr_presencas$Emprendedora == lead(sgr_presencas$Emprendedora),
                                     "Sessões de coaching 2", 
                                     ifelse(sgr_presencas$Emprendedora == lag(sgr_presencas$Emprendedora) & is.na(lag(sgr_presencas$Emprendedora)),
                                            "Sessões de coaching 1",
                                            "Sessões de coaching 3"))

 all_presencas1<- all_presencas

all_presencas1$tipo_sessao_coaching <- ""
empreendedoras <- unique(all_presencas1$Emprendedora)

for (i in 1:length(empreendedoras)) {
  emp <- empreendedoras[i]
  count_data <- 0
  
  for (j in 1:nrow(all_presencas1)) {
    if (all_presencas1[j,"Emprendedora"] == emp) {
      count_data <- count_data + 1
      all_presencas1[j,"tipo_sessao_coaching"] <- paste0("Sessões de coaching", count_data)
    }
  }
}

table(Se_coaching$tipo_sessao_coaching)






table(sgr_presencas$tipo_sessao_coaching)
 
###SGR
filtro_cresca <- selectInput("by_cresca", 
                          label = h4("Números da operação por:"),
                          choices = c("Seu todo", "por cidade"))

###SGR obrigatorias
filtro_cresca_obr <- selectInput("by_cresca_obr", 
                             label = h4("Números da operação por:"),
                             choices = c("Seu todo", "por trimestre"))

### tabela que calcula o numero de empreendedoras presentes por sessao por seu todo

presencas_cresca_all<-all_presencas %>% dplyr::filter(presente==TRUE) %>%
  group_by(Grupo, grupo_accronym,actividade, presente)  %>%  
  summarise(n=n())

### tabela que calcula o numero de empreendedoras presentes por sessao por cada cidade
presencas_cresca_cidade<-all_presencas %>% dplyr::filter(presente==TRUE ) %>%
  group_by(Cidade, Grupo, grupo_accronym,actividade, presente)  %>% 
  summarise(n=n())  


###tabela que calcula numero de empreendedoras por cidade
      ## sera utilizado para tracar as linhas pretas no grafico
tab_cresca_cidade<-emprendedoras_cresca %>% filter(grupo_accronym %in% "SGR") %>% 
  group_by(Cidade) %>% summarise(n=n())  

##grafico de cresca por todo
grafico_cresca_all<-  presencas_cresca_all %>% filter(grupo_accronym %in% "SGR") %>%
  ggplot() +
  aes(text =paste("Presenciais:", n, "de", nrow(emprendedoras_cresca), "nas listas de BM"), x = actividade, y = n,fill = grupo_accronym) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_bw() +scale_fill_manual(name = "",
                                values = palette)+labs(
                   y = "Numero de mulheres",
                     x = ""
                  )+theme(axis.text.x = element_text(angle = 90,
                                                    size = 10),
                        axis.text.y = element_text(size = 12)) + 
geom_hline(aes(yintercept=nrow(emprendedoras_cresca)))+
 scale_y_continuous(limits = c(0,400), breaks = seq(0,400,by=50))


##grafico de cresca por cidade
grafico_cresca_cidade<-presencas_cresca_cidade %>% filter(grupo_accronym %in% "SGR") %>%
  ggplot() +
  aes(text =paste("Presenciais:", n, "de",tab_cresca_cidade$n, "nas listas de BM"), x = actividade, y = n, fill = Cidade) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_bw()+ facet_wrap(vars(Cidade))+
  scale_fill_manual(name = "",
                    values = palette)+
  labs(
    y = "Numero de mulheres",
    x = ""
  )+theme(axis.text.x = element_text(angle = 90,
                                     size = 10),
          axis.text.y = element_text(size = 12)) + 
    geom_hline(data=tab_cresca_cidade,
               aes(yintercept= n))+facet_wrap(vars(Cidade))+
  scale_y_continuous(limits = c(0,170), breaks = seq(0,170,by=50))

 
#######Sessoes obrigatorias  
 
presenca_obr_cresca_all=all_presencas %>% filter(grupo_accronym %in% "SGR", presente==TRUE, actividade!="Sessão Inaugural")  %>% 
  group_by(Cidade,Emprendedora) %>% summarise(n=n())  %>% filter(n>=12) %>% group_by(Cidade) %>% summarise(n=n()) 
  
#text =paste("Presenciais:", n, "de",tab_cresca_cidade$n, "nas listas de BM")
##text =paste("Numero de empreendedoras:", n, "da lista do banco")
### Grafico sessao obrigatoria por todo 
grafico_cresca_Obr_all<- presenca_obr_cresca_all %>%
  ggplot() +
  aes(x = Cidade, y = n, fill=Cidade) +
  geom_col() +
  scale_fill_hue(direction = 1) +
  theme_bw()+ 
  scale_fill_manual(name = "",
                    values = palette)+
  labs(
    y = "Numero de mulheres",
    x = ""
  )+theme(axis.text.x = element_text(angle = 0,
                                     size = 10),
          axis.text.y = element_text(size = 12)) + 
  geom_point(data=tab_cresca_cidade,
             aes(x=Cidade, y=n),shape = "triangle down filled", 
             size =2, colour = "#112446")+
  scale_y_continuous(limits = c(0,170), breaks = seq(0,170,by=20))
grafico_cresca_Obr_all
###### Grafico sessao obrigatoria trimestre 


all_presencas$abordagem <- ""

all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==1.1, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==1.2, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==1.3, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==2.1, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==2.2, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==2.3, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==3.1, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==3.2, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade==3.3, "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade=="Sessao de encerramento de parceiros", "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade=="Sessao intercalar de parceiros", "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade=="Sessões de coaching", "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$actividade=="Introducao a sessao de parceiros", "SGR")
all_presencas$abordagem<-replace(all_presencas$abordagem, all_presencas$abordagem=="", "FNM")



 






table(all_presencas$actividade,all_presencas$abordagem)
