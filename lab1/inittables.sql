CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    path_to_file TEXT,
    description TEXT,
    is_active BOOLEAN NOT NULL,
    data_product_create TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE price_change (
    change_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES product(product_id),
    date_price_change TIMESTAMP NOT NULL DEFAULT now(),
    new_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE user_service (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES user_service(user_id),
    payment_date TIMESTAMP NOT NULL DEFAULT now(),
    amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE purchase (
    purchase_id SERIAL PRIMARY KEY,
    purchase_date TIMESTAMP NOT NULL DEFAULT now(),
    customer_id INTEGER REFERENCES user_service(user_id),
    product_id INTEGER REFERENCES product(product_id),
    product_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    parent_category INTEGER REFERENCES category(category_id),
    category_name VARCHAR(255) NOT NULL
);

CREATE TABLE product_category (
    product_id INTEGER REFERENCES product(product_id),
    category_id INTEGER REFERENCES category(category_id),
    PRIMARY KEY (product_id, category_id)
);