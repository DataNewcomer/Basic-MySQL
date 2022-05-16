# ==============================================================================================
# COMMON TABLE EXPRESSION (CTE)

# CTE adalah sebuah query dalam SQL berupa subquery yang ditulis secara terpisah
# sehingga dapat dipegunakan kembali

# CTE ditulis sebelum melakukan operasi SELECT ... FROM ... 
# Syntax: WITH nama_table_CTE AS (...isi subquery-nya...)

# Cara kerjanya, SQL akan menjalankan CTE nya dulu
# kemudian hasilnya disimpan dalam sebuah table sementara sesuai dengan nama CTEnya
# kemudian table CTE ini bisa digunakan berulang kali untuk keperluan pengambilan data atau join table. 

# Kelebihan
# - cara penulisannya lebih rapih dan mudah dibaca
# - dapat digunakan kembali

# Kekurangan
# - running lebih lambat dari metode lainnya

USE sakila; 
SHOW FULL TABLES;

SELECT * FROM film;


# Menampilkan film dengan rental duration yang lebih besar dari rata-rata rental duration keseluruhan

# pertama cari dulu rata-rata rental duration keseluruhan
SELECT avg(rental_duration)
FROM film;

# kemudian query di atas dijadikan sebagai subquery untuk filtering
SELECT *
FROM film
WHERE rental_duration > (SELECT avg(rental_duration)
						 FROM film)
;


# ------------------------------------------------------------------------------------
# Membuat table CTE berisi avg rental duration

# CARA 1
WITH table_avg_rental_duration 
AS (SELECT avg(rental_duration) as avg_rental
	FROM film)

SELECT *
FROM film
WHERE rental_duration > (SELECT avg_rental
                         FROM table_avg_rental_duration)
;


# ------------------------------------------------------------------------------------
# CARA 2

WITH table_avg_rental_duration 
AS (SELECT avg(rental_duration) as avg_rental
	FROM film)

SELECT *
FROM film as f, table_avg_rental_duration as t
WHERE f.rental_duration > t.avg_rental
;




# Latihan
# Menampilkan benua dengan jumlah negara lebih dari jumlah negara di benua North America!
USE world;

# pertama, kita cari dulu jumlah negara di continent North America
SELECT count(name) as jml_negara
FROM country
WHERE continent = 'North America';

# query di atas, kita masukkan sebagai CTE
WITH table_jml_negara_North_America 
AS (SELECT count(name) as jml_negara
	FROM country
    WHERE continent = 'North America')
    
SELECT continent, count(name) AS jumlah_negara 
FROM country
GROUP BY continent
HAVING jumlah_negara > (SELECT jml_negara 
					    FROM table_jml_negara_North_America)
;


# ==============================================================================================
# WINDOW FUNCTION

# Kalau menggunakan GROUP BY, terdapat key column yang isinya adalah distinct value, dan kolom lainnya adalah agregasi
# GROUP BY menyebabkan berkurangnya jumah baris
# Baris yang ditampilkan sesuai dengan jumlah distinct value pada key column


# Dengan Window Function kita dapat melakukan agregasi dengan tetap mempertahankan jumlah baris sebagaimana adanya
# Semua value tetap pada row-nya


# Tampilkan rata-rata rental duration berdasarkan rating
SELECT rating, avg(rental_duration)
FROM film
GROUP BY rating
;

SELECT *
FROM film;



# ==============================================================================================
# OVER PARTITION BY clause

# Mirip dengan GROUP BY

SELECT *
FROM film;

SELECT 
	film_id,
	title,
    rating,
	rental_rate,
    avg(rental_rate) OVER() AS avg_rental_rate,		# ini rata-rata rental_rate keseluruhan
    avg(rental_rate) OVER() - rental_rate			# ini selisih rata-rata rental_rate keseluruhan dengan rental_rate tiap baris
FROM
	film;
    
    
SELECT
	film_id,
    title,
    rating,
    rental_rate,
    avg(rental_rate) OVER(PARTITION BY rating) AS avg_rental_rate_by_rating,   # ini rata-rata rental_rate berdasarkan rating
    avg(rental_rate) OVER(PARTITION BY rating) - rental_rate				   # ini selisih rata-rata rental_rate berdasarkan rating dengan rental_rate tiap baris
FROM 
	film
ORDER BY
	film_id
;
    
    
SHOW FULL TABLES;
SELECT * 
FROM film_list;

# Tampilkan nama film, category, durasi film (length), dan rata-rata durasi film berdasarkan category
SELECT
	title,
    category,
    length,
	avg(length) OVER(PARTITION BY category) AS avg_length_by_category
FROM 
	film_list;




# ==============================================================================================
# ROW_NUMBER

# Membuat kolom baru berisikan nomor baris
# Mirip dengan index baris, tapi ROW_NUMBER ini disimpan dalam kolom

SELECT *
FROM film;

# Menampilkan ROW NUMBER secara keseluruhan
SELECT 
	ROW_NUMBER() OVER() as No,
    title, 
    rating,
    rental_duration
FROM
	film;


# Menampilkan ROW NUMBER berdasarkan ratingnya
SELECT 
	ROW_NUMBER() OVER(PARTITION BY rating) as No_by_rating,
    title, 
    rating,
    rental_duration
FROM
	film;




# ==============================================================================================
# RANK dan DENSE_RANK

# ROW_NUMBER menghitung baris data dalam angak 1 sampai N dari urutan terkecil
# RANK dan DENSE_RANK menghitung urutan berdasarkan value yang ingin kita ukur dan bisa dari tertinggi ke terendah

# Tampilkan ranking untuk category rating dengan total film paling banyak

# Menampilkan juga rankingnya
SELECT 
	rating,
    count(film_id),
    RANK() OVER(ORDER BY count(film_id) DESC)  
FROM film
GROUP BY rating;

# ORDER BY biasa, tanpa diketahui urutan atau ranking ke berapa
SELECT rating, count(film_id)
FROM film
GROUP BY rating
ORDER BY count(film_id) DESC;


# RANK dari peringkat 1 langsung lanjut ke peringkat 204 (karena ada 203 film berdurasi sewa 3 hari)
SELECT
	film_id, 
	title,
    rental_duration,
    RANK() OVER(ORDER BY rental_duration)
FROM film;


# DENSE_RANK dari peringkat 1 lanjut ke peringkat 2 (walaupun ada 203 film berdurasi sewa 3 hari)
SELECT
	film_id, 
	title,
    rental_duration,
    DENSE_RANK() OVER(ORDER BY rental_duration)
FROM film;



# ==============================================================================================
# NTILE()

# Mengelompokkan data dari terkecil ke terbesar
# Jumlah kelompoknya disesuaikan dengan persentase pembagian yang dimasukkan 
# NTILE(4) --> artinya data akan dibagi 4 bagian/kelompok dengan tiap kelompok punya jumlah yang sama

SELECT *
FROM film;

SELECT 
	title,
    rating,
    NTILE(4) OVER() as quartile,  		# quartile
    NTILE(100) OVER() as percentile, 	# percentile
    ROW_NUMBER() OVER() as No
FROM
	film;

SELECT 
	title,
    rating,
    NTILE(4) OVER(PARTITION BY rating) as quartile_by_rating,  # quartile
    NTILE(100) OVER(PARTITION BY rating) as percentile_by_rating,
    ROW_NUMBER() OVER(PARTITION BY rating) as No_by_rating
FROM
	film;



# ==============================================================================================
# SLIDING WINDOWS

# Untuk menghitung angka agregat yang bersifat bergerak atau kumulatif
# bisa digunakan untuk menghitung moving verage, cummulative sum, dll. 
# OVER (ROWS BETWEEN unbounded preceding AND current row)

# CORRENT ROW: row yang aktif
# FOLLOWING: row setelah
# PRECEDING: row sebelum
# UNBOUNDED PRECEDING: row pertama
# UNBOUNDED FOLLOWING: row terakhir

# Menghitung cummulative sum dari total film berdasarkan rating

WITH table_jml_film_per_rating AS (
SELECT rating, count(film_id) as jml_film
FROM film
GROUP BY rating
)

SELECT 
	rating,
    jml_film,
    sum(jml_film) OVER(ORDER BY jml_film ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cum_sum_jml_film,
    avg(jml_film) OVER(ORDER BY jml_film ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as moving_avg_jml_film
FROM 
	table_jml_film_per_rating
;











