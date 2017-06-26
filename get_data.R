source("get_stocks.R")
#shout_list <- NULL
#stxlist <- get_stock_list()

get_quandl_data <- function(stxlist) {
  for(ticker in stxlist) { #gets Volume & AdjVolume, assigns data to ticker_table
    cmd_line <- paste0('myData <- Quandl.datatable("WIKI/PRICES", qopts.columns=c("ticker", "date", "close", "adj_close"), ticker=c("', ticker,'"), date.gte=c("', com.env$start_date, '"), date.lte=c("', com.env$end_date,'"))')
    print(cmd_line)
    eval(parse(text = cmd_line))
    cmd_line <- paste0("var.env$",ticker,"_table <- myData")
    eval(parse(text = cmd_line))
  }
}

get_shout_list <- function(stxlist) {
  shout_list <- NULL
  for(ticker in stxlist) {#gets current shares outstanding
    cmd_line <- paste0("temp_shout <- fread('https://download.finance.yahoo.com/d/quotes.csv?s=",ticker,"&f=j2',colClasses = 'character')")
    eval(parse(text = cmd_line))
    shout_list <- c(shout_list, temp_shout)
    names(shout_list)[length(shout_list)] <- ticker
  }
  return(shout_list)
}


# for (ticker in stxlist) {
#   cmd_line <- paste0("clm <- Quandl.datatable('WIKI/PRICES'), qopts.columns=c('ex-dividend'), ticker = c('",ticker,"'), date.gte = c('2004-01-01'), date.lte = c('2013-03-31'))")
#   eval(parse(text = cmd_line))
#   
# }