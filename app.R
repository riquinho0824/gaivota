# ────────────────────────────────────────────────
# app.R
# Description: Execute the app in cloud services
# ────────────────────────────────────────────────
# 
# 
# 
# source("app.R")
# 
# 
#
print("app.R script start")
# Pacakges load ################################################################
# Installs pacman ("package manager") if needed
if (!require("pacman")) install.packages("pacman")
# Use pacman to load add-on packages as desired
# Packages I load every time; uses "pacman"
pacman::p_load(pacman,tidyverse,rio,jsonlite,treemapify)
# 
print("app.R packages loaded")
# 
# Initial load #################################################################


# library(gaivotapp)
# gaivotapp::run_app()


# app.R
# Works when the package is NOT installed (Shiny mode)

pkgload::load_all(export_all = FALSE)
# Run ##########################################################################
run_app()

# shinyApp(ui = ui, server = server)