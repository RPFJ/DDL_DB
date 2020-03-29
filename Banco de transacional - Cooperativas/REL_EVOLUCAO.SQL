CREATE TABLE IF NOT EXISTS REL_EVOLUCAO (
  idEvolucao INT NOT NULL,
  data DATE NULL,
  geracao_renda FLOAT NULL,
  n_homens INT NULL,
  n_mulheres INT NULL,
  computador TINYINT(1) NULL,
  internet TINYINT(1) NULL,
  id_cooperativa INT NULL,
  id_rede_produtiva INT NULL,
  PRIMARY KEY (idEvolucao),
  CONSTRAINT fk_evolucao_cooperativa
    FOREIGN KEY (id_cooperativa)
    REFERENCES CDT_COOPERATIVA (idCooperativa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_evolucao_rede_produtiva
    FOREIGN KEY (id_rede_produtiva)
    REFERENCES CDT_REDE_PRODUTIVA (idRede_produtiva)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);