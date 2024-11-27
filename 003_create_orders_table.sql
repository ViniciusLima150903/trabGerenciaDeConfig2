-- Criando tabela de pedidos
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(id),
    product_id INT NOT NULL REFERENCES products(id),
    quantity INT NOT NULL,
    order_date TIMESTAMP DEFAULT NOW()
);