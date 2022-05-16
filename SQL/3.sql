# =======================================================================================
#SUB-QUERIES

# Subquery adalah query di dalam query yang lebih besar

# Contoh 

# SELECT nama_kolom1
# FROM nama_table1
# WHERE nama_kolom2 = (SELECT MAX(nama_kolom2) FROM nama_table2)

USE employees;
SHOW FULL TABLES;

SELECT * 
FROM employees;


# Ini contoh yang salah, aggregate function (max, sum, avg, dll) tidak bisa digunakan setelah WHERE
# Menampilkan karyawan termuda
SELECT *
FROM employees
WHERE birth_date = max(birth_date) 
;

# Maka kita menggunakan subquery untuk mencari dahulu nilai birth_date paling muda
SELECT max(birth_date) FROM employees;  # --> ini menjadi subquery-nya

# Subquery haris diberi tanda kurung
SELECT *
FROM employees
WHERE birth_date = (SELECT max(birth_date) FROM employees) 
;


SELECT *
FROM Salaries;

SELECT avg(salary) FROM salaries;

# Subquery bisa diletakkan setelah WHERE clause
SELECT * 
FROM salaries
WHERE salary > (SELECT avg(salary) FROM salaries)
;

# Subquery bisa diletakkan setelah SELECT clause 
SELECT emp_no, salary, (SELECT avg(salary) FROM salaries) as AVG_Salary, from_date, to_date
FROM salaries
;


SELECT 
	emp_no, salary, 
	(SELECT avg(salary) FROM salaries WHERE year(from_date) = 1986), 
    from_date, 
    to_date
FROM 
	salaries
WHERE 
	year(from_date) = 1986
;


# Membandingkan gaji karyawan dengan gaji paling besar dan paling kecil
SELECT
	emp_no,
    salary,
    (SELECT max(salary) FROM salaries) as max_salary,
    (SELECT min(salary) FROM salaries) as min_salary,
    (SELECT avg(salary) FROM salaries) as avg_salary
FROM
	salaries;
    
    
# Subquery bisa diletakkan setelah FROM clause

# Tabel biodata karyawan perempuan
SELECT birth_date, first_name, last_name, gender
FROM employees
WHERE gender = 'F';    


# Menampilkan karyawan yang lahir tahun 1964, dari table biodata karyawan perempuan
SELECT *
FROM (SELECT birth_date, first_name, last_name, gender
	  FROM employees
	  WHERE gender = 'F') as Biodata_Employees_Female
WHERE year(birth_date) = 1964
;

SHOW FULL TABLES;


# =======================================================================================
# WORKING WITH MULTIPLE TABLES

# Dapat menggunakan subquery, implicit join, join operator

# Menampilkan karyawan yang memiliki title 'Senior Engineer'
SELECT *
FROM employees;

SELECT *
FROM titles;

# pertama, cari dulu emp_no karyawan yang memiliki title 'Senior Engineer'
# ini akan dimasukkan sebagai subquery
SELECT emp_no
FROM titles
WHERE title = "Senior Engineer"
;

# Menampilan nama karyawan, difiltering yang emp_no nya terdapat dalam subquery di atas
SELECT * 
FROM employees
WHERE emp_no IN (SELECT emp_no
				 FROM titles
                 WHERE title = "Senior Engineer")
;


# LATIHAN
# Tampilkan nama employees yang memiliki gaji di atas $153.000 

SELECT * FROM employees;
SELECT * FROM salaries;

# emp_no yang gajinya di atas $153k
SELECT emp_no
FROM salaries
WHERE salary>153000;

# query di atas dijadikan sebagai subquery untuk filtering 
SELECT *
FROM employees
WHERE emp_no IN (SELECT emp_no
				 FROM salaries
				 WHERE salary>153000)
;


SELECT emp_no, first_name, last_name
FROM employees
WHERE emp_no IN (SELECT emp_no 
				 FROM salaries
                 WHERE salary > 60000)
;


# =======================================================================================
# RELATIONAL MODEL CONSTRAINS

# Referencing --> menghubungkan antar beberapa table pada RDBMS (Relational Data Base Management System)
# Primary key --> Identas unik yang dimiliki oleh sebuah table (emp_no, student_id, country_ID)
#			  --> tidak boleh duplikat
# Foreign key --> Primary key yang ditampilkan di table lain

# Parent table    --> table yang punya primary key
# Dependent table --> table yang punya foreign key



# =======================================================================================
# JOIN TABLE

# JOIN clause digunakan untuk menkombinasikan data dari dua table atau lebih
# berdasarkan kolom tertentu yang dimiliki oleh table-table yang digunakan (ON)


# =======================================================================================
# INNER JOIN 
# digunakan untuk menggambungakn 2 table atau lebih dan menampilkan data yang dimiliki oleh kedua table

# Syntax
# SELECT table_kiri.nama_kolom1, table_kanan.nama_kolom2
# FROM table_kiri
# JOIN table_kanan
# ON table_kiri.key_column = table_kanan.key_column

SELECT * FROM employees;
SELECT * FROM salaries;

# Menggabungkan table employees dan table salaries menggunakan JOIN clause dan ON clause
SELECT employees.emp_no, employees.first_name, employees.last_name, salaries.salary, salaries.from_date
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
;

# Nama table bisa diberi alias agar penulisannya tidak terlalu panjang
SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no;


# Menampilkan nama karyawan dengan gaji di atas $153k 
SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date
FROM employees AS e
JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE salary>153000
;


# JOIN defaultnya adalah INNER JOIN 
SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date
FROM employees AS e
INNER JOIN salaries AS s
ON e.emp_no = s.emp_no
WHERE salary>153000
;


# JOIN 3 table
SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date, t.title
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
JOIN titles AS t ON e.emp_no = t.emp_no
;


# JOIN 3 table
SELECT e.emp_no, e.first_name, e.last_name, s.salary, s.from_date, t.title
FROM employees AS e
JOIN salaries AS s ON e.emp_no = s.emp_no
JOIN titles AS t ON e.emp_no = t.emp_no
WHERE s.salary > 153000 
;


# =======================================================================================
# IMPLICITE JOIN
# Menggabungkan 2 table atau lebih tanpa menuliskan JOIN clause
# Implicite Join dilakukan pada WHERE clause
# FROM nya mengandung 2 table atau lebih
# Running lebih lambat


SELECT *
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no
;

SELECT *
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no
AND salary>153000
;

SELECT 
	s.emp_no, 
    e.first_name, 
    e.last_name, 
    s.salary, 
    s.from_date
FROM 
	employees as e, 
    salaries as s
WHERE 
	e.emp_no = s.emp_no
AND 
	salary>153000
;


SELECT 
	s.emp_no, 
    e.first_name, 
    e.last_name, 
    s.salary, 
    s.from_date,
    t.title
FROM 
	employees as e, 
    salaries as s,
    titles as t
WHERE 
	e.emp_no = s.emp_no
AND
	e.emp_no = t.emp_no
AND 
	salary>153000
;




# =======================================================================================
# LEFT JOIN

# Saat melakukan join, ada table yang disebeutkan pertama (setelah FROM), dan table yang disebutkan kedua
# Table yang disebutkan pertama berperan sebagai table Left
# Dengan melakukan LEFT JOIN, data yang ditampilkan mengikuti table LEFT
# Jadi jika ada data yang dimiliki oleh table LEFT tapi tidak dimiliki pada table RIGHT, maka akan tetap ditampilkan


# title akan Null jika seorang karyawan tidak punya title
# tapi semua nama karyawan akan ditampilkan
SELECT *
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
;



# =======================================================================================
# RIGHT JOIN
# kebalikan dari LEFT JOIN

# nama karyawan akan Null jika sebuah title tidak ada karyawannya
# tapi semua title akan ditampilkan
SELECT *
FROM employees as e
RIGHT JOIN titles as t
ON t.emp_no = e.emp_no
;
