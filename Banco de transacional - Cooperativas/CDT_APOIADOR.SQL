CREATE TABLE IF NOT EXISTS CDT_APOIADOR (
  idApoiador INT NOT NULL,
  nome VARCHAR(100) NULL,
  cidade VARCHAR(100) NULL,
  tipo_de_ajuda VARCHAR(100) NULL,
  dt_cadastro DATE NULL,
  PRIMARY KEY (idApoiador)
);