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
library(quantmod)
Quandl.api_key("uTjzMRaw3tYDH6Dsbh2A")
source("Shout/get_data.R")
source("C:/RDirectory/Cal1/Shout/get_stocks.R")
source("Shout/calc_shout.R")  #load function libraries
