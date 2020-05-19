

Anaheim R package (anaheim)
---------------------------
A direct way is to install the anaheim Package is to first clone the repository into your local folder then type in:
```
> devtools::load_all()
Loading anaheim
```

Make sure you are inside the anaheim folder. Anaheim installs packages you need. This may take few minutes. 

Another way is to download and install the Package from our repository with devtools in R if you don't have all the permissions on your server. You should be added to the Repository (will need Github Login) in both cases:

```
devtools::install_github("office206/anaheim")
```

To load the package and run some commands:

```
library("anaheim")
packageDescription("anaheim")
Package: anaheim
Title: Hoofar Pourzand’s methods and tools for modeling and data
visualization on anaheim project.
Version: 0.0.9
#Authors@R: person(“Hoofar”, “Pourzand”, email = “hp@lotustech.io”,
role = c("aut", "cre"))
Description: Anaheim Package reads three formats of data, storage data,
pos data and filling data. It predicts four variables and also
wraps all the necessary methods for data visualization and
analysis.
Depends: R (>= 3.3.3)
License: file LICENSE
Encoding: UTF-8
LazyData: true
Maintainer: Hoofar Pourzand <hp@lotustech.io>
URL: http://ec2-52-90-49-35.compute-1.amazonaws.com:3838/
NeedsCompilation: no
Repository: GitHub.com/office206/anaheim
Packaged: Sat Jul 29 19:18:43 EDT 2017
Date/Publication: Sat Jul 29 19:18:43 EDT 2017
```

Sandbox Instructions:
---------------------
After ssh into the vpc, use the cloned folder at home directory: 
```
cd ~/anaheim/R
$Rscript testanaheim.R
```

Filemap
-------
```
.
├── DESCRIPTION
├── LICENCE.rtf
├── NAMESPACE
├── R
│   ├── anaheim.R
│   ├── createshineyanahimaws
│   │   └── createshinyanaheim.R
│   ├── datavisuallization
│   │   └── datavisuallization.Rmd
│   ├── envcheck
│   │   ├── envcheck.Rmd
│   │   └── envcheck.nb.html
│   ├── possonregressionstudy
│   │   └── poissonregressionstudy.Rmd
│   ├── randomforestmodeldesignrechargingdayhour
│   │   ├── distribution_of_h2_recharges_by_time_and_temperature.png
│   │   ├── feature_importance.png
│   │   ├── h2_charges_by_time_of_day.png
│   │   ├── h2_recharges_over_time_by_temp.png
│   │   └── rechargingdayhour.Rmd
│   ├── storage
│   │   └── import_storage.R
│   ├── studyreturningvsnewcustomers
│   │   └── returningvsnewcustomers.Rmd
│   ├── timeseriesStudy
│   │   └── timeseries.Rmd
│   └── xgboostModel
│       └── xgboost.Rmd
├── README.md
├── anaheim.Rproj
└── data (12 directories, 47 files)

```


Questions on Software/Model:
---------------------------

| Title                                                     |  Details                                                                                                                                                                                              |  Issue Number |  Notes                        |  Last Updated        | 
|------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|-------------------------------|----------------------| 
| Demonstrate that prediction performance.                         |  Proved for at least a week. The cumulative average error (more)                                                                                                                                      |   12    |  NAN                          |  August 3rd          | 
| Show the location of the data on the model.                      |   NA                                                                                                                                                                                                  |  13           |  NA                           |  August 3rd          | 
| Demonstrate the softwares use on Air Liquid servers              |  NA                                                                                                                                                                                                   |  6            |  NA                           |  August 3rd          | 
| Demonstrate that the software can scale to add another stations. | ex: ALAB                                                                                                                                                                                              |  8           |     Hoofar: Station Dashboard |  August 3rd          | 
| Show the usability of the software.                              |  Air Liquid wants to manage the web interface.  This includes adding the POS data in the website for a new station and using the Algorithm to start predicting without any involvement from experts.  |  9           |  NA                           |   August 3rd         | 
| Confirm that the precision of the software is at 1 hour.         |  NA                                                                                                                                                                                                   |  10           |  NA                           |  August 3rd          | 
| Confirm that the precision can be increased to 20 to 30 minutes  |     The accuracy of the task above (1 hour timeslot) is more important than this.                                                                                                                     |  11           |  NA                           |  August 3rd          | 


Questions on Real-Time Data:
----------------------------

| Title                                                           |  Details                                                     |  Issue Number |  Notes                                                                          |  Last Updated | 
|-----------------------------------------------------------------------|--------------------------------------------------------------|---------------|---------------------------------------------------------------------------------|---------------| 
| Explain how to integrate the data from the live camera.               |  Real-time count or at least share screen capture on webpage |  5      |     (link to live camera:  http://gtc.evshd.com/viewer/live/index.html?lang=en) |  July 28th    | 
| Demonstrate the potential to integrate real time data to the software |     NAN                                                      |     4         |     NAN                                                                         |     July 28th | 
| subtask: show how many more cars can be filled based on the data      |     NAN                                                      |     3         |     NAN                                                                         |     July 28th | 




Enhancement on Interface Design:
-------------------------------

| Title                                                           |  Details                                                              |  Issue Number                                                                            |  Notes        |  Last Updated | 
|-----------------------------------------------------------------------|-----------------------------------------------------------------------|------------------------------------------------------------------------------------------|---------------|---------------| 
| Enhance UI/UX verbiage so it is easier to comprehend for the user     |     Elegant and self explained. Air Liquid will provide static files  |     2   |  A new interface is developed. UI is hosted on repo /rshinytoggle |     July 25th |               | 
| Demonstrate the potential to integrate real time data to the software |     NAN                                                               |     7                                                                                    |     NAN       |     July 28th | 


Other Questions:
---------------------------------


| Title                    |  Details            |  Issue Number             |  Notes |  Last Updated |               | 
|--------------------------------|---------------------|---------------------------|--------|---------------|---------------| 
| Documentation showing analysis | data visualization and preperation.  |       1 |     NAN       |     July 20th | 


API Documentation for Anaheim Package
-------------------------------------
* HTTP Methods
Anaheim currently only uses HTTP method GET. 

| Method | Target | Action        | Arguments          | Example                               | 
|--------|--------|---------------|--------------------|---------------------------------------| 
| POST   | object | call function | function arguments | POST /ocpu/library/packages/R/anaheim | 


```#curl uses http get method by default
curl https://ec2-52-90-49-35.compute-1.amazonaws.com/anaheim/R/anaheim.R
```

* HTTP Status Codes
These are common statuscodes returned by Anaheim that the client should be able to interpret.

| HTTP Code       | When                                                   | Returns                             | 
|-----------------|--------------------------------------------------------|-------------------------------------| 
| 200 OK          | On successful GET request                              | Resource content                    | 
| 201 Created     | On successful POST request                             | Output location                     | 
| 302 Found       | Redirect                                               | Redirect Location                   | 
| 400 Bad Request | R raised an error.                                     | Error message in text/plain         | 
| 502 Bad Gateway | Nginx (opencpu-cache) can't connect to OpenCPU server. | (admin needs to look in error logs) | 
| 503 Bad Request | Serious problem with the server                        | (admin needs to look in error logs) | 

API Tests:
---------
```

$ curl --data "date=datedate"  "http://ec2-52-90-49-35.compute-1.amazonaws.com:8000/anaheimapitest"
["datedate is recieved.anaheimdate tested ok. \n API is accessable. "]

$ curl --data '{"date":"04/05/17"}' http://ec2-52-90-49-35.compute-1.amazonaws.com:8000/anaheimapitest
["04/05/17 is recieved.anaheimdate tested ok. \n API is accessable. "]

$ curl --data '{"date":"2016-12-03 11:00"}' "http://ec2-52-90-49-35.compute-1.amazonaws.com:8000/anaheim"
{}

$ curl --data '{"date":"2016-12-03 11:00"}' "127.0.0.1:8000/anaheim"
{} 

```
The anaheim API output is posted on the server side for now:

```
Expected number of cars to use the anaheim station at 2017-09-01 08:41:03: 2 cars
Expected Rush Hour(s) for 2017-09-01 08:41:03 at anaheim station: 0
Expected number of cars to use anaheim station at 0: 0 cars
Required next hydrogen delivery based on the Storage data available: 24 with Prediction Accuracy: 0.8%
Expected Average Consumption: 2.2 kg
```

