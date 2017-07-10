calc_shout <- function(stxlist) {
  com.env$shout_table <- NULL
  ETF_list <- c("XLF", "GDX", "XLE")
  for (ticker in stxlist) {
    if (ticker %in% ETF_list) {
      cmd_line <- paste0("ticker_table <- var.env$",ticker)
      print(cmd_line)
      eval(parse(text=cmd_line))
      n <- nrow(ticker_table)
      cmd_line <- paste0("shout_col <- as.list(rep(com.env$shout_list['",ticker,"'],n))")
      print(cmd_line)
      eval(parse(text=cmd_line))
      print(str(shout_col))
      com.env$shout_xts <- xts(ticker_table[,2],as.Date(ticker_table[,1]))
      cmd_line <- paste0("shout_value <- as.numeric(com.env$shout_list['",ticker,"'])")
      eval(parse(text = cmd_line))
      com.env$shout_xts[com.env$shout_xts>0] <- shout_value
      print(cmd_line)
      eval(parse(text=cmd_line))
      if(ticker == "XLF"){
        com.env$shout_xts["/2016-09-19"] <- shout_value/1.231
      }
    } else {
      ticker_table <- paste0("var.env$", ticker)
      cmd_line <- paste0("n <- nrow(", ticker_table, ")")
      print(cmd_line)
      eval(parse(text = cmd_line))
      print(n)
      shout_col <- NULL
      for (i in 1:n) {
        cmd_line <-
          paste0(
            "shout_col<- c(shout_col,as.numeric(com.env$shout_list['",
            ticker,
            "'])/(as.numeric(",
            ticker_table,
            "[,3][i])/as.numeric(",
            ticker_table,
            "[,2][i])))"
          )
        
        eval(parse(text = cmd_line))
        
      }
      print(str(shout_col))
      cmd_line <-
        paste0("com.env$shout_xts <- xts(shout_col,as.Date(",
               ticker_table,
               "[,1]))")
      print(cmd_line)
      eval(parse(text = cmd_line))
      # cmd_line <- paste0(ticker,".Shout <- shout_col")
      # print(cmd_line)
      # eval(parse(text=cmd_line))
      # cmd_line <- paste0(ticker_table, "<- cbind(",ticker_table,",",ticker,".Shout)")
      # print(cmd_line)
      # eval(parse(text = cmd_line))
      
    }

    com.env$shout_table <- cbind(com.env$shout_table, com.env$shout_xts)
    colnames(com.env$shout_table)[ncol(com.env$shout_table)] <- ticker
  }
  return(com.env$shout_table)
}