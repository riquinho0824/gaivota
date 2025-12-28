






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

    h3("Asset metadata"),
    tableOutput(ns("asset_table"))


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

  })
}

## To be copied in the UI
# mod_asset_ui("asset_1")

## To be copied in the server
# mod_asset_server("asset_1")
