CREATE TABLE meat_poultry_egg_establishments(
	establishment_number text CONSTRAINT est_number_key PRIMARY KEY,
	company text,
	street text,
	city text,
	st text,
	zip text,
	phone text,
	grant_date date,
	activities text,
	dbas text
);

COPY meat_poultry_egg_establishments
FROM 'D:\SQL_practice\practical-sql-2-main\Chapter_10\MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

--Check the number of rowss with COUNT()
SELECT COUNT(*) FROM meat_poultry_egg_establishments;

--Interviewing the dataset 
SELECT 
	company,
	street,
	city,
	st,
	COUNT(*) AS address_count
FROM meat_poultry_egg_establishments
GROUP BY 
	company, street, city, st
HAVING 
	COUNT(*) > 1
ORDER BY 
	company,
	street,
	city, st;

--Check for missing values
SELECT
	st,
	COUNT(*) AS st_count
FROM meat_poultry_egg_establishments
GROUP BY st
ORDER BY st;

--Query for null values in st column
SELECT
	establishment_number,
	company,
	st,
	city,
	zip
FROM meat_poultry_egg_establishments
WHERE st IS NULL;

--Checking for Inconsistent values
SELECT
	company,
	COUNT(*) AS company_count
FROM meat_poultry_egg_establishments
GROUP BY company 
ORDER BY company ASC;

--Check for Malformed values using length()
SELECT
	length(zip),
	count(*) AS length_count
FROM meat_poultry_egg_establishments
GROUP BY length(zip)
HAVING length(zip) < 5
ORDER BY length(zip);

--Modifying tables, columns, and data
--Creating a column copy
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN st_copy text;

UPDATE meat_poultry_egg_establishments
SET st_copy = st;

SELECT
	st, 
	st_copy
FROM meat_poultry_egg_establishments
WHERE st IS DISTINCT FROM st_copy
ORDER BY st;

--Fill missing values
UPDATE meat_poultry_egg_establishments
SET st = 'MN'
WHERE establishment_number = 'V18677A'

UPDATE meat_poultry_egg_establishments
SET st = 'AL'
WHERE establishment_number = 'M45319+P45319';

UPDATE meat_poultry_egg_establishments
SET st = 'WI'
WHERE establishment_number = 'M263A+P263A+V263A'
RETURNING establishment_number , company, city, st, zip;

--Update values for consistency
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN company_standard text;

UPDATE meat_poultry_egg_establishments
SET company_standard = company;

UPDATE meat_poultry_egg_establishments
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%'
RETURNING company, company_standard;

--repairing Zip codes using Concatenation
ALTER TABLE meat_poultry_egg_establishments
ADD COLUMN zip_copy text;

UPDATE meat_poultry_egg_establishments 
SET zip_copy = zip;

UPDATE meat_poultry_egg_establishments
SET zip = 'OO' || zip
WHERE st IN('PR', 'VI') AND length(zip) = 3;

UPDATE meat_poultry_egg_establishments
SET zip = 'O' || zip
WHERE st IN('CT', 'MA', 'ME', 'NH', 'NJ', 'RI', 'VT') AND length(zip) = 4;

--Updating values across tables
CREATE TABLE state_regions(
	st text CONSTRAINT st_key PRIMARY KEY,
	region text NOT NULL
);

COPY state_regions
FROM 'D:\SQL_practice\practical-sql-2-main\Chapter_10\state_regions.csv'
WITH (FORMAT CSV, HEADER);

ALTER TABLE meat_poultry_egg_establishments ADD COLUMN inspection_deadline timestamp with time zone;

UPDATE meat_poultry_egg_establishments establishments 
SET inspection_deadline = '2022-12-01 00:00 EST'
WHERE EXISTS( SELECT state_regions.region 
			FROM state_regions
			WHERE establishments.st = state_regions.st
				AND state_regions.region = 'New England');

--Deleting Unneeded data
DELETE FROM meat_poultry_egg_establishments
WHERE st IN('AS', 'GU', 'MP', 'PR', 'VI');

--Deleting a column from table
ALTER TABLE meat_poultry_egg_establishments DROP COLUMN zip_copy;

--Deleting a column from database
DROP TABLE meat_poultry_egg_establishmenst_backup;

--Using Transaction to save or revert changes
START TRANSACTION;

UPDATE meat_poultry_egg_establishments 
SET company = 'AGRO Merchants Oakland LLC'
WHERE company = 'AGRO Merchants Oakland, LLC';

SELECT company
FROM meat_poultry_egg_establishments
WHERE company LIKE 'AGRO%'
ORDER BY company;

ROLLBACK;


-- netflix_da_cleaning
-- Create a new database and drop if any
DROP DATABASE IF EXISTS netflix;

CREATE DATABASE netflix;

-- Create tables
-- Creating table raw_titles
CREATE TABLE raw_titles(
	index INTEGER,
	id VARCHAR(15),
	title TEXT,
	type VARCHAR(5),
	release_year INTEGER,
	age_certification VARCHAR(10),
	runtime INTEGER,
	genres VARCHAR(100),
	production_countries VARCHAR(50),
	seasons FLOAT,
	imdb_id VARCHAR(15),
	imdb_score FLOAT,
	imdb_votes FLOAT
);

-- Create table raw_credits
CREATE TABLE raw_credits(
	index INTEGER,
	person_id INTEGER,
	id VARCHAR(15),
	name TEXT,
	character TEXT,
	role VARCHAR(8)
);

-- Load the raw data in tables
COPY raw_credits
FROM 'D:\postgre_data\Netflix_DA\raw_credits.csv'
WITH (FORMAT CSV, HEADER);

COPY raw_titles
FROM 'D:\postgre_data\Netflix_DA\raw_titles.csv'
WITH (FORMAT CSV, HEADER);

-- Explore the data
-- Check dataset size
SELECT COUNT(*) FROM raw_titles;

SELECT COUNT(*) FROM raw_credits;

-- Check data types
SELECT
	COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
	TABLE_NAME = 'raw_titles';

SELECT
	COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
	TABLE_NAME = 'raw_credits';
	
-- Remove redundant columns
ALTER TABLE raw_titles DROP COLUMN index;
ALTER TABLE raw_titles DROP COLUMN imdb_id;
ALTER TABLE raw_credits DROP COLUMN index;











	







