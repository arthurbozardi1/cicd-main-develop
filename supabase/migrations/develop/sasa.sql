-- Criação da tabela 'log'

CREATE TABLE aaaa (
    id SERIAL PRIMARY KEY,
    log VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
);