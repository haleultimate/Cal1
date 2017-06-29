#init.R
remove(list = ls())
var.env <<- new.env(parent=globalenv())
com.env <<- new.env(parent=globalenv())

com.env$start_date <- "2000-01-01"
com.env$end_date <- "2017-06-19"

library(Quandl)
library(dplyr)
library(data.table)
library(xts)
Quandl.api_key("uTjzMRaw3tYDH6Dsbh2A")
source("get_data.R")
source("get_stocks.R")
source("get_shout.R")  #load function libraries
