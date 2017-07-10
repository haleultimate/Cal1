calc_div <- function(stxlist){
  for(ticker in stxlist){
    cmd_line <- paste0("ticker_table <- var.env$",ticker)
    print(cmd_line)
    eval(parse(text = cmd_line))
    n <- nrow(ticker_table)
    div_col <- NULL
    total <- 0
    for (i in 0:251){
     total <- total + as.numeric(ticker_table[n-i,'ex-dividend']) 
     }
    div_col[[n]] <- total 
    for(i in (n-1):252){
      div_col[i] <- div_col[[i+1]] - as.numeric(ticker_table[i+1,'ex-dividend']) + as.numeric(ticker_table[i-251,'ex-dividend'])
    }
    print(str(div_col))
    ticker_table <- cbind(ticker_table,div_col)
    print(str(ticker_table))
    cmd_line <- paste0("var.env$",ticker," <- ticker_table")
    print(cmd_line)
    eval(parse(text = cmd_line))
  }
}