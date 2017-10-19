--union 1

-- pick specified columns from 2010 table
SELECT *
-- 2010 table will be on top
FROM economies2010
-- which set theory clause?
UNION
-- pick specified columns from 2015 table
SELECT *
-- 2015 table on the bottom
FROM economies2015
-- order accordingly
ORDER BY code, year;

--union 2
SELECT country_code
FROM cities
UNION 
SELECT code
FROM currencies
ORDER BY country_code;

 --   Determine all combinations (include duplicates) of country code and year that exist in either the economies or the populations tables.
 --   The result of the query should only have two columns/fields.
 --   Think about how many records this query should result in.
 --   You'll use code very similar to this in your next exercise after the video. Make note of this code after completing it.


--union 3
SELECT code, year
FROM economies
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;

--Repeat the previous UNION ALL exercise, this time looking at the records in common for country code and year for the economies and populations tables.


  --  Again, order by code and then by year, both in ascending order.
  --  Note the number of records here (given at the bottom of query result) compared to the similar UNION ALL query result (814 records).

SELECT code, year
FROM economies
INTERSECT
SELECT country_code, year
FROM populations
ORDER BY code, year;

--Get the names of cities in cities which are not noted as capital cities in countries as a single field result.  Note that there are some countries in the world that are not included in the countries table, which will result in some cities not being labeled as capital cities when in fact they are.

--Order the resulting field in ascending order.
--Can you spot the city/cities that are actually capital cities which this query misses?

SELECT name
FROM cities
EXCEPT
SELECT capital
FROM countries
ORDER BY name;

--Semi-Join
--Now combine the previous two queries into one query using WHERE to determine the unique languages spoken in the Middle East.
Carefully review this result and its code after completing it.  It serves as a great example of subqueries, which are the focus of Chapter 4.
SELECT DISTINCT(name)
FROM languages
WHERE code IN
    (SELECT code
     FROM countries
     WHERE region = 'Middle East')
ORDER BY name;

--Another powerful join in SQL is the anti-join. It is particularly useful in identifying which records are causing an incorrect number of records to appear in join queries.You will also see another example of a subquery here, as you saw in the first exercise on semi-joins. Your goal is to identify the currencies used in Oceanian countries!


SELECT code,name 
FROM countries
WHERE continent = 'Oceania'
AND code NOT IN
 (SELECT code
  FROM currencies );


--Congratulations!  You've now made your way to the challenge problem for this third chapter. Your task here will be to incorporate two of UNION/UNION ALL/INTERSECT/EXCEPT to solve a challenge involving three tables.
--In addition, you will use a subquery as you have in the last two exercises!  This will be great practice as you hop into subqueries more in Chapter 4!

--Identify the country codes that are included in either economies or currencies but not in populations.Use that result to determine the names of cities in the countries that match the specification in the previous instruction.Identify the country codes that are included in either economies or currencies but not in populations.Use that result to determine the names of cities in the countries that match the specification in the previous instruction.

-- select the city name
SELECT c1.name
-- alias the table where city name resides
FROM cities AS c1
-- choose only records matching the result of multiple set theory clauses
WHERE country_code IN
(    -- select appropriate field from economies AS e    
 SELECT e.code
 FROM economies AS e
 -- get all additional (unique) values of the field from currencies AS c2
 UNION ALL
 SELECT (c2.code)
 FROM currencies AS c2
 -- exclude those appearing in populations AS p
 EXCEPT
 SELECT p.country_Code
 FROM populations AS p);




