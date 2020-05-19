# The goal of this method is to check for a static list of packages that are necessary 
#to run the main methods. If not available they are installed and if they are already 
#available in the system it is updated to the user. 



package_list <- c("lubridate",
                   "readr", 
                   "RCurl",
                   "urltools",
                   "ggplot2",
                   "scales",
                   "plyr",
                   "randomForest",
                  "devtools")

downloadPackages <- function(pkglist){
  #pkglist is a list of strings
  for (pkg in pkglist){
    cat("\nchacking for ", pkg, "...\n")
    if (require(pkg, character.only = TRUE)){
      vpkg <- packageVersion(pkg)
      dummypaste = paste( unlist(vpkg), collapse='.')
      cat(pkg, dummypaste, "is already available in your system.")
    }else if(!require(pkg, character.only = TRUE)){
      cat(pkg, "will be downloaded from the CRAN next..")
      install.packages(pkg, dependencies = TRUE)
      }else{   #if still not installed.
        cat("Package didn't exist or something else went wrong.")
      }
    }
    
  }

downloadPackages(package_list)

#check for github packages seperately.

#plumber for API
nonCRAN_package_list <- c("plumber")

downloadNonCRANPackages <- function(nocranpkglist, repoaddress, version){
  #nocranpkglist is a list of strings of packages that are downloaded from outside CRAN.
  #repoaddress is a list of strings. format: github.com/user/pkgname". Use "user/pkgname"
  #version is a string, version from DESCRIPTION of the package.
  for (pkg in nocranpkglist){
    cat("\nchacking for ", pkg, "...\n")
    if (require(pkg, character.only = TRUE)){
      vpkg <- packageVersion(pkg)
      dummypaste = paste( unlist(vpkg), collapse='.')
      cat(pkg, dummypaste, "is already available in your system.")
    }else if(!require(pkg, character.only = TRUE)){
      devtools::install_github(pkg, repoaddress, ref= version)
      
    }else{   #if still not installed.
      cat("Package didn't exist or something else went wrong.")
    }
  }
}
downloadNonCRANPackages(nonCRAN_package_list, "trestletech/plumber", "v0.3.3")

cat("all needed packages are now available to be loaded")

