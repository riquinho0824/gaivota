#' Asset schema
#'
#' Canonical column names for asset data
#'
#' @export
asset_schema <- c(
  "asset_id",
  "date",
  "price",
  "volume"
)
# 
# 
# 
# Why this matters:
#   This becomes your data contract
# Snowflake tables will match this later