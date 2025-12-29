#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      # golem::golem_welcome_page() # Remove this line to start building your UI
      
      
      theme = bslib::bs_theme(
        bg = "#212121",
        fg = "#eaeaea",
        primary = "#0d6efd"),
        

        # h1("Main Page (3)"),
        # mod_asset_ui("main_page")
        # mod_main_ui("main_page")
        
        
        tabsetPanel(
          tabPanel("| | |",mod_asset_ui("quantamental_first_page")),
          # tabPanel("Directory landscape", uiOutput("directory")),
          # tabPanel("Screener", uiOutput("screening")),
          # tabPanel("Earnings Calendar", uiOutput("earnings")),
          # tabPanel("Growth", uiOutput("growth")),
          # 
          # # tabPanel("DI Curve"    , uiOutput("di_curve")),
          # tabPanel("Futures",tabsetPanel(
          #   tabPanel("Brazilian DI Curve",uiOutput("di_curve")),
          #   tabPanel("Oil Curve",uiOutput("oil_curve")))),
          # 
          # tabPanel("BTG reports",uiOutput("btg_reports"))
        )


    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  # add_resource_path(
  #   "www",
  #   app_sys("app/www")
  # )  
  
  shiny::addResourcePath(
    prefix = "www",
    directoryPath = app_sys("app/www")
  )

  tags$head(
    # tags$link( rel="stylesheet",type="text/css",href="www/dark_mode.css"),
    golem::favicon(),
    # golem::favicon(ico = "www/eagle-favicon.ico"),
    golem::bundle_resources(
      path = app_sys("app/www"),
      app_title = "gaivotapp"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
