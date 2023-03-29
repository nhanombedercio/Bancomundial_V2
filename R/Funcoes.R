

   
################################################################################
####################### FUNCOES PARA APP SUSAMATI ###########################################
################################################################################
 
##Funcao para instalar pacotes importantes
install_data_packages <- function() {
  packages <- c("ggthemes","RColorBrewer","leaflet","esquisse", "sf","shiny", "shinythemes", "shinydashboard", "shinyWidgets", "DT", "ggplot2", "leaflet", "plotly", "flexdashboard", "shinyjs","tidyverse", "data.table", "dplyr", "readr", "readxl", "googlesheets4", "jsonlite", "httr", "stringr", "lubridate", "janitor")
    # Verifica se cada pacote da lista está instalado e instala se não estiver
  # Verifica se cada pacote da lista está instalado e instala se não estiver
  for (package in packages) {
    if (!requireNamespace(package, quietly = TRUE)) {
      install.packages(package)
      
    } else {
      print("PACOTE INSTALADO E CARREGADO")
    }
  }
  
  # Carrega todos os pacotes instalados
  #library(packages)
  # Carrega todos os pacotes instalados
  lapply(packages, library, character.only = TRUE)
 # print("PACOTE INSTALADO E CARREGADO")
}
   
 
  
   
## funcao para criar as minhas base de dados 
  # a funcao cria a base de dados com base em filtro de district_ID
  base_dado <- function(nome_base_dados, coluna_filtro,objeto_filtro){
    resultado <- nome_base_dados %>% filter({{ coluna_filtro }} %in%  objeto_filtro)
    return(resultado)
  
  }
  
 

##funcao para contar numero de observacoes da variavel que quero plotar 
  
  create_summary_table <- function(data, group_vars, count_var) {
   summary_table <- data %>%
      group_by(across(all_of(group_vars))) %>%
     summarise(Total= n()) %>%
      mutate(percentagem = round(Total / sum(Total)*100, digits = 2 ))
     
    return(summary_table)
  }
  
 
###alterar observacoes
  alterar_observacoes <-  function(df, column_name, old_value, new_value) {
    df[[column_name]] <- replace(df[[column_name]], df[[column_name]] == old_value, new_value)
    return(df)
  }
 
  ## funcao que cria um grafico
  grafico <- function(dados, x, y, fill, dados_total, string_familias){
    library(ggplot2)
    ggplot(dados, aes(text =paste("Numero de familias:", {{y}}, "de", nrow(dados_total), string_familias),x = {{x}}, y = {{y}}, fill = {{fill}})) +
            geom_col() +
            scale_fill_hue(direction = 1) +ggthemes::theme_stata()+labs(subtitle = "Linha preta representa o numero total de familias entrevistadas",
                                                                x="",
                                                                 y="Numero de Familias"
                                                                )+theme(legend.position = "top")+
 scale_y_continuous(limits = c(0,300), breaks = seq(0,300,by=50))
    
             
  }
  #esquisser(dados_monapo)
## funcao que cria mapas 
  
  #A função recebe os seguintes parâmetros:
    
  #dados: o conjunto de dados que será usado para criar o mapa
  #coluna_fill: o nome da coluna que será usada para preencher as cores das regiões do mapa
  #coluna_size: o nome da coluna que será usada para definir o tamanho das regiões do mapa
  #coluna_group: o nome da coluna que será usada para agrupar as regiões do mapa
  #palette: a paleta de cores que será usada para preencher as regiões do mapa (padrão: "Blues")
  #facet_col: o nome da coluna que será usada para criar as facetas do mapa (padrão: "tipo_casa_banho1")
 
   
### juntar base de dados 
  juntar_bases <- function(base1, base2, coluna_comum) {
    # Faz o join das bases de dados por uma coluna em comum
    resultado <- left_join(base1, base2, by = coluna_comum)
    
    # Retorna o resultado
    return(resultado)
  }


###mapa 
 #esquisser(dados_monapo)

  criar_mapa_sf <- function(dados, x, y, fill){
    library(jsonlite)
    ggplot(dados) +
      aes(x = {{x}}, y = {{y}}, fill = {{fill}}) +
      geom_sf(size = 1.2) +
      scale_fill_gradient() +
      theme_bw() +
      facet_wrap(vars(fill), nrow = 1L) +
      xlab("Longitude") +
      ylab("Latitude") +
      theme(plot.title = element_text(size = 20, hjust = 0.5, face = "bold"),
            plot.subtitle = element_text(size = 16, hjust = 0.5),
            axis.text = element_text(size = 14),
            axis.title = element_text(size = 16))
    
  }

 ## Thema de mapa
 
  #geom_hline(aes(yintercept = nrow(dados))) +