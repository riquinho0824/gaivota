#' Read asset metadata
#'
#' @return tibble
#' @export
read_asset_metadata <- function() {
  root <- get_data_root()
  meta_dir <- file.path(root, "metadata")

  files <- list.files(meta_dir, pattern = "\\.json$", full.names = TRUE)

  purrr::map_dfr(files, jsonlite::fromJSON, simplifyVector = TRUE)
}


#' Read b3 indexes
#'
#' @return list of tibble
#' @export
get_b3_index <- function() { jsonlite::read_json(file.path(get_data_output_path(),"b3_index.json"),simplifyDataFrame = TRUE) }

#' Read asset ontology
#'
#' @return list of tibble
#' @export
get_ontology <- function() { jsonlite::read_json(file.path(get_data_output_path(),"ontology.json"),simplifyDataFrame = TRUE) }
