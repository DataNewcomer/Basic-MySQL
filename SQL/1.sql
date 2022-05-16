# MySQL

# python case sensitive. MySQL tidak case sensitive
# index mulai dari 1


# =====================================================================================
# CREATE DATABASE & TABLE STATEMENTS

# CREATE: membuat database atau table baru

# Cek database yang tersedia
SHOW DATABASES; 

# Buat database baru
CREATE DATABASE seller;

# Menggunkan sebuah database
USE seller; 

# Melihat table yang ada pada sebuah database
SHOW FULL TABLES;

# Menghapus sebuah database (Hati-hati)
DROP DATABASE seller;


# Buat database baru
CREATE DATABASE seller;
USE seller; 

# Buat table
CREATE TABLE person (
PersonID INT,
LastName VARCHAR(255),
FirstName VARCHAR(255),
Adress VARCHAR(255),
City VARCHAR(255)
)
;

# Cek table apa saja yang ada di sebuah database
SHOW FULL TABLES;

SELECT * FROM person;


# Menambah kolom pada table yang sudah ada
ALTER TABLE person
ADD age INT;



# =====================================================================================
# SELECT TABLE STATEMENT

# SELECT digunakan untuk memilih kolom dari suatu table
# FROM digunakan untuk memilih table
# Syntax --> SELECT columnA, columnB, .... FROM nama_table

USE world;
SHOW FULL TABLES;


# Menampilkan semua kolom pada table country 
# * artinya semua kolom
SELECT * FROM country;


# Menampilkan beberapa kolom pada suatu table
# Menampilkan kolom Name dan Population pada table country 
SELECT Name, Population 
FROM country;


# =====================================================================================
# STATEMENT: LIMIT, DISTINCT, COUNT, AVG, SUM


#--------------------------------------------------------
# LIMIT
# untuk membatasi jumlah baris
# SELECT nama_kolom FROM nama_table LIMIT jumlah_baris_yang_ditampilkan

# menampilkan 5 baris paling atas
SELECT * FROM country
LIMIT 10
;

# menampilkan 5 baris setelah baris ke-3
SELECT * FROM country
LIMIT 5 OFFSET 3
;


#--------------------------------------------------------
# DISTINCT
# untuk menampilkan unique value 
# SELECT DISTINCT nama_kolom FROM nama_table
SELECT DISTINCT continent 
FROM country
;


#--------------------------------------------------------
# COUNT
# untuk menghitung jumlah data/baris
# SELECT count(nama_kolom) FROM nama_table


# menampilkan jumlah baris pada kolom Name
SELECT count(name) 
FROM country;


# menampilkan jumlah baris pada kolom Continent
SELECT count(continent) 
FROM country;

SELECT *
FROM country;


# menghitung jumlah benua 
SELECT count(DISTINCT continent)
FROM country;

# menghitung jumlah negara 
SELECT count(DISTINCT name)
FROM country;


# menghitung jumlah benua 
SELECT count(DISTINCT continent) AS Jumlah_Benua
FROM country;


#--------------------------------------------------------
# SUM
# menjumlahkan nilai pada kolom yang berisi data numerikal
# SELECT sum(nama_kolom) FROM nama_table

SELECT sum(Population) as Total_Populasi
FROM city;



#--------------------------------------------------------
# AVG
# menghitung rata-rata pada kolom yang berisi data numerikal
# # SELECT avg(nama_kolom) FROM nama_table


SELECT avg(Population) as Rata_Rata_Populasi
FROM city;



# =====================================================================================
# INSERT STATEMENT

# INSERT INTO digunakan untuk memasukkan data ke dalam tabel

use seller;
SELECT * FROM person;

# Cara penulisan kalau mau memasukkan data ke semua kolom
# INSERT INTO nama_tabel
# VALUES (value1, value2, value3)

INSERT INTO person
VALUES (1, 'Federer', 'Roger', 'Serpong', 'Tangerang', 38);


# Cara penulisan kalau mau memasukkan data ke beberapa kolom spesifik
# INSERT INTO nama_tabel(column1, column2)
# VALUES (value1, value2)

INSERT INTO person(LastName, FirstName)
VALUES ('Swift', 'Taylor');

SELECT * FROM person;



# =====================================================================================
# UPDATE STATEMENT

# UPDATE digunakan untuk memodifikasi/mengganti nilai yang sudah ada di suatu table
# UPDATE biasanya digabungkan dengan WHERE agar data yang diupdate lebih spesifik

# UPDATE nama_table
# SET nama_kolom = nilai_yg_mau_diisi
# WHERE kodisi

# mengganti data semua baris dalam 1 kolom
UPDATE person
SET Adress = 'Pamulang';


# mengganti data dalam 1 kolom dan 1 baris tertentu
UPDATE person
SET Adress = 'Ciputat'
WHERE PersonID = 1
;


# mengganti data dalam beberapa kolom di 1 baris
UPDATE person
SET PersonID = 2, City = 'Bekasi', age = 22
WHERE FirstName = 'Taylor';


select * from person;



# =====================================================================================
# DELETE STATEMENT

# DELETE digunakan untuk menghapus baris pada sebuah table

# DELETE FROM nama_table
# WHERE kondisi

DELETE FROM person
WHERE PersonID = 2;

select * from person;




# =====================================================================================
# WHERE STATEMENT

# WHERE digunakan untuk filtering baris mana saja yang ingin ditampilkan
# Jika kondisinya lebih dari 1 kondisi, bisa digabungkan dengan AND atau OR

# SELECT nama_column FROM nama_table
# WHERE kodisi

USE world;


# filtering dengan 1 kondisi
SELECT * FROM country
WHERE Population > 100000000
;

# filtering dengan 2 kondisi dengan AND (kedua kondisi harus terpenuhi)
SELECT * FROM country
WHERE Population > 100000000 AND GNP > 500000
;


# filtering dengan 2 kondisi dengan OR (salah satu kondisinya saja yang harus terpenuhi)
SELECT * FROM country
WHERE Population > 100000000 OR GNP > 500000
;



# Buatlah tabel baru bernama 'pelanggan' dalam database 'seller'
# yang berisi kolom NomorID, Nama, Usia, Kota, TahunDaftar dengan total 7 baris












