CREATE DATABASE IF NOT EXISTS example_db;

USE example_db;

CREATE TABLE IF NOT EXISTS example_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    status BOOLEAN
);

INSERT INTO example_table (name, status) VALUES ('Asim', false);
INSERT INTO example_table (name, status) VALUES ('Dina', false);
INSERT INTO example_table (name, status) VALUES ('Jawad', true);
INSERT INTO example_table (name, status) VALUES ('Bilal', false);
