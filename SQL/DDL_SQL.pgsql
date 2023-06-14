--SQL POSTGRES  
--Genera un modelo de datos con las tablas customer, orders, orders_detail, product, utilizando fireign keys 

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    zip_code VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(50) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders_detail (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

--- crea la tabla category [description, status, updated_at, created_at] y product_category con las foreign keys keys necesarias 

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    description VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    updated_at DATE NOT NULL,
    created_at DATE NOT NULL
);

CREATE TABLE product_category (
    product_category_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

-- crea una copia de la tabla product_category con el nombre product_category_backup

CREATE TABLE product_category_backup AS TABLE product_category;

-- elimina la tabla product_category_backup 

DROP TABLE product_category_backup;