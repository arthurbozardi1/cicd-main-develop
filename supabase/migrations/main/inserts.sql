-- Criação da tabela de logs
-- CREATE TABLE logs (
--     id SERIAL PRIMARY KEY,
--     action VARCHAR(50) NOT NULL,
--     table_name VARCHAR(50) NOT NULL,
--     record_id INT NOT NULL,
--     action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     description TEXT
-- );

-- Criação da tabela de usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserindo usuários e registrando na tabela de logs
INSERT INTO usuarios (nome, email)
VALUES
    ('Lucas Martins', 'lucas@exemplo.com'),
    ('Juliana Costa', 'juliana@exemplo.com'),
    ('Rafael Oliveira', 'rafael@exemplo.com'),
    ('Bianca Souza', 'bianca@exemplo.com'),
    ('Felipe Gomes', 'felipe@exemplo.com');

-- Registrando as inserções na tabela de logs
INSERT INTO logs (action, table_name, record_id, description)
VALUES
    ('INSERT', 'usuarios', 1, 'Usuário Lucas Martins adicionado'),
    ('INSERT', 'usuarios', 2, 'Usuário Juliana Costa adicionado'),
    ('INSERT', 'usuarios', 3, 'Usuário Rafael Oliveira adicionado'),
    ('INSERT', 'usuarios', 4, 'Usuário Bianca Souza adicionado'),
    ('INSERT', 'usuarios', 5, 'Usuário Felipe Gomes adicionado');

-- Excluindo um usuário
DELETE FROM usuarios
WHERE id = 3;

-- Registrando a exclusão na tabela de logs
INSERT INTO logs (action, table_name, record_id, description)
VALUES ('DELETE', 'usuarios', 3, 'Usuário Rafael Oliveira excluído');
