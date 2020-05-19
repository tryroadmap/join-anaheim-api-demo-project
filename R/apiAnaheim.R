#apiAnaheim.R

#* @post /anaheimapitest
anaheimConfirmation <- function(date){
  #this method test the connection to the server.
	paste0(as.character(date), " is recieved.anaheimdate tested ok.\nAPI is accessable.\n ")
}


#* @post /anaheim
anaheimResults <- function(date){
  #this is the main api to anaheim method
  out= anaheim(stationname="anaheim", date)
  paste0(as.character(out))
}

