-- Criar a tabela 'usuarios'
CREATE TABLE IF NOT EXISTS usuarios (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL
);

CREATE INDEX IF NOT EXISTS idx_usuarios_nome ON usuarios (nome);