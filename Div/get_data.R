get_div_data <- function(stxlist) {
  for (ticker in stxlist) {
    cmd_line <- paste0("var.env$",ticker," <- Quandl.datatable('WIKI/PRICES', qopts.columns=c('date','ex-dividend'), ticker = c('",ticker,"'), date.gte = c('2004-01-01'), date.lte = c('2013-03-31'))")
    print(cmd_line)
    eval(parse(text = cmd_line))
    cmd_line <- paste0("ticker_table <- var.env$",ticker)
    eval(parse(text = cmd_line))
    if(length(ticker_table[,1]) < 252){
        print(ticker)
    }
  }
}