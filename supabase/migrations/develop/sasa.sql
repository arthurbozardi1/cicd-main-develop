CREATE TABLE dasdas (
    id SERIAL PRIMARY KEY,
    log VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending'
);