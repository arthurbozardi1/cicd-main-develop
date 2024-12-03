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
    ('João Silva', 'joao@exemplo.com'),
    ('Maria Oliveira', 'maria@exemplo.com'),
    ('Carlos Souza', 'carlos@exemplo.com'),
    ('Ana Pereira', 'ana@exemplo.com'),
    ('Pedro Lima', 'pedro@exemplo.com');

-- Registrando as inserções na tabela de logs
INSERT INTO logs (action, table_name, record_id, description)
VALUES
    ('INSERT', 'usuarios', 1, 'Usuário João Silva adicionado'),
    ('INSERT', 'usuarios', 2, 'Usuário Maria Oliveira adicionado'),
    ('INSERT', 'usuarios', 3, 'Usuário Carlos Souza adicionado'),
    ('INSERT', 'usuarios', 4, 'Usuário Ana Pereira adicionado'),
    ('INSERT', 'usuarios', 5, 'Usuário Pedro Lima adicionado');


-- Excluindo um usuário
DELETE FROM usuarios
WHERE id = 3;

-- Registrando a exclusão na tabela de logs
INSERT INTO logs (action, table_name, record_id, description)
VALUES ('DELETE', 'usuarios', 3, 'Usuário Carlos Souza excluído');
