--joins

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
