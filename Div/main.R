source("Div/init.R")

stxlist <- get_stock_list()
get_div_data(stxlist)
calc_div(stxlist)