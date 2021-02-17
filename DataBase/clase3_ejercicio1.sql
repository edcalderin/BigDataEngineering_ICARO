--- Tabla de ejemplo
CREATE TABLE IF NOT EXISTS music_store (transaction_id int,customer_name varchar, cashier_name varchar, year int, albums_purchased text[]);

INSERT INTO music_store (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (1, 'Amanda', 'Sam', 2000, array['Rubber Soul', 'Let it Be'])

INSERT INTO music_store (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (2, 'Toby', 'Sam', 2000, array['My Generation']);

INSERT INTO music_store (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (3, 'Max', 'Bob', 2018, array['Meet the Beatles', 'Help!']);

SELECT * FROM music_store;

-- Tabla normalizada en primera forma
/*
Para tener la información en su primera forma normal, tenemos que remover cualquier arreglo o array de la lista.
Necesitamos separar los registros con multiples valores en registros individuales.
*/
CREATE TABLE IF NOT EXISTS music_store2 (transaction_id int, customer_name varchar, cashier_name varchar, year int, albums_purchased text);

INSERT INTO music_store2 (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (1, 'Amanda', 'Sam', 2000, 'Rubber Soul');

INSERT INTO music_store2 (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (1, 'Amanda', 'Sam', 2000, 'Let it Be');

INSERT INTO music_store2 (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (2, 'Toby', 'Sam', 2000, 'My Generation');

INSERT INTO music_store2 (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (3, 'Max', 'Bob', 2018, 'Help!');

INSERT INTO music_store2 (transaction_id, customer_name, cashier_name, year, albums_purchased) VALUES (3, 'Max', 'Bob', 2018, 'Meet the Beatles');

SELECT * FROM music_store2;

-- Tabla normalizada en segunda forma
/*
Mientras cada uno de nuestros registros es único en la tabla, la clave primaria no lo es.
Necesitamos separar esto en 2 tablas, la tabla de transacciones y la tabla de álbums vendidos.
*/
CREATE TABLE IF NOT EXISTS transactions (transaction_id int, customer_name varchar, cashier_name varchar, year int);

CREATE TABLE IF NOT EXISTS albums_sold (album_id int, transaction_id int, album_name varchar);

INSERT INTO transactions (transaction_id, customer_name, cashier_name, year) VALUES (1, 'Amanda', 'Sam', 2000);

INSERT INTO transactions (transaction_id, customer_name, cashier_name, year) VALUES (2, 'Toby', 'Sam', 2000);

INSERT INTO transactions (transaction_id, customer_name, cashier_name, year) VALUES (3, 'Max', 'Bob', 2018);

INSERT INTO albums_sold (album_id, transaction_id, album_name) VALUES (1, 1, 'Rubber Soul');

INSERT INTO albums_sold (album_id, transaction_id, album_name) VALUES (2, 1, 'Let it Be');

INSERT INTO albums_sold (album_id, transaction_id, album_name) VALUES(3, 2, 'My Generation');

INSERT INTO albums_sold (album_id, transaction_id, album_name) VALUES (4, 3, 'Meet the Beatles');

INSERT INTO albums_sold (album_id, transaction_id, album_name) VALUES (5, 3, 'Help!');

SELECT * FROM transactions;

SELECT * FROM albums_sold;

SELECT * FROM transactions JOIN albums_sold ON transactions.transaction_id = albums_sold.transaction_id;

-- Tabla normalizada en tercera forma
/*
Para completar la última de las formas de normalizacion, debemos sacar de transactions el campo cashier_name y ubicarlo en su propia tabla, Empleados.
Esto nos va a dejar con 3 tablas.
*/
CREATE TABLE IF NOT EXISTS transactions2 (transaction_id int, customer_name varchar, cashier_id int, year int);

CREATE TABLE IF NOT EXISTS employees (employee_id int, employee_name varchar);

INSERT INTO transactions2 (transaction_id, customer_name, cashier_id, year) VALUES (1, 'Amanda', 1, 2000);

INSERT INTO transactions2 (transaction_id, customer_name, cashier_id, year) VALUES (2, 'Toby', 1, 2000);

INSERT INTO transactions2 (transaction_id, customer_name, cashier_id, year) VALUES (3, 'Max', 2, 2018);

INSERT INTO employees (employee_id, employee_name) VALUES (1, 'Sam');

INSERT INTO employees (employee_id, employee_name) VALUES (2, 'Bob');

SELECT * FROM transactions2;

SELECT * FROM albums_sold;

SELECT * FROM employees;

SELECT *
FROM (transactions2 JOIN albums_sold ON transactions2.transaction_id = albums_sold.transaction_id) 
JOIN employees ON transactions2.cashier_id=employees.employee_id;