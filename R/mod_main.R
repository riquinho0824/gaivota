

# message("mod_main is being parsed")

#' main UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_main_ui <- function(id) {
  ns <- NS(id)
  tagList(

    h3("Asset metadata"),
    tableOutput(ns("asset_table"))

  )
}

#' main Server Functions
#'
#' @noRd
mod_main_server <- function(id){
  moduleServer(id, function(input, output, session){
    ns <- session$ns

    output$asset_table <- renderTable({
      b3_index <- get_b3_index()
      b3_index$IBOV
    })

  })
}

## To be copied in the UI
# mod_main_ui("main_1")

## To be copied in the server
# mod_main_server("main_1")



# message("mod_main parse done!")
