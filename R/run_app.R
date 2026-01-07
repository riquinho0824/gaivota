
if(F){

  rsconnect::writeManifest()      # update manifest.json used in shinny apps
  renv::snapshot()                # update renv.lock with all packages used in this project
  # Golem app is an R package
  # Code changes require:
  devtools::document()
  # devtools::load_all() # devtools::document() already load all
  run_app()
  
  
  
  
  renv::status()
  
  devtools::load_all("../quantamental.data")
  
  tail(get_b3_index()$IBOV)
  test_external_dal()
  
  Sys.getenv("DURIN_DATA")
  
  renv::install(
    "your-org/quantamental-platform/packages/quantamental.data"
  )
  
  
  renv::snapshot()
  renv::record(
    list(
      quantamental.data = list(
        Source = "path",
        Path   = "/quantamental.data",
        Package = "quantamental.data",
        Version = "0.1.0"
      )
    )
  )
  

}

#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts.
#' See `?golem::get_golem_options` for more details.
#' @inheritParams shiny::shinyApp
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  onStart = NULL,
  options = list(),
  enableBookmarking = NULL,
  uiPattern = "/",
  ...
) {
  golem::with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server,
      onStart = onStart,
      options = options,
      enableBookmarking = enableBookmarking,
      uiPattern = uiPattern
    ),
    golem_opts = list(...)
  )
}
