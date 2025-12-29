






## Manual testing code — NOT documented
if(F){

  devtools::load_all()
  run_app()



  # do not run this below
  # R files must be in flat folder structure

  #' golem::add_module(name = "asset")
  #' file.rename(
  #'   from = "R/mod_asset.R",
  #'   to   = "R/features/mod_asset.R"
  #' )
  #' #' @import shiny
  #'
  #' # runs roxygen2 and update NAMESPACE
  #' # Controls which functions are visible
  #' # Controls which packages are imported
  #' # Controls what can be used inside your code
  # devtools::document()



}



# Modules define behavior, tabs define navigation.
# Asset is the feature
# Correlation, Share, Summaries are view modules (submodules)

# Canonical rule (remember this)
# In an R package, you never source() your own R code.
# The package loader is responsible for loading code.


# inst/extdata/
# place snapshot data to deploy into Posit













#' asset UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_asset_ui <- function(id) {
  ns <- NS(id)
  tagList(

    # h3("Asset metadata"),
    # tableOutput(ns("asset_table"))
    
    
    
    tabsetPanel(
      tabPanel("Quantamental",uiOutput(ns("quantamental_first_page_explanation"))),
      # tabPanel("Dendrogram", uiOutput("quantamental_first_page_dendrogram")),
      # tabPanel("PCA", uiOutput("quantamental_first_page_pca")),
      # tabPanel("Sankey", uiOutput("sectors_sankey_diagram_ui")),
      # tabPanel("Similarity", uiOutput("quantamental_first_page_similarity")),
      # tabPanel("UMAP", uiOutput("quantamental_first_page_similarity_umap"))
    )


  )
}

#' asset Server Functions
#'
#' @noRd
mod_asset_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$asset_table <- renderTable({
      b3_index <- get_b3_index()
      b3_index$SMLL
    })
    
    
    
    output$quantamental_first_page_explanation <- renderUI({
      fluidRow(align="center",
               br(),fluidRow(
                 column(1,div()),
                 column(10,
                        p(style="text-align: center; font-size: 10px;","Disclaimer: this is not an investment recommendation, this is a statistical study with data visualization "),
                        h1(style="text-align: center; ","Quantamental"),
                        h4(style="text-align: center; ","The term Quantamental is a blend of quantitative and fundamental investing, referring to an investment approach that combines quantitative analysis with traditional fundamental analysis. It aims to integrate the systematic, data-driven rigor of quantitative methods with the qualitative insights of fundamental analysis."),br(),br(),
                        h2("Ibovespa: Benchmark for Brazil’s Equity Market"),
                        p("The Ibovespa Index is the leading performance indicator of stocks traded on B3 – the Brazilian stock exchange. Established in 1968, the index has evolved over more than five decades to become a key reference for global investors, reflecting the overall dynamics of Brazil’s capital markets."),
                        p("Rebalanced every four months, the Ibovespa is a free-float, market-cap-weighted index designed to represent a theoretical portfolio of the most liquid and actively traded stocks in the Brazilian market. It includes common shares, preferred shares, and units of companies listed on B3, provided they meet specific criteria outlined in the index methodology. As a result, the Ibovespa captures approximately 80% of the total trading volume and transaction count on the exchange."),
                        p("This study integrates quantamental analysis, combining quantitative insights with fundamental analysis, to explore historical trends, risk factors, and investment opportunities within the Ibovespa. By leveraging statistical modeling, factor analysis, and macroeconomic correlations, we aim to uncover insights into the performance drivers and strategic implications for investors navigating Brazil’s evolving equity landscape."),
                        p(style="text-align: right; font-size: 10px;","source: https://www.b3.com.br/pt_br/market-data-e-indices/indices/indices-amplos/ibovespa.htm")),
                 column(1,div())
               ),
               #br(),fluidRow(column(2,div()),column(8,plotOutput("screening_sectors_treemap")),column(2,div())),
               br(),fluidRow(
                 column(1,div()),
                 column(10,
                        p("The Ibovespa can be grouped by sector and industry segment, offering valuable insights into the composition and weight distribution of different market segments. The analysis can go even further, extending beyond the index to include the broader market, encompassing Mid and Small Cap companies. This sectoral breakdown helps investors identify structural trends, cyclical patterns, and risk-reward dynamics across different segments of the Brazilian stock market."),
                        p("This application groups stocks using several different classification methods. The color coding highlights the weight distribution within the market:",
                          span(style="background-color: rgba( 16, 78,139, 1);","Blue (60% of IBOV)"),"The largest and most influential stocks (Blue Chips).",
                          span(style="background-color: rgba( 46,139, 87, 1);","Green (remaining IBOV constituents)"),"Other companies included in the Ibovespa.",
                          span(style="background-color: rgba( 67,205,128, 1);","Light Green (SMLL Small Cap Index)"),"Stocks that are part of the Small Caps index.",
                          "This classification provides a granular view of market composition, enabling a deeper understanding of sector-driven performance and potential investment opportunities across different market capitalizations.")),
                 column(1,div())
               ),
               # br(),uiOutput("sectors_sankey_diagram_ui"),
               br(),br(),br()
               # br(),plotOutput("quantamental_dendrogram",height=4000),br(),br(),br()
               # br(),uiOutput("screening_sectors_list"),br(),br(),br()
      )
    })
    
    
    
    output$screening_sectors_treemap <- renderPlot({
      sectors_df <- df %>% left_join(read_IBOV_file(),by="asset") %>% group_by(sector_screening) %>% reframe(share_IBOV=sum(share,na.rm=T),biggest_asset=ifelse(any(!is.na(share)),asset[which.max(share)],""),biggest_share=ifelse(any(!is.na(share)),share[which.max(share)],0)) %>% arrange(desc(share_IBOV))
      
      
      
      
      
      sectors_df %>% 
        ggplot(aes(area=share_IBOV,subgroup=sector_screening),fill="gray55")+geom_treemap(aes(alpha=share_IBOV))+
        geom_treemap_text(aes(label=sector_screening),size=18,alpha=.8,place="top")+#scale_color_identity()+
        geom_treemap_text(aes(label=sprintf("%.1f%%",share_IBOV   )),size=20,colour="black",alpha=.8,place="top",padding.y=grid::unit( 8,"mm"))+
        geom_treemap_text(aes(label=biggest_asset                  ),size=10,colour="black",alpha=.5,place="top",padding.y=grid::unit(17,"mm"))+
        geom_treemap_text(aes(label=sprintf("%.1f%%",biggest_share)),size=10,colour="black",alpha=.5,place="top",padding.y=grid::unit(20,"mm"))+
        # geom_treemap_subgroup_border(colour="gray13")+
        theme_void()+theme(plot.background=element_rect(fill="gray13",colour="gray13"),legend.position="none")
    })

  })
}

## To be copied in the UI
# mod_asset_ui("asset_1")

## To be copied in the server
# mod_asset_server("asset_1")
