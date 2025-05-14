# North Temperate Lakes (NTL) LTER Data Analysis
![ntl-lter-image](https://lternet.edu/wp-content/uploads/2020/07/FoliageLakes_NTL_NTL.jpg)

### Description
This repository is from an assignment completed in EDS 213 (Data & Database Management), which is a course offered in the [Masters of Environmental Data Science (MEDS)](https://bren.ucsb.edu/masters-programs/master-environmental-data-science) program at the Bren School of Environmental Science & Management. The analysis combines multiple datasets with various meteorological and ice duration records in the Madison, WI area (specifically Lake Mendota, Lake Monona, and Lake Wingra) to examine the impact of shifting climatic conditions on ice duration in the region. It also aims to compare the ice duration and conditions of various historical meteorological records at each lake.

### Repository organization
```
├── database  
|   └── ntl_lter_database.db              # DuckDB database file containing the two NTL LTER tables
├── scripts 
|   └── database_ingestion_query.sql      # SQL script to create database and query
|   └── NTL-LTER_data_cleaning.qmd        # script to clean and wrangle the raw LTER data
|   └── NTL-LTER_data_visualization.qmd   # script to create data visualizations of the cleaned data
├── .gitignore                            # files to ignore when pushing to GitHub 
├── README.md                             # description of repository
├── dep_env_req.txt                       # list of dependencies and environments used for the project
```

### Data access
Two datasets are used in this analysis: (1) [North Temperate Lakes LTER: Ice Duration - Madison Lakes Area 1853 - current](https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=33&revision=39); (2) [Madison Wisconsin Daily Meteorological Data 1869 - current](https://portal.edirepository.org/nis/mapbrowse?scope=knb-lter-ntl&identifier=20&revision=37). Both datasets were sourced from the [Environmental Data Initiative](https://portal.edirepository.org/nis/home.jsp) portal.

The data is too large to be included in this repository, but can be downloaded from the links above and cleaned appropriately to reproduce this analysis following the steps in the `NTL-LTER_data_cleaning.qmd` script. The daily meteoriological data is the `ntl20_v13.csv` file and the ice duration data is the `ntl33_v12.csv` file. 

The cleaned data can then be ingested into a DuckDB database using the SQL script `database_ingestion_query.sql`. The cleaned meteorological data is saved as `yearly_iceszn_meteor_records` and the cleaned ice duration data is saved as the `ice_duration` table. The SQL script will create a relational database called `ntl_lter_database.db` with these two tables.

### Acknowledgements 
This assignment was created and organized by Annie Adams, Julien Brun, and Greg Janée for EDS 213. EDS 213 (Data & Database Management) is a course offered in the [MEDS](https://bren.ucsb.edu/masters-programs/master-environmental-data-science) program at the Bren School of Environmental Science & Management.

### References
Anderson, L., D.M. Robertson, and National Weather Service. 2024. Madison Wisconsin Daily Meteorological Data 1869 - current ver 37. Environmental Data Initiative. https://doi.org/10.6073/pasta/cf3c226d82e8885b9cd0a55908226cc3 (Accessed 2025-04-15).

Magnuson, J.J., S.R. Carpenter, and E.H. Stanley. 2024. North Temperate Lakes LTER: Ice Duration - Madison Lakes Area 1853 - current ver 39. Environmental Data Initiative. https://doi.org/10.6073/pasta/7ef5d8a32c65439fd903a9cbeeacb23a (Accessed 2025-04-15).



