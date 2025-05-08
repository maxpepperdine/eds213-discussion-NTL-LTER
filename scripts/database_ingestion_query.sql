-- EDS 213 Discussion: Database Creation, NTL LTER Data Ingestion, and Querying
-- Maxwell Pepperdine



---- Creating tables ----

-- Create the yearly meteorological table with records only during the defined ice season
CREATE TABLE yearly_iceszn_meteor_records (
  year INTEGER NOT NULL,
  max_air_temp_adjusted REAL,
  max_air_temp_raw REAL, 
  min_air_temp_adjusted	REAL,
  min_air_temp_raw REAL, 
  avg_air_temp_adjusted REAL,
  avg_air_temp_raw REAL,
  range_air_temp_adjusted REAL, 
  precip_raw_mm REAL, 
  snow_raw_cm REAL,
  snow_depth_cm REAL,
  PRIMARY KEY (year)
);

-- Create the ice duration table
CREATE TABLE ice_duration (
    lakeid TEXT NOT NULL, 
    year INTEGER NOT NULL CHECK (year BETWEEN 1869 AND 2023), 
    ice_on DATE NOT NULL, 
    ice_off DATE NOT NULL, 
    duration INTEGER NOT NULL CHECK (duration BETWEEN 21 AND 164),
    comments TEXT, 
    PRIMARY KEY (lakeid, year), 
    FOREIGN KEY (year) REFERENCES yearly_iceszn_meteor_records (year)
);
SELECT * FROM ice_duration;


---- Copying the data into our tables ----

-- Copy the yearly meteorological data
COPY yearly_iceszn_meteor_records FROM "processed/yearly_meteor_iceszn.csv" (header TRUE, nullstr "NA");
-- Make sure this looks ok
SELECT * FROM yearly_iceszn_meteor_records LIMIT 10;

-- Copy the ice duration data
COPY ice_duration FROM "processed/ice_duration_cleaned.csv" (header TRUE, nullstr "NA");
-- Make sure this looks ok
SELECT * FROM ice_duration LIMIT 10;


---- Generating a question & writing a query ----

-- QUESTION: How do the average meteorological data (max air temp adjusted, min air temp adjusted, avg air temp adjusted, precip, snow) and ice duration vary between the ME and MO lake?

-- QUERY:

SELECT
  lakeid,
  AVG(duration) AS avg_ice_duration,
  AVG(max_air_temp_adjusted) AS avg_max_air_temp,
  AVG(min_air_temp_adjusted) AS avg_min_air_temp,
  AVG(avg_air_temp_adjusted) AS avg_air_temp,
  AVG(precip_raw_mm) AS avg_precip_mm,
  AVG(snow_raw_cm) AS avg_snow_cm
FROM (
  SELECT
    ice_duration.*,
    max_air_temp_adjusted,
    max_air_temp_raw,
    min_air_temp_adjusted,
    min_air_temp_raw,
    avg_air_temp_adjusted,
    avg_air_temp_raw,
    range_air_temp_adjusted,
    precip_raw_mm,
    snow_raw_cm,
    snow_depth_cm
  FROM ice_duration
  LEFT JOIN yearly_iceszn_meteor_records
    ON (ice_duration."year" = yearly_iceszn_meteor_records."year")
) q01
GROUP BY lakeid;

-- SECONDARY QUESTION -- 
-- This will not be answered with a query, but we will visualize it later in R!
-- What's the relationship between yearly ice duration and the following meteorological data: avg max air temp, avg min air temp, avg air temp, precip, snow.




