-- Crear tabla de hechos e insertar datos
CREATE TABLE IF NOT EXISTS customer_transactions (customer_id int, store_id int, spent numeric);

INSERT INTO customer_transactions (customer_id, store_id, spent) VALUES (1, 1, 20.50);

INSERT INTO customer_transactions (customer_id, store_id, spent) VALUES (2, 1, 35.21);

-- Crear tabla de dimensiones
CREATE TABLE IF NOT EXISTS items_purchased (customer_id int, item_number int, item_name varchar);

INSERT INTO items_purchased (customer_id, item_number, item_name) VALUES (1, 1, 'Rubber Soul');

INSERT INTO items_purchased (customer_id, item_number, item_name) VALUES (2, 3, 'Let It Be');

CREATE TABLE IF NOT EXISTS store (store_id int, state varchar);

INSERT INTO store (store_id, state) VALUES (1, 'CA');

INSERT INTO store (store_id, state) VALUES (2, 'WA');

CREATE TABLE IF NOT EXISTS customer (customer_id int, name varchar, rewards boolean);

INSERT INTO customer (customer_id, name, rewards) VALUES (1, 'Amanda', True);

INSERT INTO customer (customer_id, name, rewards) VALUES (2, 'Toby', False);

-- Consultas a realizar
/*
Consulta 1: Encontrar todos los clientes que gastaron mas de 30 dolares, quienes son, en que tienda compraron, locación de la tienda, que comprar y si son miembros rewards.
Consulta 2: Cuanto gastó el cliente 'Customer 2'?
*/

SELECT name, store.store_id, store.state, item_name, customer.rewards,
FROM (((customer_transactions
JOIN customer ON customer.customer_id=customer_transactions.customer_id)
JOIN store ON
customer_transactions.store_id=store.store_id)
JOIN items_purchased ON
customer_transactions.customer_id=items_purchased.customer_id)
WHERE spent > 30;

SELECT customer_id, SUM(spent) FROM customer_transactions WHERE customer_id = 2 GROUP BY customer_id;