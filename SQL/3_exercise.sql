use world;

#--------------------------------------------------------------
# JOIN

#1
SELECT 
	city.Name as nama_kota, 
    country.Name as negara, 
    city.Population 
FROM 
	city, 
    country  
WHERE 
	city.CountryCode = country.Code 
ORDER BY 
	city.population desc 
LIMIT 10
;

#2
SELECT 
	country.Name as negara, 
    country.GNP, 
    city.Name as capital, 
    country.population
FROM 
	country 
JOIN 
	city
	ON country.code=city.countrycode
WHERE 
	country.name='Netherlands' 
	AND 
	country.capital = city.id
;



#3
SELECT 
	c.name as negara, 
    cl.percentage as persentase
FROM 
	country c 
INNER JOIN 
	countrylanguage cl
	ON c.code = cl.countrycode
WHERE 
	cl.language='Spanish'
ORDER BY 
	cl.percentage DESC
LIMIT 10
;

#4
SELECT 
	country.name as negara,
	country.GNP,
	city.name as ibu_kota,
	city.population as populasi,
	countrylanguage.language
FROM 
	country 
JOIN 
	city 
    ON country.code=city.countrycode
JOIN 
	countrylanguage 
    ON country.code=countrylanguage.countrycode

WHERE country.name='Indonesia'
AND countrylanguage.isofficial ='T'
AND country.capital=city.ID
;

#--------------------------------------------------------------
# SUB QUERY 

#5
SELECT continent, count(name) AS jumlah_negara 
FROM country
GROUP BY continent
HAVING count(name) > (SELECT count(name) 
					  FROM country 
                      WHERE continent = 'North America' 
                      )
;

SELECT count(name) 
FROM country 
WHERE continent = 'North America'
;

#6
SELECT name AS negara, GNP 
FROM country
WHERE continent = 'Asia'
AND gnp > (SELECT avg(GNP) 
		   FROM country
           WHERE continent='Europe')
ORDER BY GNP DESC
;

SELECT avg(GNP) 
FROM country
WHERE continent='Europe'
;

#7
SELECT count(DISTINCT(region)), continent 
FROM country
WHERE continent LIKE '%a'
GROUP BY continent 
HAVING count(DISTINCT(region)) > (SELECT count(DISTINCT(region)) 
								  FROM country 
								  GROUP BY continent 
								  HAVING continent='Asia')
;

SELECT count(DISTINCT(region)) 
FROM country 
GROUP BY continent 
HAVING continent='Asia'
;

