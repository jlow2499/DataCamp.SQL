--inner joins

SELECT c.code, c.name, c.region, e.year, p.fertility_rate,e.unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code;

SELECT c.name AS country, l.name AS language
FROM countries AS c
INNER JOIN languages AS l;

SELECT c.name AS country, c.continent, l.name AS language, l.official
FROM countries AS c
INNER JOIN languages AS l
USING (code);

--self joins

SELECT p1.country_code, 
       p1.size AS size2010,
       p2.size AS size2015,
       (p2.size-p1.size)/p1.size*100.0 AS growth_perc
FROM populations AS p1
INNER JOIN populations AS p2
ON p1.country_code = p2.country_code AND p1.year = p2.year -5;

--CASE WHEN and THEN

-- get name, continent, code, and surface area
SELECT name, continent, code, surface_area,
    -- first case
    CASE WHEN surface_area > 2000000
    -- first then
            THEN 'large'
    -- second case
       WHEN surface_area > 350000
    -- second then
            THEN 'medium'
    -- else clause + end
       ELSE 'small' END
    -- alias resulting field of CASE WHEN
       AS geosize_group
-- from the countries table
FROM countries;

--INNER challange
SELECT country_code, size,
  -- start CASE here with WHEN and THEN
    CASE WHEN size > 50000000
            THEN 'large'
  -- layout other CASE conditions here
        WHEN size > 1000000
        THEN 'medium'
  -- end CASE here with ELSE & END
        ELSE 'small' END
  -- provide the alias of popsize_group to SELECT the new field
        AS popsize_group
INTO pop_plus
-- which table?
FROM populations
-- any conditions to check?
WHERE year = 2015;

SELECT c.name, c.continent, c.geosize_group, p.popsize_group
FROM countries_plus AS c
INNER JOIN pop_plus as p
ON c.code = p.country_code
ORDER BY geosize_group;






