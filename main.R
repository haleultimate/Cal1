# start_date <- "2000-01-01"
# end_date <- "2017-06-19"
# library(Quandl)
# library(dplyr)
# library(data.table)
# source("get_data.R")
# source("get_shout.R")
source("init.R")
stxlist <- get_stock_list()
get_quandl_data(stxlist)     #adjusted shares stored in var.env
com.env$shout_list <- get_shout_list(stxlist)
shout_table <- calc_shout(stxlist)
save(shout_table,file = ".data",envir = .GlobalEnv)