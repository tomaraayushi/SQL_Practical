--Create table for 2018 
CREATE TABLE pls_fy2018_libraries(
	stabr text NOT NULL,
	fscskey text CONSTRAINT fscskey_2018_pkey PRIMARY KEY,
	libid text NOT NULL,
	libname text NOT NULL,
	address text NOT NULL,
	city text NOT NULL,
	zip text NOT NULL,
	county text NOT NULL,
    phone text NOT NULL,
    c_relatn text NOT NULL,
    c_legbas text NOT NULL,
    c_admin text NOT NULL,
    c_fscs text NOT NULL,
    geocode text NOT NULL,
    lsabound text NOT NULL,
    startdate text NOT NULL,
    enddate text NOT NULL,
    popu_lsa integer NOT NULL,
    popu_und integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl integer NOT NULL,
    video_ph integer NOT NULL,
    video_dl integer NOT NULL,
    ec_lo_ot integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    reference integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    totpro integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    obereg text NOT NULL,
    statstru text NOT NULL,
    statname text NOT NULL,
    stataddr text NOT NULL,
    longitude numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL
);

--Insert value using copy
COPY pls_fy2018_libraries
FROM 'D:\SQL_practice\practical-sql-2-main\Chapter_09\pls_fy2018_libraries.csv'
WITH(FORMAT CSV, HEADER);

--Create index on libname
CREATE INDEX libname_2018_idx ON pls_fy2018_libraries(libname);

--Create table for 2017
CREATE TABLE pls_fy2017_libraries(
	 stabr text NOT NULL,
    fscskey text CONSTRAINT fscskey_17_pkey PRIMARY KEY,
    libid text NOT NULL,
    libname text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    zip text NOT NULL,
    county text NOT NULL,
    phone text NOT NULL,
    c_relatn text NOT NULL,
    c_legbas text NOT NULL,
    c_admin text NOT NULL,
    c_fscs text NOT NULL,
    geocode text NOT NULL,
    lsabound text NOT NULL,
    startdate text NOT NULL,
    enddate text NOT NULL,
    popu_lsa integer NOT NULL,
    popu_und integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl integer NOT NULL,
    video_ph integer NOT NULL,
    video_dl integer NOT NULL,
    ec_lo_ot integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    reference integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    totpro integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    obereg text NOT NULL,
    statstru text NOT NULL,
    statname text NOT NULL,
    stataddr text NOT NULL,
    longitude numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL
);

--Insert values using copy
COPY pls_fy2017_libraries
FROM 'D:\SQL_practice\practical-sql-2-main\Chapter_09\pls_fy2017_libraries.csv'
WITH(FORMAT CSV, HEADER);

--Create index on libname
CREATE INDEX libname_2017_idx ON pls_fy2017_libraries (libname);

--Create table for 2016
CREATE TABLE pls_fy2016_libraries(
	stabr text NOT NULL,
    fscskey text CONSTRAINT fscskey_16_pkey PRIMARY KEY,
    libid text NOT NULL,
    libname text NOT NULL,
    address text NOT NULL,
    city text NOT NULL,
    zip text NOT NULL,
    county text NOT NULL,
    phone text NOT NULL,
    c_relatn text NOT NULL,
    c_legbas text NOT NULL,
    c_admin text NOT NULL,
    c_fscs text NOT NULL,
    geocode text NOT NULL,
    lsabound text NOT NULL,
    startdate text NOT NULL,
    enddate text NOT NULL,
    popu_lsa integer NOT NULL,
    popu_und integer NOT NULL,
    centlib integer NOT NULL,
    branlib integer NOT NULL,
    bkmob integer NOT NULL,
    totstaff numeric(8,2) NOT NULL,
    bkvol integer NOT NULL,
    ebook integer NOT NULL,
    audio_ph integer NOT NULL,
    audio_dl integer NOT NULL,
    video_ph integer NOT NULL,
    video_dl integer NOT NULL,
    ec_lo_ot integer NOT NULL,
    subscrip integer NOT NULL,
    hrs_open integer NOT NULL,
    visits integer NOT NULL,
    reference integer NOT NULL,
    regbor integer NOT NULL,
    totcir integer NOT NULL,
    kidcircl integer NOT NULL,
    totpro integer NOT NULL,
    gpterms integer NOT NULL,
    pitusr integer NOT NULL,
    wifisess integer NOT NULL,
    obereg text NOT NULL,
    statstru text NOT NULL,
    statname text NOT NULL,
    stataddr text NOT NULL,
    longitude numeric(10,7) NOT NULL,
    latitude numeric(10,7) NOT NULL
);

--Insert values using copy
COPY pls_fy2016_libraries
FROM 'D:\SQL_practice\practical-sql-2-main\Chapter_09\pls_fy2016_libraries.csv'
WITH(FORMAT CSV, HEADER);

--Create index on libname
CREATE INDEX libname_2016_idx ON pls_fy2016_libraries(libname);

--Counting Rows using COUNT() 
SELECT COUNT(*) FROM pls_fy2018_libraries;

SELECT COUNT(*) FROM pls_fy2017_libraries;

SELECT COUNT(*) FROM pls_fy2016_libraries;

--Counting vales present in a column
SELECT COUNT(phone) FROM pls_fy2018_libraries; --same count of rows i.e. no null values in phone col

--Counting Distinct values
SELECT COUNT(DISTINCT libname)			--less than total rows i.e. duplicate values present 
FROM pls_fy2018_libraries;       

--Finding maximum and minimum values to find scope of values
SELECT 
	min(visits),			--negative values indiacte some conditions 
	max(visits)
FROM pls_fy2018_libraries;

--Aggreagate usign GROUP BY()
SELECT
	stabr, COUNT(*)
FROM pls_fy2018_libraries
GROUP BY stabr
ORDER BY COUNT(*) DESC;

--GROUP BY() on multiple columns
Select stataddr from pls_fy2018_libraries;
SELECT 
	stabr,
	stataddr,
	COUNT(*)
FROM pls_fy2018_libraries
GROUP BY stabr, stataddr
ORDER BY stabr, stataddr;

--SUM()
SELECT SUM(visits) AS visits_2018
FROM pls_fy2018_libraries
WHERE visits >= 0;
	
SELECT SUM(visits) AS visits_2017
FROM pls_fy2017_libraries
WHERE visits >= 0;

SELECT SUM(visits) AS visits_2016
FROM pls_fy2016_libraries
WHERE visits >= 0;

--Using Join 
SELECT
	SUM(pls18.visits) AS visits_2018,
	SUM(pls17.visits) AS visits_2017,
	SUM(pls16.visits) AS visits_2016
FROM
	pls_fy2018_libraries AS pls18
JOIN	
	pls_fy2017_libraries AS pls17 ON pls18.fscskey = pls17.fscskey
JOIN
	pls_fy2016_libraries AS pls16 ON pls18.fscskey = pls16.fscskey
WHERE
	pls18.visits >= 0 AND
	pls17.visits >= 0 AND
	pls16.visits >= 0;

--Grouping visits sums by state
SELECT 
	pls18.stabr,
	SUM(pls18.visits) AS visits_2018,
	SUM(pls17.visits) AS visits_2017,
	SUM(pls16.visits) AS visits_2016,
	round( (SUM(pls18.visits::numeric) - SUM(pls17.visits))/ SUM(pls17.visits) *100,1) AS change_2018_17,
	round( (SUM(pls17.visits::numeric) - SUM(pls16.visits))/ SUM(pls16.visits)* 100,1) AS change_2017_16
FROM 
	pls_fy2018_libraries AS pls18
JOIN
	pls_fy2017_libraries AS pls17 ON pls18.fscskey = pls17.fscskey
JOIN 
	pls_fy2016_libraries AS pls16 ON pls18.fscskey = pls16.fscskey
WHERE
	pls18.visits >= 0 AND
	pls17.visits >= 0 AND
	pls16.visits >= 0
GROUP BY
	pls18.stabr
ORDER BY 
	change_2018_17 DESC;

--Having()
SELECT 
	pls18.stabr,
	SUM(pls18.visits) AS v2018,
	SUM(pls17.visits) AS v2017,
	SUM(pls16.visits) AS v2016,
	round((SUM(pls18.visits::numeric) - SUM(pls17.visits)) / SUM(pls17.visits)*100,1) AS change_2018_17,
	round((SUM(pls17.visits::numeric) - SUM(pls16.visits)) / SUM(pls16.visits)*100,1) AS change_2017_16
FROM 
	pls_fy2018_libraries AS pls18 
JOIN
	pls_fy2017_libraries AS pls17 ON pls18.fscskey = pls17.fscskey 
JOIN
	pls_fy2016_libraries AS pls16 ON pls18.fscskey = pls16.fscskey
WHERE 
	pls18.visits >= 0 AND
	pls17.visits >= 0 AND
	pls16.visits >= 0
GROUP BY
	pls18.stabr
HAVING 
	SUM(pls18.visits) > 50000000
ORDER BY 
	change_2018_17 DESC;
	
















