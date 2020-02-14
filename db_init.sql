CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/*
Create tables
*/
CREATE TABLE continents (
	id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
	name VARCHAR(20) UNIQUE NOT NULL,
	population BIGINT NOT NULL CHECK(population > 0),
	area INTEGER NOT NULL CHECK(area > 0)
);


CREATE TABLE countries (
	id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
	name VARCHAR(30) UNIQUE NOT NULL,
	population INTEGER NOT NULL CHECK(population > 0),
	area INTEGER NOT NULL CHECK(area > 0),	
	hospital_count INTEGER NOT NULL CHECK(hospital_count >= 0),
	national_park_count INTEGER NOT NULL CHECK(national_park_count >= 0),
	river_count INTEGER NOT NULL CHECK(river_count >= 0),
	school_count INTEGER NOT NULL CHECK(school_count >= 0),
	continent_id uuid NOT NULL,
	CONSTRAINT fk_continent_id FOREIGN KEY (continent_id) REFERENCES continents (id)
);

CREATE TABLE cities (
	id uuid UNIQUE NOT NULL DEFAULT uuid_generate_v4(),
	name VARCHAR(30) UNIQUE NOT NULL,
	population INTEGER NOT NULL CHECK(population > 0),
	area INTEGER NOT NULL CHECK(area > 0),
	road_count INTEGER NOT NULL CHECK(road_count >= 0),
	tree_count INTEGER NOT NULL CHECK(tree_count >= 0),
	shop_count INTEGER NOT NULL CHECK(shop_count >= 0),
	school_count INTEGER NOT NULL CHECK(school_count >= 0),
	country_id uuid NOT NULL,
	CONSTRAINT fk_country_id FOREIGN KEY (country_id) REFERENCES countries (id)
);

/*
Triggers
*/
/*Check country area/population <= continent area/population*/
CREATE OR REPLACE FUNCTION continent_check() RETURNS trigger AS 
$BODY$
	BEGIN
		IF ((SELECT sum(population) FROM countries WHERE continent_id = NEW.id) > NEW.population) THEN
		RAISE EXCEPTION 'Sum of country population > continent population';		
		END IF;
		IF ((SELECT sum(area) FROM countries WHERE continent_id = NEW.id) > NEW.area) THEN
		RAISE EXCEPTION 'Sum of country area > continent area';		
		END IF;
		
		RETURN NEW;
	END;
$BODY$
LANGUAGE 'plpgsql';
CREATE TRIGGER continent_check AFTER INSERT OR UPDATE ON continents
    FOR EACH ROW EXECUTE PROCEDURE continent_check();

/*Check country area/population <= continent area/population and city area/population/school_count <= country area/population/school_count*/
CREATE OR REPLACE FUNCTION country_check() RETURNS trigger AS
$BODY$
	BEGIN
		IF ((SELECT sum(population) FROM countries WHERE continent_id = NEW.continent_id) > (SELECT population FROM continents WHERE id = NEW.continent_id)) THEN
		RAISE EXCEPTION 'Sum of country population > continent population';		
		END IF;

		IF ((SELECT sum(area) FROM countries WHERE continent_id = NEW.continent_id) > (SELECT area FROM continents WHERE id = NEW.continent_id)) THEN
		RAISE EXCEPTION 'Sum of country area > continent area';		
		END IF;

		IF ((SELECT sum(population) FROM cities WHERE country_id = NEW.id) > NEW.population) THEN
		RAISE EXCEPTION 'Sum of city population > country population';		
		END IF;

		IF ((SELECT sum(area) FROM cities WHERE country_id = NEW.id) > NEW.area) THEN
		RAISE EXCEPTION 'Sum of city area > country area';		
		END IF;

		IF ((SELECT sum(school_count) FROM cities WHERE country_id = NEW.id) > NEW.school_count) THEN
		RAISE EXCEPTION 'Sum of city school_count > country school_count';		
		END IF;
		
		RETURN NEW;

	END;
$BODY$
LANGUAGE 'plpgsql';
CREATE TRIGGER country_check AFTER INSERT OR UPDATE ON countries
    FOR EACH ROW EXECUTE PROCEDURE country_check();

/*Check city area/population/school_count <= country area/population/school_count*/
CREATE OR REPLACE FUNCTION city_check() RETURNS trigger AS
$BODY$
	BEGIN
		IF ((SELECT sum(population) FROM cities WHERE country_id = NEW.country_id) > (SELECT population FROM countries WHERE id = NEW.country_id)) THEN
		RAISE EXCEPTION 'Sum of city population > country population';		
		END IF;

		IF ((SELECT sum(area) FROM cities WHERE country_id = NEW.country_id) > (SELECT area FROM countries WHERE id = NEW.country_id)) THEN
		RAISE EXCEPTION 'Sum of city area > country area';		
		END IF;

		IF ((SELECT sum(school_count) FROM cities WHERE country_id = NEW.country_id) > (SELECT school_count FROM countries WHERE id = NEW.country_id)) THEN
		RAISE EXCEPTION 'Sum of city school_count > country school_count';		
		END IF;

		RETURN NEW;

	END;
$BODY$
LANGUAGE 'plpgsql';
CREATE TRIGGER city_check AFTER INSERT OR UPDATE ON cities
    FOR EACH ROW EXECUTE PROCEDURE city_check();







