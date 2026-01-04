#' Resolve quantamental data root
#'
#' Priority:
#' 1. DATA_ROOT environment variable
#' 2. Package snapshot in inst/extdata
#'
#' @return character path
#' @export
get_data_root <- function() {
  root <- Sys.getenv("DURIN_DATA", "")
  if (nzchar(root)) {
    return(normalizePath(root, mustWork = TRUE))
  }

  system.file("extdata", package = "quantamental.data")
}


#' Root data path
#'
#' @return character path
#' @export
get_data_root_path <- function() { x <- Sys.getenv("DURIN_DATA") ; replace(x, x == "", "data") }

#' Data marts path
#'
#' @return character path
#' @export
get_data_mart_path <- function() { file.path(get_data_root_path(),"mart") }

#' Output data path
#'
#' @return character path
#' @export
get_data_output_path <- function() { file.path(get_data_root_path(),"output") }


