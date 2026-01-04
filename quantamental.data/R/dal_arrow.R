#' Read asset-level parquet data
#'
#' @param asset_id character
#' @param years integer vector or NULL
#' @param cols character vector or NULL
#' @return tibble
#' @export
read_asset_parquet <- function(asset_input, years = NULL, cols = NULL) {
  root <- get_data_root()

  ds <- arrow::open_dataset(root)

  tbl <- dplyr::filter(ds, asset == asset_input)

  if (!is.null(years)) {
    tbl <- dplyr::filter(tbl, year %in% !!years)
  }

  if (!is.null(cols)) {
    tbl <- dplyr::select(tbl, dplyr::all_of(cols))
  }

  dplyr::collect(tbl)
}
