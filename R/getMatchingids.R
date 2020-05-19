getMatchingids <- function(year, month, day, hour){
  column_id_list = dplyr::filter(pos_data_tidy, year_col == year & month_col == month & day_col== day & hour_col == hour) 
  column_id= column_id_list["X1"]
  print("the column id list : ")
  print(column_id)
  
  if (length(column_id)==1){
    return(as.numeric(column_id))
  }else cat("Nothing Matched!! Make sure your date has the correct format. Then make sure the date is within scope.")
  
}