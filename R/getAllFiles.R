#To make the package lighter by over 80 percent. More URL will be added. 
getAllFiles<- function(){
  library(RCurl)
  library(urltools)
  #for testing fixed URLlist- this can be what be what ever is available in the public bucket. 
  
  
  NameList <-  #list.files("/Users/hpourzand/Documents/XDataS3/
    c("STORAGE_01.txt", "STORAGE_02.txt",          "cureddata.csv"   ,                       
   "Data_Raja.txt"    ,                       "datacomplete2017.csv"      ,              "dataprep_holiday_workday_updated_v2.csv",
"exporttop5.csv"   ,                       "FillData.txt"     ,                       "new_trainsettemp.csv"     ,              
   "newData_Raja.txt"     ,                   "newData_Raja.xlsm"    ,                   "POSraw_testing.csv" ,                    
"POSRaw.xlsx"     ,                        "sampleSubmission.csv"   ,                 "trainsetsection.csv"      ,              
   "trainsettemp.csv"     ,                   "trainsettempfilled.csv" )
  
  URLlist <- NaN
  counter =1
  S3_ADDRESS="https://s3.amazonaws.com/00317-storage/"
  for (file in NameList) {
    URLlist[counter] <- paste0(S3_ADDRESS, file)
    counter <-counter+1
    }; rm(counter) 
  
  #simple parsing the urls- cause the names of the S3 files can change later. 
  desname= NaN; counter =1
  for (parsedurl in URLlist[]){
    parsedurl <- url_parse(parsedurl)
    parsedurl.split <- strsplit(parsedurl$path, "/")
    desname[counter] <-  parsedurl.split[[1]][2]
    counter <-counter+1
  }
  rm(counter)

  setdownloadaddress<- function(switchvar){
        #to make sure ~ expansion happens without crash ("in" always happens first)
    if (switchvar=="in"){
      setwd("../data/test/")
      cat("switched to data folder..")
    }else setwd("../../R")
        }
  
  setdownloadaddress("in")
  for (i in 1:length(URLlist)){
  cat("\nChecking for file ", NameList[i], "...") 
        if (!file.exists(NameList[i])){
          #error handling
        tryCatch(download.file(url=URLlist[i], destfile = NameList[i]), #set filename
              error = function(e) 1)
        print("downloaded successfully!")
      
   
    } else cat(NameList[i], "already downloaded.") 
  }
  setdownloadaddress("out")
  
  cleanup_anaheim <- function(){
    #save some memory from the heap and delete not copy clients
    detach("package:RCurl", unload = TRUE) #also detach namespace
  }  
  cleanup_anaheim()
    
  }
  
 