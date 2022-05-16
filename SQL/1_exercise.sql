## Exercise 1 SQL

# 1.  Ada berapa negara di database world?
SELECT COUNT(name) AS jumlah_negara 
FROM country;


# 2.  Tampilkan rata-rata harapan hidup di benua Asia!
SELECT continent, avg(lifeexpectancy) AS average_life_expectancy FROM country
WHERE continent = 'Asia';

SELECT continent, ROUND(avg(lifeexpectancy), 2) AS average_life_expectancy FROM country
WHERE continent = 'Asia';


# 3.  Tampilkan total populasi di Asia Tenggara!
SELECT region, sum(Population) as Total_Populasi
FROM country
WHERE region = 'Southeast Asia'
;


# 4.  Tampilkan rata-rata GNP di benua Afrika region Eastern Africa. Gunakan alias 'Average_GNP' untuk rata-rata GNP!
SELECT region, avg(gnp) as Avg_GNP
FROM country
WHERE continent = 'Africa' AND region = 'Eastern Africa';


# 5.  Tampilkan rata-rata Populasi pada negara yang luas areanya lebih dari 5 juta km2! 
SELECT avg(Population) as avg_population_bigarea_countries
FROM country
WHERE SurfaceArea > 5000000
;


# 6.  Ada berapa bahasa (unique) di dunia?
SELECT COUNT(DISTINCT(language)) as jumlah_bahasa 
FROM countrylanguage;


# 7.  Tampilkan GNP dari 5 negara di Asia yang populasinya di atas 100 juta penduduk!
SELECT name as Negara, GNP FROM country
WHERE continent = 'Asia' AND Population > 100000000
LIMIT 5;


# 8.  Tampilkan negara di Afrika yang memiliki SurfaceArea di atas 1.200.000!
SELECT Name, SurfaceArea 
FROM country
WHERE Continent = 'Africa' AND SurfaceArea > 1200000;


# 9.  Tampilkan negara di Asia yang sistem pemerintahannya adalah republik. Ada berapa jumlah negaranya?
SELECT Name, Continent, GovernmentForm 
FROM country
WHERE Continent = 'Asia' AND GovernmentForm = 'Republic';

SELECT COUNT(Name) as Jumlah_Republik_di_Asia
FROM country
WHERE Continent = 'Asia' AND GovernmentForm = 'Republic';


# 10. Tampilkan jumlah negara di Eropa yang merdeka sebelum 1940!
SELECT COUNT(Name) as Jumlah_Negara
FROM country
WHERE Continent = 'Europe' AND IndepYear < 1940;








