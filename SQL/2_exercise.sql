# Exercise M2_S2

# World

#1. Ada berapa region di data world?
#2. Ada berapa negara di Africa?
#3. Tampilkan 5 negara dengan populasi terbesar!
#4. Tampilkan rata-rata harapan hidup tiap benua dan urutkan dari yang terendah!
#5. Tampilkan Jumlah region tiap benua dengan jumlah region lebih dari 3
#6. Tampilkan rata-rata GNP di Afrika berdasarkan regionnya dan urutkan dari GNP terbesar
#7. Tampilkan negara di Eropa yang memiliki nama dimulai dari huruf I
#8. Ada berapa bahasa berbeda di dunia?
#9. Tampilkan nama negara yang panjang hurufnya 6 huruf dan berakhiran 'O'
#10. Tampilkan 7 bahasa terbesar di Indonesia (secara persentase, dengan persentase dibulatkan)


show databases;
use world;
show full tables;

#1. Ada berapa region di database world?
SELECT count(DISTINCT region) as Jumlah_Region
FROM country;


#2. Ada berapa negara di Africa?
SELECT continent, count(name) as Jumlah_Negara
FROM country
WHERE continent = 'Africa';


#3. Tampilkan 5 negara dengan populasi terbesar!
SELECT Name, Population
FROM country
ORDER BY Population DESC
LIMIT 5;

SELECT Name, format(Population,0)
FROM country
ORDER BY Population DESC
LIMIT 5;


#4. Tampilkan rata-rata harapan hidup tiap benua dan urutkan dari yang terendah!
SELECT continent, avg(LifeExpectancy) as average_life_expectancy 
FROM country
GROUP BY continent
ORDER BY Rata_Rata;


#5. Tampilkan Jumlah region tiap benua dengan jumlah region lebih dari 3
SELECT continent, count(DISTINCT Region) AS jumlah_region
FROM country
GROUP BY continent
HAVING count(DISTINCT region) > 3;

#6. Tampilkan rata-rata GNP di Afrika berdasarkan regionnya dan urutkan dari GNP terbesar
SELECT continent, region, avg(GNP) as average_GNP
FROM country
WHERE Continent='Africa'
GROUP BY region
ORDER BY avg(GNP) DESC;


#7. Tampilkan negara di Eropa yang memiliki nama dimulai dari huruf I
SELECT Name, Continent 
FROM country
WHERE Continent='Europe' AND Name LIKE "I%";


#8. Ada berapa bahasa berbeda di dunia?
SELECT count(DISTINCT (Language))
FROM countrylanguage;


#9. Tampilkan nama negara yang panjang hurufnya 6 huruf dan berakhiran 'O'
SELECT Name 
FROM country 
WHERE Name LIKE "_____o";

SELECT Name, length(Name)
FROM country 
WHERE Name LIKE "_____o";


#10. Tampilkan 7 bahasa terbesar di Indonesia (secara persentase, dengan persentase dibulatkan)
SELECT Language, round(Percentage) "persentase"
FROM countrylanguage cl
WHERE CountryCode = 'IDN'
ORDER BY Percentage DESC
LIMIT 7;



#======================================================================================
# SAKILA

#1. Tampilkan aktor yang memiliki nama depan ‘Scarlett’! 
#2. Tampilkan aktor yang memiliki nama belakang ‘Johansson’!
#3. Berapa banyak nama belakang aktor (tanpa ada pengulangan/distinct)?
#4. Tampilkan 5 nama belakang aktor yang keluar hanya satu kali di database Sakila!
#5. Tampilkan 5 nama belakang aktor yang keluar lebih dari satu kali di database Sakila!
#6. Tampilkan 5 nama belakang aktor yang keluar lebih dari satu kali di database Sakila!
#7. Berapa rata-rata durasi film di database Sakila?



USE sakila;
SHOW FULL TABLES;

#1. Tampilkan aktor yang memiliki nama depan ‘Scarlett’! 
select first_name as Nama_Depan, last_name as Nama_Belakang from actor
where first_name='SCARLETT'
;  

#2. Tampilkan aktor yang memiliki nama belakang ‘Johansson’!
select first_name as Nama_Depan, last_name as Nama_Belakang from actor
where last_name='JOHANSSON'
;

#3. Berapa banyak nama belakang aktor (tanpa ada pengulangan/distinct)?
select count(distinct(last_name)) as Jumlah_Nama_Belakang from actor
;

#4. Tampilkan 5 nama belakang aktor yang keluar hanya satu kali di database Sakila!
select last_name as Nama_Belakang, count(last_name) as Jumlah from actor
group by last_name
having Jumlah=1
limit 5
;

#5. Tampilkan 5 nama belakang aktor yang keluar lebih dari satu kali di database Sakila!
select last_name as Nama_Belakang, count(last_name) as Jumlah from actor
group by last_name
having Jumlah>1
limit 5
;

#6. Tampilkan 5 nama belakang aktor yang keluar lebih dari satu kali di database Sakila!
select title as Judul, release_year as Tahun_Release from film
where title='Academy Dinosaur'
;

#7. Berapa rata-rata durasi film di database Sakila?
select avg(length) as Rata_Durasi from film
;
