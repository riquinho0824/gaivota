#' Check if quantamental data is available
#'
#' @return logical
#' @export
has_data <- function() {
  root <- get_data_root()
  nzchar(root) && dir.exists(root)
}
