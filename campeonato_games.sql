-- Criando o banco de dados
CREATE DATABASE CampeonatoGames;
\c CampeonatoGames;

-- Tabela Jogador: Armazena os jogadores
CREATE TABLE Jogador (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nickname VARCHAR(50) UNIQUE NOT NULL
);

-- Tabela Jogo: Armazena os jogos disponíveis no campeonato
CREATE TABLE Jogo (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    plataforma VARCHAR(50)
);

-- Tabela Campeonato: Define os campeonatos
CREATE TABLE Campeonato (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL
);

-- Tabela Partida: Armazena as partidas jogadas em cada campeonato
CREATE TABLE Partida (
    id SERIAL PRIMARY KEY,
    id_campeonato INT REFERENCES Campeonato(id) ON DELETE CASCADE,
    id_jogo INT REFERENCES Jogo(id) ON DELETE CASCADE,
    data_partida DATE NOT NULL
);

-- Tabela Pontuacao: Registra as pontuações de cada jogador em cada partida
CREATE TABLE Pontuacao (
    id SERIAL PRIMARY KEY,
    id_partida INT REFERENCES Partida(id) ON DELETE CASCADE,
    id_jogador INT REFERENCES Jogador(id) ON DELETE CASCADE,
    pontos INT NOT NULL,
    UNIQUE(id_partida, id_jogador) -- Evita que o mesmo jogador registre mais de uma pontuação na mesma partida
);

-- Inserindo dados de exemplo

-- Jogadores
INSERT INTO Jogador (nome, nickname) VALUES ('João da Silva', 'JMaster');
INSERT INTO Jogador (nome, nickname) VALUES ('Pedro Alves', 'PRed');
INSERT INTO Jogador (nome, nickname) VALUES ('Lucas Lima', 'LStorm');

-- Jogos
INSERT INTO Jogo (nome, plataforma) VALUES ('Gran Turismo 7', 'PS5');
INSERT INTO Jogo (nome, plataforma) VALUES ('Forza Horizon 5', 'PC');
INSERT INTO Jogo (nome, plataforma) VALUES ('Battlefield 4', 'PC');

-- Campeonatos
INSERT INTO Campeonato (nome, data_inicio, data_fim) VALUES ('Campeonato RS', '2024-10-01', '2024-10-10');
INSERT INTO Campeonato (nome, data_inicio, data_fim) VALUES ('Campeonato Nacional', '2024-10-15', '2024-10-25');

-- Partidas
INSERT INTO Partida (id_campeonato, id_jogo, data_partida) VALUES (1, 1, '2024-10-02');
INSERT INTO Partida (id_campeonato, id_jogo, data_partida) VALUES (1, 2, '2024-10-03');
INSERT INTO Partida (id_campeonato, id_jogo, data_partida) VALUES (2, 3, '2024-10-16');

-- Pontuações
INSERT INTO Pontuacao (id_partida, id_jogador, pontos) VALUES (1, 1, 15); -- João na partida 1
INSERT INTO Pontuacao (id_partida, id_jogador, pontos) VALUES (1, 2, 10); -- Pedro na partida 1
INSERT INTO Pontuacao (id_partida, id_jogador, pontos) VALUES (2, 3, 20); -- Lucas na partida 2
