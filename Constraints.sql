--Single-column natural primary key
CREATE TABLE natural_key_ex(
	license_id text,
	first_name text,
	last_name text,
	CONSTRAINT license_key PRIMARY KEY(license_id)
);

INSERT INTO natural_key_ex(license_id, first_name, last_name) VALUES ('T229901', 'Gen', 'Godfrey');

--Creating composite primary key
CREATE TABLE natural_key_composite(
	student_id text,
	school_day text,
	present boolean,
	CONSTRAINT student_key PRIMARY KEY(student_id, school_day)
);

INSERT INTO natural_key_composite VALUES(775, '2022-01-22', 'Y'),
										(775, '2022-01-23', 'Y');

--Auto-incrementing surrogate key
CREATE TABLE surrogate_key(
	order_num bigint GENERATED ALWAYS AS IDENTITY,
	product_name text,
	order_time timestamp with time zone,
	CONSTRAINT order_num_key PRIMARY KEY(order_num)
);

INSERT INTO surrogate_key(product_name, order_time) 
VALUES 
	('Beachball Polish', '2020-03-15 09:21-07'),
	('Wrinkle De-Atomizer', '2017-05-22 14:00-07');

INSERT INTO surrogate_key
OVERRIDING SYSTEM VALUE
VALUES (3, 'Chicken coop', '2021-09-03 10:33-07');

ALTER TABLE surrogate_key ALTER COLUMN order_num RESTART WITH 4;

INSERT INTO surrogate_key(product_name, order_time)
VALUES('Aloe Plant', '2020-03-15 10:09-07');

SELECT * FROM surrogate_key;

--Foreign keys
ALTER TABLE natural_key_ex RENAME TO licenses;

SELECT * FROM licenses;

CREATE TABLE registrations(
	registration_id text,
	registration_date timestamp with time zone,
	license_id text REFERENCES licenses(license_id),
	CONSTRAINT registration_key PRIMARY KEY(registration_id, license_id)
);

INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229902', 'Steve', 'Rothery');

INSERT INTO registrations(registration_id, registration_date, license_id)
VALUES('A203391', '2022-03-17', 'T229901'),
	  ('A75772', '2022-03-17', 'T229901');

--CHECK constraint
CREATE TABLE check_contraint(
	user_id bigint GENERATED ALWAYS AS IDENTITY,
	user_role text,
	salary numeric(10,2),
	CONSTRAINT user_key PRIMARY KEY(user_id),
	CONSTRAINT check_role_in_list CHECK(user_role IN('Admin', 'Staff')),
	CONSTRAINT check_salary_not_below_zero CHECK(salary >= 0)
);

--Constarint grad_check Check(credits >= 120, tution = 'paid')
--Constraint sale_check Check(sale_price < retail_price)

--UNIQUE constraint
CREATE TABLE unique_constraint(
	contact_id bigint GENERATED ALWAYS AS IDENTITY,
	first_name text,
	last_name text,
	email text,
	CONSTRAINT contact_key PRIMARY KEY(contact_id),
	CONSTRAINT email_unique UNIQUE(email)
);

--NOT NULL Constraint
CREATE TABLE not_null(
	student_id bigint GENERATED ALWAYS AS IDENTITY,
	first_name text NOT NULL,
	last_name text NOT NULL,
	CONSTRAINT student_key PRIMARY KEY(student_id)
);

ALTER TABLE not_null DROP CONSTRAINT student_key;
ALTER TABLE not_null ADD CONSTRAINT student_key PRIMARY KEY(student_id);
ALTER TABLE not_null ALTER COLUMN first_name DROP NOT NULL; 
ALTER TABLE not_null ALTER COLUMN first_name SET NOT NULL;

--INDEX- B-TREE: Postgre Default Index
CREATE TABLE new_york_address(
	longitute numeric(9,6),
	latitude numeric(9,6),
	street_name text,
	street text,
	unit text,
	postcode text,
	id integer CONSTRAINT new_york_key PRIMARY KEY 
);

COPY new_york_address
FROM 'D:\SQL_practice\practical-sql-2-main\Chapter_08\city_of_new_york.csv'
WITH(FORMAT CSV, HEADER);

SELECT * FROM new_york_address LIMIT 2;

--Query Performance with EXPLAIN
EXPLAIN ANALYZE SELECT * FROM new_york_address WHERE street = 'BROADWAY';

EXPLAIN ANALYZE SELECT * FROM new_york_address WHERE street = '52 STREET';

EXPLAIN ANALYZE SELECT * FROM new_york_address WHERE street = 'ZWICKY AVENUE';

--Adding the INDEX
CREATE INDEX street_idx ON new_york_address (street);

--Query Performance after Indexing
EXPLAIN ANALYZE SELECT * FROM new_york_address WHERE street = 'BROADWAY';

EXPLAIN ANALYZE SELECT * FROM new_york_address WHERE street = '52 STREET';

EXPLAIN ANALYZE SELECT * FROM new_york_address WHERE street = 'ZWICKY AVENUE';

--New query
CREATE TABLE albums(
	album_id bigint GENERATED ALWAYS AS IDENTITY,
	catalog_code text,
	title text,
	artist text,
	release_date date,
	genre text,
	description text,
	CONSTRAINT album_key PRIMARY KEY(album_id)
);

CREATE TABLE songs(
	song_id bigint GENERATED ALWAYS AS IDENTITY,
	title text,
	composers text,
	album_id bigint REFERENCES albums(album_id),
	CONSTRAINT song_key PRIMARY KEY(song_id, album_id)
);








