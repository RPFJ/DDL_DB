CREATE TABLE IF NOT EXISTS formacao_coletiva_cooperativa (
  id_formacao_coletiva INT NOT NULL,
  id_cooperativa INT NOT NULL,
  PRIMARY KEY (id_formacao_coletiva, id_cooperativa),
  CONSTRAINT fk_Formacao_coletiva_has_Cooperativa_Formacao_coletiva1
    FOREIGN KEY (id_formacao_coletiva)
    REFERENCES CDT_FORMACAO_COLETIVA (idFormacao_coletiva)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Formacao_coletiva_has_Cooperativa_Cooperativa1
    FOREIGN KEY (id_cooperativa)
    REFERENCES CDT_COOPERATIVA (idCooperativa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);