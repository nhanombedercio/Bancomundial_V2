library(shinydashboard)
library(ggplot2)
library(plotly)
library(dplyr)
library(sf)
library(RColorBrewer)
library(shinythemes)
library(readxl)
library(shinyWidgets) 
library(terra)
install_data_packages()


# Define UI
ui <- fluidPage(
  
  #shinyjs::useShinyjs(),
  # Define o tema
  theme = shinytheme("flatly"),
  
  #uiOutput("last_refreshed"),
  # Define a barra de navegação
  navbarPage(
    # Define o título da barra de navegação
    title = "REALIZA" ,  
    id = "Paneles",
    tags$head(tags$style(HTML('.navbar-default {background-color: #76004B;}'))),
    #title = "ASSOCIAÇÃO MUVA",
    #BASELINE  
    navbarMenu("OVERVIEW", icon=icon("exchange-alt"),
               tabPanel(value = "tab1", title = "PARTICIPANTES",tabname="tab_overview_PARTICIPANTE", icon=icon("chart-line"),
                        # Define as colunas do layout de grade
                      #  ui_totals("Totals")
                        
               ), 
               
               
    ), # OVERVIEM
    
    ##CRESÇA
    navbarMenu("CRESÇA",
               tabPanel(value = "tab2", title = "PARTICIPANTES",
                        # Define as colunas do layout de grade
                        #ui_participacaoSGR("part_sgr")  
                        column(3,
                               wellPanel(selectInput("by", 
                                                     label = h4("Números da operação por:"),
                                                     choices =c("Seu todo" ,"Por cidade")         
                               )),
                               
                        ),
                        
                        
                        column(9,h4("Número de mulheres que participaram de cada sessão. 
                         A linha preta indica o número de mulheres incluídas nas listas do Banco Mundial."),
                               mainPanel(
                                 #uiOutput("header"),
                                 #withSpinner(
                                  # plotlyOutput("plot",
                                    #            height = "300px")
                                   #, color = "black"),
                               #),
                               plotlyOutput("tab2_participante", height = 600)
                        ),
                        
                        
               ), 
               tabPanel(value = "tab3", title = "SESSÕES OBRIGATORIAS",
                        
                        # Define as colunas do layout de grade
                        #ui_80_perc("perc_80")                  
                        
                        
               ), 
    ),), # CRESÇA 
    
    ##MOVIMENTA
    navbarMenu("MOVIMENTA",
               tabPanel("PARTICIPANTES",
                        tabsetPanel(
                          tabPanel("FNM", tabname="tab_FNM_PARTICIPANTE", icon=icon("chart-line"),
                                   # Define as colunas do layout de grade
                                   column(3,
                                          wellPanel(h4("colocamos aqui os filtros")),
                                          
                                   ),
                                   
                                   
                                   column(9,
                                          plotOutput("movimenta_FNM_participante")
                                   ),            
                                   
                          ),  ## chegar FNM participantes     
                          tabPanel("SGR", tabname="tab_SGR_PARTICIPANTE",
                                   column(3,
                                          wellPanel(h4("colocamos aqui os filtros")),
                                   ),
                                   
                                   
                                   column(9,
                                          plotOutput("movimenta_SRG_participante")
                                   ),   
                                   
                                   
                          ),  ## chegar FNM participantes  
                        )
                        
               ), 
               
               tabPanel("SESSÕES OBRIGATORIAS",
                        tabsetPanel(
                          tabPanel("FNM", tabname="tab_FNM_Sobrig",
                                   column(3,
                                          wellPanel(h4("colocamos aqui os filtros")),
                                   ),
                                   
                                   
                                   column(9,
                                          plotOutput("movimenta_FNM_obrigatorio")
                                   ),      
                                   
                          ),  ## chegar FNM participantes     
                          tabPanel("SGR", tabname="tab_SGR_Sobrig",
                                   column(3,
                                          wellPanel(h4("colocamos aqui os filtros")),
                                   ),
                                   
                                   
                                   column(9,
                                          plotOutput("movimenta_SGR_obrigatorio")
                                   ), 
                                   
                                   
                          ),  ## chegar FNM participantes  
                        )
               ), 
    ), # MOVIMENTA 
    
    ##CONECTA
    navbarMenu("CONECTA",
               tabPanel("PARTICIPANTES",
                        
                        column(3,
                               wellPanel(h4("colocamos aqui os filtros")),
                        ),
                        
                        
                        column(9,
                               plotOutput("conecta_participante")
                        ),          
                        
                        
               ), 
               
               tabPanel("SESSÕES OBRIGATORIAS",
                        column(3,
                               wellPanel(h4("colocamos aqui os filtros")),
                        ),
                        
                        
                        column(9,
                               plotOutput("conecta_obrigatorio")
                        ),       
                        
                        
                        
                        
               ), 
    ), # CONECTA 
    
    
  )
  
)

# Define o servidor
server <- function(input, output, session) {

  

  
  #define path to data (data is saved in repo /realiza)===========================
 
   
# Execute o aplicativo Shiny
}
shinyApp(ui, server)
