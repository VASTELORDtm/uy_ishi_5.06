CREATE DATABASE people_db;
USE people_db;
CREATE TABLE employees (
                           id INTEGER PRIMARY KEY,
                           first_name VARCHAR(50),
                           last_name VARCHAR(50),
                           age INTEGER,
                           salary DECIMAL(10, 2)
);

INSERT INTO employees (id, first_name, last_name, age, salary)
VALUES
    (1, 'Ali', 'Valiyev', 30, 1500.00),
    (2, 'Dilnoza', 'Akbarova', 25, 2000.00),
    (3, 'Jasur', 'Qosimov', 40, 2500.00);


CREATE TABLE departments (
                             id INTEGER PRIMARY KEY,
                             name VARCHAR(100),
                             location VARCHAR(50)
);

INSERT INTO departments (id, name, location)
VALUES  (1, 'IT', 'Tashkent'),
        (2, 'HR', 'Samarqand');

ALTER TABLE employees
    ADD COLUMN department_id INTEGER;

UPDATE employees
SET department_id = CASE
                        WHEN employees.first_name = 'Ali Valiev' THEN 1
                        WHEN employees.first_name = 'Dilnoza Akbarova' THEN 2
                        WHEN employees.first_name = 'Jasur Qosimov' THEN 1
    END
WHERE employees.first_name IN ('Ali Valiev', 'Dilnoza Akbarova', 'Jasur Qosimov');

SELECT
    e.first_name,
    e.last_name,
    d.name AS department_name
FROM
    employees e
        INNER JOIN
    departments d ON e.department_id = d.id;

CREATE TABLE positions (
                           id INTEGER PRIMARY KEY,
                           title VARCHAR(100),
                           salary DECIMAL(10, 2)
);
INSERT INTO positions (id, title, salary)
VALUES
    (1, 'Developer', 3000.00),
    (2, 'HR Manager', 4000.00);
ALTER TABLE employees ADD position_id INTEGER;

UPDATE employees SET position_id = 1 WHERE first_name = 'Ali' AND last_name = 'Valiyev';
UPDATE employees SET position_id = 2 WHERE first_name = 'Dilnoza' AND last_name = 'Akbarova';

SELECT e.first_name, e.last_name, d.name AS department_name, p.title AS position_title
FROM employees e
         LEFT JOIN departments d ON e.department_id = d.id
         LEFT JOIN positions p ON e.position_id = p.id;

SELECT
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_salary
FROM employees;

DELETE FROM employees;
DROP TABLE positions;

CREATE DATABASE shop_db;

USE shop_db;

CREATE TABLE products (
                          id INTEGER PRIMARY KEY,
                          name VARCHAR(100),
                          price DECIMAL(10, 2),
                          category VARCHAR(50)
);

INSERT INTO products (id, name, price, category) VALUES
                                                     (1, 'Laptop', 1500.00, 'Electronics'),
                                                     (2, 'Smartphone', 1000.00, 'Electronics'),
                                                     (3, 'Chair', 200.00, 'Furniture');

CREATE TABLE customers (
                           id INTEGER PRIMARY KEY,
                           first_name VARCHAR(50),
                           last_name VARCHAR(50)
);

INSERT INTO customers (id, first_name, last_name) VALUES
                                                      (1, 'Ali', 'Valiyev'),
                                                      (2, 'Jasur', 'Qosimov');

ALTER TABLE products ADD stock_quantity INTEGER;

UPDATE products SET stock_quantity = 10 WHERE name = 'Laptop';
UPDATE products SET stock_quantity = 20 WHERE name = 'Smartphone';
UPDATE products SET stock_quantity = 15 WHERE name = 'Chair';

CREATE TABLE orders (
                        id INTEGER PRIMARY KEY,
                        customer_id INTEGER,
                        product_id INTEGER,
                        quantity INTEGER
);

INSERT INTO orders (id, customer_id, product_id, quantity) VALUES
(1, 1, 1, 2),
(2, 2, 3, 4);

SELECT o.id, c.first_name, c.last_name, p.name AS product_name, o.quantity
FROM orders o
         INNER JOIN customers c ON o.customer_id = c.id
         INNER JOIN products p ON o.product_id = p.id;

SELECT p.name AS product_name, COUNT(o.id) AS order_count
FROM products p
         LEFT JOIN orders o ON p.id = o.product_id
GROUP BY p.id;

SELECT c.first_name, c.last_name, SUM(p.price * o.quantity) AS total_spent
FROM customers c
         INNER JOIN orders o ON c.id = o.customer_id
         INNER JOIN products p ON o.product_id = p.id
GROUP BY c.id;

DELETE FROM orders;
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE name = 'Laptop';

DROP TABLE orders;

CREATE DATABASE university_db;

USE university_db;

CREATE TABLE students (
                          id INTEGER PRIMARY KEY,
                          first_name VARCHAR(50),
                          last_name VARCHAR(50),
                          age INTEGER
);


INSERT INTO students (id, first_name, last_name, age) VALUES
                                                          (1, 'Jasur', 'Qosimov', 20),
                                                          (2, 'Ali', 'Valiyev', 22);

CREATE TABLE courses (
                         id INTEGER PRIMARY KEY,
                         name VARCHAR(100),
                         credit INTEGER
);

INSERT INTO courses (id, name, credit) VALUES
                                           (1, 'Mathematics', 5),
                                           (2, 'Physics', 4);

CREATE TABLE enrollments (
                             student_id INTEGER,
                             course_id INTEGER
);

INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1),
(2, 2);

SELECT s.first_name, s.last_name, c.name AS course_name
FROM students s
         INNER JOIN enrollments e ON s.id = e.student_id
         INNER JOIN courses c ON e.course_id = c.id;
SELECT c.name AS course_name, COUNT(e.student_id) AS student_count
FROM courses c
         LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id;

ALTER TABLE students ADD email VARCHAR(100);

UPDATE students SET email = 'jasurq@example.com' WHERE first_name = 'Jasur' AND last_name = 'Qosimov';
UPDATE students SET email = 'aliv@example.com' WHERE first_name = 'Ali' AND last_name = 'Valiyev';

SELECT s.first_name, s.last_name, SUM(c.credit) AS total_credits
FROM students s
         INNER JOIN enrollments e ON s.id = e.student_id
         INNER JOIN courses c ON e.course_id = c.id
GROUP BY s.id;

SELECT AVG(credit) AS average_credit FROM courses;

DROP TABLE courses;


