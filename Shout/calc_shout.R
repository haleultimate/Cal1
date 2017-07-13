calc_shout <- function(stxlist) {
  shout_table <- NULL
  for(ticker in stxlist){
    shout_col <- NULL
    cmd_line <- paste0("ticker_xts <- var.env$",ticker)
    eval(parse(text = cmd_line))
    n <- nrow(ticker_xts)
    print(n)
    shout_col[n] <- as.numeric(com.env$shout_list[[ticker]])
    print(shout_col[n])
    for (i in 0:(n-2)) {
      shout_col[n-i-1] <- shout_col[n-i]/as.numeric(ticker_xts[[n-i,"Split"]])
    }
    print(str(shout_col))
    shout_xts <- xts(shout_col,as.Date(index(ticker_xts)))
    shout_table <- cbind(shout_table,shout_xts)
    print(str(shout_table))
    colnames(shout_table)[ncol(shout_table)] <- ticker
  }
  return(shout_table)
}