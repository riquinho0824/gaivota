
# message("DAL is being parsed")


# 🖥 On the Linux server (prod)
# In .bashrc, .profile, systemd service, or Docker:
#   export DATA_PIPELINE_ROOT=/srv/myapp/data-pipelines/outputs

get_data_root_path <- function() { x <- Sys.getenv("DURIN_DATA") ; replace(x, x == "", "data") }
get_data_mart_path <- function() { file.path(get_data_root_path(),"mart") }
get_data_output_path <- function() { file.path(get_data_root_path(),"output") }




get_b3_index <- function() { jsonlite::read_json(file.path(get_data_output_path(),"b3_index.json"),simplifyDataFrame = TRUE) }



open_sales_mart <- function() {
  arrow::open_dataset(
    get_sales_mart_path(),
    format = "parquet"
  )
}

query_sales <- function(year, group) {
  open_sales_mart() |>
    dplyr::filter(year == !!year, group == !!group) |>
    dplyr::select(date, revenue, region) |>
    collect()
}


# message("DAL parse done!")
