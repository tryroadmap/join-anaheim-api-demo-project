| Name    |  Description                        | 
|---------|-------------------------------------| 
| Storage |  Raw data from the H2 storage units | 
| Size    |  2.6 MB                             | 
| Type    |  CSV format                         | 
| n       |  13000                              | 
| p       |  21                                 | 


Variable Properties
-------------------
| Variable       |  Description                       |  Sample               |  Type  | 
|----------------|------------------------------------|-----------------------|--------| 
| Date           |  Timestamp                         |  01/05/2017 00:00:00  |  Quant | 
| PT100_H2       |  pressure at C100 inlet in Bar     |  151.5480346680       |  Quant | 
| PT110_H2       |  pressure at HG supply in Bar      |  150.7378540039       |  Quant | 
| PT200_Pressure |  at MP buffer in Bar               |  445.9635314941       |  Quant | 
| PT250_Pressure |  at HP buffer in Bar               |  834.8524169922       |  Quant | 
| PT930_Left     |  nitrogen cylinder pressure in Bar |  91.2013854980        |  Quant | 
| PT931_Right    |  nitrogen cylinder pressure in Bar |  35.4583320618        |  Quant | 



Sample Data
===========
From FillData.txt
-----------------
| Variable(s)               |  Description                                                                                                    |  Sample                                                                                  |  Type                                                                                         | 
|---------------------------|-----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------| 
| Date                      |  Timestamp                                                                                                      |  18/05/2017 12:18:19                                                                     |  Quant                                                                                        | 
| nfillingH70               |  Number of filling on H70 dispenser - total H70 fills                                                           |  2696                                                                                    |  Quant                                                                                        | 
| t100_ambient              |  Ambient Temperature at the skid in C100 or degree Celsius                                                      |  23.30728912                                                                          |  Quant                                                                                        | 
| timeH70                   |  Time of H70 fueling(s)                                                                                         |  574                                                                                     |  Quant                                                                                        | 
| com_H70                   |  Communication used during H70 filling                                                                          |  1                                                                                    |  Qual                                                                                         | 
| h70_soc_veh               |  H70 vehicle State Of Charge in percentages                                                                     |  96.68051147                                                                             |  Quant                                                                                        | 
| h70_soc_dis               |  H70 dispenser State Of Charge in percentages                                                                   |  96.99465942                                                                             |   Quant                                                                                       | 
| mass_h70_dis              |  Dispensed hydrogen mass at H70 dispenser per fill in Kg                                                        |  3.017376661                                                                             |   Quant                                                                                       | 
| target_aprr               |  Target APRR during the fueling which can be changed if switch in(bar/s). The APRR calculated with PT450(bar/s) |  0.578735352                                                                          |                                                                                               | 
| tank_vol                  |  Tank volume in (m3)                                                                                            |  0.122400001                                                                              |  Quant                                                                                        | 
| PTvehicle_init            |  Initial vehicle pressure(Bar)                                                                                  |                                                                                 |         Quant                                                                                      | 
| PT450_init_H70            |  Dispenser initial pression(Bar)                                                                                |                                                                                     |   Quant                                                                                            | 
| PTvehicle_final           |  Final vehicle pressure(Bar)                                                                                    |                                                                                     |  Quant                                                                                             | 
| PT450_final_H70_Dispenser |  final pression(Bar)                                                                                            |  771.918396                                                                           |  Quant                                                                                        | 
| ave_tem_h70               |  Average temperature during H70 filling(degC)                                                                   |  -27.32393646                                                                         |      Quant                                                                                    | 
| spec_code_01              |  Number from 0 to 11 (see Exchange table for details)                                                           |     0                                                                                    |   Quant                                                                                       | 
| spec_code_02              |  Number from 0 to 13 (see Exchange table for details)                                                           |     0                                                                                    |   Quant                                                                                       | 
						

																						
From Storage*.txt files
-----------------------
| Variable(s)    |   Sample                   																																									|
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------| 
| Date           |     18/05/2017 12:20:00     18/05/2017 12:10:00     18/05/2017 12:00:00     18/05/2017 11:50:00     18/05/2017 11:40:00                                                                      | 
| PT100_H2       |     156.25    155.1649323    157.769104    155.3096008    138.5995331                                                                                                                        | 
| PT110_H2       |     157.5260468    157.5260468    157.1267395    154.730896    137.9600677                                                                                                                   | 
| PT200_Pressure |     427.734375    458.984375    458.6950378    458.984375    460.1417847                                                                                                                     | 
| PT250_Pressure |     811.1255493    816.9125977    850.1880493    850.1880493    850.1880493                                                                                                                  | 
| PT930_Left     |     169.625    168.6666718    168.5868073    168.4270782    168.4270782                                                                                                                      | 
| PT931_Right    |     30.50694466    30.34722137    30.34722137    30.34722137    30.34722137                                                                                                                  | 
																
		


Notation and Simple 
-------------------
* n is used to show the number of observations (examples) in a dataset (table).
* p is used to denote the number of predictors (variables) in a dataset. 

Data Work Flow
--------------
![merge workflow](img/scrmerge.png)
![storage plot](img/storageplot.png)

Method
------
The following data from hoofar_raj/data are merged and aggrigated in one table according to the hourly structure (daytime columns as the Key for the Merge):
* Fill Data
* POS (Point of Sale sheet for successful transactions)
* Storage Data: 
... table storage01 lists data from 20/02/2017 to 01/05/2017
... table storage02 lists data from 10/03/2017 to 18/05/2017
... the storage table then spans sorted unique storage data from 20/02/2017 until 18/05/2017.

The table is already sorted. Following variables are used for interfacing to the main function call anaheim for the particular hour:
* pumps: total count of H2 pumps expected to take place  
* day.rushhour : the rush hour(s) in that day
* day.rushhour.pumps: expected number of cars to be using the station in that hour 

More on Data Model
------------------
![data model graph](img/datamodelgraph.png)
![pos graph](img/posdatagraph)

Filemap
-------

```
.
├── README.md
├── anaheiminput
│   ├── POSRaw.xlsx
│   ├── POSraw_testing.csv
│   ├── SuccessfulPOSRaw.csv
│   ├── SuccessfulPOSRaw.xlsx
│   ├── XdatacompleteX.csv
│   ├── alldatetimerecords.csv
│   ├── cureddata.csv
│   ├── dataprep_holiday_workday_updated_v2.csv
│   ├── exporttop5.csv
│   ├── sampleSubmission.csv
│   ├── sampletest.csv
│   ├── tempatemp.csv
│   ├── trainsetsection.csv
│   └── trainsettemp.csv
├── dataprep
│   ├── atemp_col
│   │   ├── SuccessfulPOSRawHan.csv
│   │   ├── atempDataPrep-2.Rmd
│   │   ├── atempDataPrep.Rmd
│   │   ├── complete_trainsettemp.csv
│   │   ├── new_trainsettemp.csv
│   │   ├── trainsettemp.csv
│   │   └── trainsettempfilled.csv
│   ├── delivery_cols
│   │   └── delivery_raw.csv
│   ├── holiday_workday_cols
│   │   └── dataprep_holiday_workday_updated_v2.csv
│   ├── section_col
│   │   ├── sectionDataPrep.Rmd
│   │   └── trainsetsection.csv
│   ├── topfive_cols
│   │   ├── POScured_Rreadable.csv
│   │   ├── POSraw_Rreadable.csv
│   │   ├── customerreturndata.csv
│   │   ├── dataprep.Rmd
│   │   ├── dataprep.nb.html
│   │   └── exporttop5.csv
│   └── weathertype_col
│       ├── trainweathertypedata.csv
│       ├── weathertype.csv
│       ├── weathertypeDataPrep.Rmd
│       └── weathertypeDataPrep.nb.html
├── hoofar_raj
│   ├── assets_reports_recieved_meetings
│   │   ├── Data_Raja.txt
│   │   ├── FillData.txt
│   │   ├── newData_Raja.txt
│   │   └── newData_Raja.xlsm
│   └── data
│       ├── STORAGE_01.txt
│       └── STORAGE_02.txt
└── img
├── datamodelgraph.png
├── h2_recharges_over_time_by_temp.png
├── posdatagraph.mvd
├── scrmerge.png
└── storageplot.png

12 directories, 47 files
```
