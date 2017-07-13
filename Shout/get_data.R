source("Shout/get_stocks.R")
com.env$shout_list <- NULL
stxlist <- get_stock_list()

# get_quandl_data <- function(stxlist) {
#   Sys.setenv(TZ = "UTC")
#   for (ticker in stxlist) {
#     #gets Volume & AdjVolume, assigns data to ticker_table
#     cmd_line <-
#       paste0(
#         'myData <- Quandl.datatable("WIKI/PRICES", qopts.columns=c("ticker", "date", "volume", "adj_volume"), ticker=c("',
#         ticker,
#         '"), date.gte=c("',
#         com.env$start_date,
#         '"), date.lte=c("',
#         com.env$end_date,
#         '"))'
#       )
#     print(cmd_line)
#     eval(parse(text = cmd_line))
#     if (length(myData[, 1]) == 0) {
#       cmd_line <-
#         paste0(
#           "getSymbols(Symbols ='",
#           ticker,
#           "',env=var.env,src = 'yahoo', index.class = 'POSIXct',from = '",
#           com.env$start_date,
#           "', to = '",
#           com.env$end_date2,
#           "',)"
#         )
#       print(cmd_line)
#       eval(parse(text = cmd_line))
#       cmd_line <-
#         paste0(
#           "var.env$",
#           ticker,
#           " <- data.frame(index(var.env$",
#           ticker,
#           "),var.env$",
#           ticker,
#           "[,4],var.env$",
#           ticker,
#           "[,6])"
#         )
#       print(cmd_line)
#       eval(parse(text = cmd_line))
#     }
#     else {
#       cmd_line <- paste0("var.env$", ticker, " <- myData[,2:4]")
#       print(cmd_line)
#       eval(parse(text = cmd_line))
#     }
#   }
# }
get_data <- function(stxlist) {
  for (ticker in stxlist) {
    cmd_line <-
      paste0(
        "var.env$",
        ticker,
        " <- Quandl('EOD/",
        ticker,
        "',api_key = 'uTjzMRaw3tYDH6Dsbh2A',
        start_date = '",
        com.env$start_date,
        "',end_date = '",
        com.env$end_date,
        "',type = 'xts',)"
      )
    print(cmd_line)
    eval(parse(text = cmd_line))
  }
}

get_shout_list <- function(stxlist) {
  shout_list <- NULL
  for (ticker in stxlist) {
    #gets current shares outstanding
    cmd_line <-
      paste0(
        "temp_shout <- fread('https://download.finance.yahoo.com/d/quotes.csv?s=",
        ticker,
        "&f=j2',colClasses = 'character')"
      )
    eval(parse(text = cmd_line))
    shout_list <- c(shout_list, temp_shout)
    names(shout_list)[length(shout_list)] <- ticker
  }
  shout_list["XLF"] <- 877200000
  shout_list["GDX"] <- 4107789855.07
  shout_list["XLE"] <- 241196917.032
  return(shout_list)
}


# for (ticker in stxlist) {
#   cmd_line <- paste0("clm <- Quandl.datatable('WIKI/PRICES'), qopts.columns=c('ex-dividend'), ticker = c('",ticker,"'), date.gte = c('2004-01-01'), date.lte = c('2013-03-31'))")
#   eval(parse(text = cmd_line))
#
# }