CREATE TABLE IF NOT EXISTS CDT_ATIVIDADE_COOPERATIVA (
  id_atividade INT NOT NULL,
  desc_atividade INT NULL,
  PRIMARY KEY (id_atividade),
  CONSTRAINT fk_Atividade_has_Cooperativa_Cooperativa1
    FOREIGN KEY (desc_atividade)
    REFERENCES CDT_COOPERATIVA (idCooperativa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);