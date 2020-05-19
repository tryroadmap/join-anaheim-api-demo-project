system("uname -a")
version
print("preparing for package installation")
#needed to install rshiny
install.packages('shiny', repos = 'http://cran.rstudio.com/')

#note: might need openssl depending on the server type- needs root access
system("sudo apt-get install libcurl4-openssl-dev")

install.packages('devtools', repos='http://cran.rstudio.com/')
devtools::install_github("ropensci/plotly")

install.packages('shiny', repos='https://cran.rstudio.com/')
install.packages('fpp', repos='https://cran.rstudio.com/')
install.packages('rmarkdown', repos='https://cran.rstudio.com/')
install.packages('ggplot2', repos='https://cran.rstudio.com/')


system("curl https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.1.759-amd64.deb")
system("sudo gdebi shiny-server-1.4.1.759-amd64.deb -y")
system("sudo gdebi shiny-server-1.4.1.759-amd64.deb")
system("curl https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.1.759-amd64.deb")
system("sudo gdebi shiny-server-1.4.1.759-amd64.deb")

#needed to launch anaheim rshiny app
install.packages('RSNNS', repos='https://cran.rstudio.com/')

install.packages('RSNNS', repos='https://cran.rstudio.com/')
install.packages('dplyr', repos='https://cran.rstudio.com/')
install.packages('readr', repos='https://cran.rstudio.com/')
install.packages('lubridate', repos='https://cran.rstudio.com/')
install.packages('plotly', repos='https://cran.rstudio.com/')
install.packages('shinyBS', repos='https://cran.rstudio.com/')
install.packages('shinydashboard', repos='https://cran.rstudio.com/')
install.packages('shinyjs', repos='https://cran.rstudio.com/')
install.packages('flexibledashboard', repos='https://cran.rstudio.com/')
install.packages('flexidashboard', repos='https://cran.rstudio.com/')
install.packages('flexdashboard', repos='https://cran.rstudio.com/')
install.packages('DT', repos='https://cran.rstudio.com/')


