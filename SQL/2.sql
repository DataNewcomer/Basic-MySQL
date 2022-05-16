
# ============================================================================================================
# STRING PATTERN

# LIKE digunakan untuk mebatasi/filtering baris yang berisi kolom berupa teks
# LIKE digunakan setelah WHERE

# % --> menunjukkan bisa diawali/diikuti dengan berapapun jumlah karakter
# _ --> menunjukkan bisa diawali/diikuti dengan 1 karakter 

USE world;
SHOW FULL TABLES;


SELECT * 
FROM city
WHERE Population > 5000000
;


# filtering dengan menggunakan LIKE pada kolom berisi teks
SELECT * FROM city
WHERE District LIKE 'England';


# mencari kota yang District-nya diawali huruf 'z' dan diikuti berapapun jumlah hurufnya
SELECT * FROM city
WHERE District LIKE 'z%';


# mencari kota yang District-nya diawali huruf 'z' dan diikuti 4 huruf
SELECT * FROM city
WHERE District LIKE 'z____';


# mencari kota yang CountryCode-nya diakhiri dengan huruf 'a', diawali berpapun jumlah hurufnya
SELECT * FROM city
WHERE CountryCode LIKE '%a';


# mencari kota yang namanya 6 huruf
SELECT * FROM city
WHERE Name LIKE '______';

# mencari kota yang namanya 6 huruf, huruf terakhirnya adalah 'o'
SELECT * FROM city
WHERE Name LIKE '_____o';

# mencari kota yang namanya mengandung huruf 'x', baik di depan, tengah, atau belakang
SELECT * FROM city
WHERE Name LIKE '%x%';

# mencari kota yang namanya mengandung huruf 'x', diawali 2 huruf dan diikuti 2 huruf seletelah 'x'
SELECT * FROM city
WHERE Name LIKE '__x__';

# mencari kota yang namanya mengandung huruf 'x' ditengan (tidak diawali atau diakhiri 'x')
SELECT * FROM city
WHERE Name LIKE '%x%'
AND Name NOT LIKE 'x%'
AND Name NOT LIKE '%x'
;


# NOT untuk negasi
# Mencari kota yang namanya bukan diawali huruf 'a'
SELECT * FROM city
WHERE Name NOT LIKE 'a%';



# ============================================================================================================
# RANGE

# BETWEEN digunakan untuk membatasi rentang nilai tertentu
# BETWEEN harus mengandung nilai awal dan nilai akhir (nilai awal dan akhir include)
# NOT BETWEEN: nilai yang bukan dalam rentang tersebut


SELECT * FROM city
WHERE Population >= 5063499 AND Population <= 6000000;


# Populasi kota antara 5063499 sampai 6000000 penduduk, termasuk kota yang punya populasi 5063499 dan 6000000
SELECT * FROM city
WHERE Population BETWEEN 5063499 AND 6000000;


# Populasi kota dibawah 100 ribu (kota sedikit penduduk) dan di atas 8 juta (kota banyak penduduk) penduduk
SELECT * FROM city 
WHERE Population NOT BETWEEN 100000 AND 8000000; 



# ============================================================================================================
# SORTING

# ORDER BY digunakan untuk mengurutkan data baik ascending atau descending
# Ascending: A->Z, nilai kecil ke besar (default)
# Descending: Z->A, nilai besar ke kecil


# Mengurutkan Populasi kota dari yang penduduknya paling sedikit
SELECT * FROM city
ORDER BY Population 
;

# Mengurutkan Populasi kota dari yang penduduknya paling banyak
SELECT * FROM city
ORDER BY Population DESC
;


# 5 kota dengan populasi terbanyak
SELECT * FROM city
ORDER BY Population DESC
LIMIT 5						# LIMIT harus paling akhir
;


# Mengurutkan nama kota dari Z ke A
SELECT * FROM city
ORDER BY Name DESC
;

# Mengurutkan nama kota dari A ke Z
SELECT * FROM city
ORDER BY Name 
;

# Mengurutkan kota berdasarkan CountryCode dari A ke Z, lalu District dari A ke Z
SELECT * FROM city
ORDER BY CountryCode, District
;


# Mengurutkan kota berdasarkan CountryCode dari A ke Z, lalu District dari Z ke A
SELECT * FROM city
ORDER BY CountryCode ASC, District DESC
;


# Mengurutkan kota berdasarkan CountryCode dari A ke Z, lalu Populasi dari yang terbesar
SELECT * FROM city
ORDER BY CountryCode ASC, Population DESC
;



# ============================================================================================================
# GROUP BY

# GROUP BY digunakan untuk megelompokkan data berdasarkan baris tertentu
# Contoh: Total Populasi berdasarkan Negara
# GROUP BY biasanya berpasangan dengan aggregate function: SUM, AVG, MIN, MAX, COUNT, dll. 
# Untuk melakukan filtering setelah GROUP BY tidak bisa pakai WHERE, tapi harus menggunakan HAVING


# Menghitung jumlah kota berdasarkan negara
SELECT CountryCode, count(ID) as Jumlah_Kota
FROM city
GROUP BY CountryCode
;


# Menghitung jumlah kota berdasarkan negara, kemudian diurutkan dari jumlah kota terbanyak
SELECT CountryCode, count(ID) as Jumlah_Kota
FROM city
GROUP BY CountryCode
ORDER BY count(ID) DESC
;


# Rata-rata populasi kota berdasarkan District-nya, kemudian diurutkan dari populasi terbanyak, diambil 5 terbesar
SELECT district, avg(Population)     # memilih kolom yang mau ditampilkan
FROM city							 # memilih table
GROUP BY district					 # mengelompokkan kolom lain (diagregasi) berdasarkan kolom district
ORDER BY avg(Population) DESC		 # mengururtkan dari nilai terbesar
LIMIT 5								 # membatasi 5 baris paling atas
;


#
SELECT * FROM city;

# Menampilkan Total Populasi dan Jumlah Kota untuk tiap negara
SELECT CountryCode, sum(Population), count(ID)
FROM city
GROUP BY CountryCode;


# Rata-rata populasi suatu kota dan Jumlah kota untuk tiap negara yang nama negaranya berawalan 'B' dan diurutkan dari populasi terkecil
SELECT CountryCode, avg(Population), count(Name)
FROM city
WHERE CountryCode LIKE 'B%'
GROUP BY CountryCode
ORDER BY avg(Population) 
;


SELECT CountryCode, avg(Population), count(Name)
FROM city
GROUP BY CountryCode
HAVING CountryCode LIKE 'B%'
ORDER BY avg(Population) ASC
;



# Rata-rata populasi suatu kota dan Jumlah kota untuk tiap negara, 
# yang jumlah kotanya lebih 100 dan diurutkan dari populasi terbesar

SELECT CountryCode, avg(Population), count(Name)
FROM city
WHERE count(Name) > 100				# error
GROUP BY CountryCode
ORDER BY avg(Population) DESC
;


# Filtering harus dilakukan setelah GROUP BY dengan HAVING, tidak bisa dilakukan sebelum GROUP BY
SELECT CountryCode, avg(Population), count(Name)
FROM city
GROUP BY CountryCode
HAVING count(Name) > 100
ORDER BY avg(Population) DESC
;





# ============================================================================================================
# BUILT-IN DATABASE FUNCTION

# Aggregate function: berlaku untuk kumpulan/kelompok data atau seluruh data dalam sebuah kolom
# contoh: SUM, COUNT, AVG, MIN, MAX, dll. 

SELECT CountryCode, sum(Population) 
FROM city
GROUP BY CountryCode
;


# Scalar function: berlaku pada tiap baris pada suatu kolom
# contoh: ROUND, LENGTH, UCASE, LCASE, dll. 

SELECT District , length(District)
FROM city;

SELECT name, ucase(Name)
FROM city;


# Menampilkan nama kota dan jumlah karakternya, diambil yang terpanjang
SELECT name, length(name)
FROM city
ORDER BY length(name) DESC
LIMIT 1
;

# Menampilkan jumlah karakter nama kota terpanjang
SELECT max(length(name))
FROM city;


# Menampilkan nilai LifeExpectancy yang dibulatkan 
SELECT name, round(LifeExpectancy)
FROM Country;

# Menampilkan nilai GNPOld yang dibulatkan 1 digit di belakang koma
SELECT name, round(GNPOld, 1)
FROM country;


# Menampilkan kepadatan Penduduk (2 digit di belakang koma)
SELECT name, round(Population/SurfaceArea, 2) AS Population_Density
FROM Country;


# ============================================================================================================
# DATE & TIME BUILT-IN FUNCTION

USE sakila;
SHOW FULL TABLES;

# untuk melihat tipe data tiap kolom pada suatu table
SHOW COLUMNS FROM Payment;

SELECT * 
FROM Payment;


# Menampilkan tahun dari suatu kolom
SELECT payment_id, payment_date, year(payment_date)
FROM Payment
;


# Menampilkan bulan ke berapa (1-12)
SELECT payment_id, payment_date, month(payment_date)
FROM Payment
;


# Menampilkan nama bulan (January - December)
SELECT payment_id, payment_date, monthname(payment_date)
FROM Payment
;


# Menampilkan tanggal (1-31)
SELECT payment_id, payment_date, day(payment_date)
FROM Payment
;


# Menampilkan nama hari
SELECT payment_id, payment_date, dayname(payment_date)
FROM Payment
;


# Menampilkan pukul berapa (0-23)
SELECT payment_id, payment_date, hour(payment_date)
FROM Payment
;


# Menampilkan menit berapa (0-59)
SELECT payment_id, payment_date, minute(payment_date)
FROM Payment
;


# Menampilkan detik berapa (0-59)
SELECT payment_id, payment_date, second(payment_date)
FROM Payment
;


# Menampilkan pekan berapa (0-53)
SELECT payment_id, payment_date, week(payment_date)
FROM Payment
;


SELECT payment_id, payment_date, weekofyear(payment_date)
FROM Payment
;


# Menampilkan hari ke berapa dalam 1 minggu (0 Monday - 6 Sunday)
SELECT payment_id, payment_date, weekday(payment_date), dayname(payment_date)
FROM Payment
;
