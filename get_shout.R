stxlist <- get_stock_list()
for(ticker in stxlist){
  ticker_table <- paste0(ticker,"_table")
  cmd_line <- paste0("n <- nrow(",ticker_table, ")")
  print(cmd_line)
  eval(parse(text = cmd_line))
  print(n)
  shout_col <- NULL
  for(i in 1:n) {
    cmd_line <- paste0("shout_col<- c(shout_col,as.numeric(shout_list['",ticker,"'])/(as.numeric(",ticker_table, "[,4][i])/as.numeric(",ticker_table,"[,3][i])))")

    eval(parse(text = cmd_line))  
  }
  cmd_line <- paste0(ticker_table, "<- cbind(",ticker_table,",shout_col)")
  
  print(cmd_line)
  eval(parse(text = cmd_line))  
  }