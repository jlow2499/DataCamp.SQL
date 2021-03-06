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


--    Append the second part's query to the first part's query using WHERE, AND, and IN to obtain the name of the country, its continent, and the maximum inflation rate for each continent in 2015. Revisit the sample output in the assignment text at the beginning of the exercise to see how this matches up.
--    For the sake of practice, change all joining conditions to use ON instead of USING.

--This code works since each of the six maximum inflation rate values occur only once in the 2015 data. Think about whether this particular code involving subqueries would work in cases where there are ties for the maximum inflation rate values.

SELECT MAX(inflation_rate) AS max_inf
  FROM (
      SELECT code, continent,inflation_rate
      FROM countries
      INNER JOIN economies
      USING (code)
      WHERE economies.year = 2015) AS subquery
GROUP BY continent;


 --   Append the second part's query to the first part's query using WHERE, AND, and IN to obtain the name of the country, its continent, and the maximum inflation rate for each continent in 2015. Revisit the sample output in the assignment text at the beginning of the exercise to see how this matches up.
--    For the sake of practice, change all joining conditions to use ON instead of USING.

--This code works since each of the six maximum inflation rate values occur only once in the 2015 data. Think about whether this particular code involving subqueries would work in cases where there are ties for the maximum inflation rate values.

SELECT name, continent, inflation_rate
FROM countries
INNER JOIN economies
ON countries.code = economies.code
WHERE year = 2015
    AND inflation_rate IN (
        SELECT MAX(inflation_rate) AS max_inf
        FROM (
             SELECT name, continent, inflation_rate
             FROM countries
             INNER JOIN economies
             ON countries.code = economies.code
             WHERE year = 2015) AS subquery
        GROUP BY continent);


--Let's test your understanding of the subqueries with a challenge problem! Use a subquery to get 2015 economic data for countries that do not have

--    gov_form of "Constitutional Monarchy" or
 --   'Republic' in their gov_form.

--Here, gov_form stands for the form of the government for each country. Review the different entries for gov_form in the countries table.
        
        
  
   -- Select unique country names. Also select the total investment and imports fields.
   -- Use a left join with countries on the left. (An inner join would also work, but please use a left join here.)
   -- Match on code in the two tables AND use a subquery inside of ON to choose the appropriate languages records.
   -- Order by country name ascending.
   -- Use table aliasing but not field aliasing in this exercise.
      
        
        
        
 SELECT code, inflation_rate, unemployment_rate
FROM economies
WHERE year = 2015 AND code NOT IN
  (SELECT code
   FROM countries
   WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic%'))
ORDER BY inflation_rate;

SELECT DISTINCT name, total_investment, imports
FROM countries AS c
LEFT JOIN economies AS e
ON (c.code = e.code
  AND c.code IN (
    SELECT l.code
    FROM languages AS l
    WHERE official = 't'
  ) )
WHERE region = 'Central America' AND year = 2015
ORDER BY name;


--    Include the name of region, its continent, and average fertility rate aliased as avg_fert_rate.
 --   Sort based on avg_fert_rate ascending.
 --   Remember that you'll need to GROUP BY all fields that aren't included in the aggregate function of SELECT.


-- choose fields
SELECT c.region, c.continent, AVG(p.fertility_rate) AS avg_fert_rate
-- left table
FROM countries AS c
-- right table
INNER JOIN populations AS p
-- join conditions
ON c.code = p.country_code
-- specific records matching a condition
WHERE p.year = 2015
-- aggregated for each what?
GROUP BY c.region, c.continent
-- how should we sort?
ORDER BY avg_fert_rate


--    Select the city name, country code, city proper population, and metro area population.
 --   Calculate the percentage of metro area population composed of city proper population for each city in cities, aliased as city_perc.
 --   Focus only on capital cities in Europe and the Americas in a subquery.
--    Make sure to exclude records with missing data on metro area population.
--    Order the result by city_perc descending.
--    Then determine the top 10 capital cities in Europe and the Americas in terms of this city_perc percentage.
--    Do not use table aliasing in this exercise.

SELECT name, country_code, city_proper_pop, metroarea_pop,  
      city_proper_pop / metroarea_pop * 100 AS city_perc
FROM cities
WHERE name IN
  (SELECT capital
   FROM countries
   WHERE (continent = 'Europe'
      OR continent LIKE '%America'))
     AND metroarea_pop IS NOT NULL
ORDER BY city_perc DESC
LIMIT 10;
