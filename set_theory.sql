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


\*
    Determine all combinations (include duplicates) of country code and year that exist in either the economies or the populations tables.
    The result of the query should only have two columns/fields.
    Think about how many records this query should result in.
    You'll use code very similar to this in your next exercise after the video. Make note of this code after completing it.
*\

--union 3
SELECT code, year
FROM economies
UNION ALL
SELECT country_code, year
FROM populations
ORDER BY code, year;
