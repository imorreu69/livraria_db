CREATE DATABASE IF NOT EXISTS biblioteca_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE biblioteca_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS movimentacaos;
DROP TABLE IF EXISTS livros;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Usuarios;
DROP TABLE IF EXISTS usuarios;

SET FOREIGN_KEY_CHECKS = 1;

-- =========================================
-- TABELA: Clientes
-- =========================================

CREATE TABLE Clientes (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(255) NOT NULL,
    modeloVeiculo VARCHAR(255) NOT NULL,
    placa VARCHAR(255) NOT NULL,
    anoVeiculo INT NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NOT NULL,

    PRIMARY KEY (id),
    UNIQUE KEY email (email),
    UNIQUE KEY placa (placa)
) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


-- =========================================
-- TABELA: Usuarios
-- =========================================

CREATE TABLE Usuarios (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('operador', 'administrador') NOT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NOT NULL,

    PRIMARY KEY (id),
    UNIQUE KEY email (email)
) ENGINE=InnoDB
  AUTO_INCREMENT=5
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


-- =========================================
-- DADOS: Usuarios
-- =========================================

INSERT INTO Usuarios
    (id, nome, email, senha, tipo, createdAt, updatedAt)
VALUES
    (
        1,
        'Aluno Teste',
        'teste@email.com',
        '$2b$10$SeHxt/ONd059wbMkC4.kWu5h1dPi6q6Jvg7cTGNaUA1NUTI5ZNJN.',
        'administrador',
        '2026-09-28 23:26:44',
        '2026-09-28 23:26:44'
    ),
    (
        4,
        'Operador Modulo 5',
        'operador.m5@example.com',
        '$2b$10$H2uvEUURvAqFVMhx0Dy7f.l6dh..TJxq3co9Q/yJctMsM41KfJE2S',
        'operador',
        '2026-09-28 23:56:12',
        '2026-09-28 23:56:12'
    );


-- =========================================
-- TABELA: livros
-- =========================================

CREATE TABLE livros (
    id INT NOT NULL AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NOT NULL,

    PRIMARY KEY (id)
) ENGINE=InnoDB
  AUTO_INCREMENT=5
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


-- =========================================
-- DADOS: livros
-- =========================================

INSERT INTO livros
    (id, titulo, autor, quantidade_estoque, createdAt, updatedAt)
VALUES
    (
        1,
        'Dom Casmurro',
        'Machado de Assis',
        10,
        '2026-09-28 23:44:46',
        '2026-09-28 23:44:46'
    ),
    (
        2,
        'Teste Modulo 4',
        'Autor Teste',
        12,
        '2026-09-28 23:52:29',
        '2026-09-28 23:52:29'
    ),
    (
        3,
        'Teste Estoque Final 2',
        'Autor Teste',
        12,
        '2026-09-28 23:53:41',
        '2026-09-28 23:53:41'
    );


-- =========================================
-- TABELA: movimentacaos
-- =========================================

CREATE TABLE movimentacaos (
    id INT NOT NULL AUTO_INCREMENT,
    tipo ENUM('entrada', 'saida') NOT NULL,
    quantidade INT NOT NULL,
    data DATETIME DEFAULT NULL,
    createdAt DATETIME NOT NULL,
    updatedAt DATETIME NOT NULL,
    livro_id INT DEFAULT NULL,
    usuario_id INT DEFAULT NULL,

    PRIMARY KEY (id),

    KEY livro_id (livro_id),
    KEY movimentacaos_usuario_id_idx (usuario_id),

    CONSTRAINT movimentacaos_livro_fk
        FOREIGN KEY (livro_id)
        REFERENCES livros (id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    CONSTRAINT movimentacaos_usuario_fk
        FOREIGN KEY (usuario_id)
        REFERENCES Usuarios (id)
        ON DELETE SET NULL
        ON UPDATE CASCADE

) ENGINE=InnoDB
  AUTO_INCREMENT=6
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_0900_ai_ci;


-- =========================================
-- DADOS: movimentacaos
-- =========================================

INSERT INTO movimentacaos
    (
        id,
        tipo,
        quantidade,
        data,
        createdAt,
        updatedAt,
        livro_id,
        usuario_id
    )
VALUES
    (
        5,
        'entrada',
        2,
        '2026-09-28 23:56:18',
        '2026-09-28 23:56:18',
        '2026-09-28 23:56:18',
        NULL,
        4
    );


-- =========================================
-- FINALIZAÇÃO
-- =========================================

SET FOREIGN_KEY_CHECKS = 1;
