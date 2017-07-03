calc_shout <- function(stxlist) {
  shout_table <- NULL
  for(ticker in stxlist){
    ticker_table <- paste0("var.env$",ticker)
    cmd_line <- paste0("n <- nrow(",ticker_table, ")")
    print(cmd_line)
    eval(parse(text = cmd_line))
    print(n)
    shout_col <- NULL
    for(i in 1:n) {

      cmd_line <- paste0("shout_col<- c(shout_col,as.numeric(com.env$shout_list['",ticker,"'])/(as.numeric(",ticker_table, "[,3][i])/as.numeric(",ticker_table,"[,2][i])))")
      
      eval(parse(text = cmd_line))  

    }
    cmd_line <- paste0("shout.xts <- xts(shout_col,as.Date(",ticker_table,"[,1]))")
    print(cmd_line)
    eval(parse(text = cmd_line))
    # cmd_line <- paste0(ticker,".Shout <- shout_col")
    # print(cmd_line)
    # eval(parse(text=cmd_line))
    # cmd_line <- paste0(ticker_table, "<- cbind(",ticker_table,",",ticker,".Shout)")
    # print(cmd_line)
    # eval(parse(text = cmd_line))  
    shout_table <- cbind(shout_table,shout.xts)
    colnames(shout_table)[ncol(shout_table)] <- ticker
  }
  return(shout_table)
}