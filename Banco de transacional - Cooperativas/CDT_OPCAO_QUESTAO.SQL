CREATE TABLE IF NOT EXISTS CDT_OPCAO_QUESTAO (
  idopcao INT NOT NULL,
  desc_opcao TEXT NULL,
  id_questao INT NULL,
  PRIMARY KEY (idopcao),
  CONSTRAINT fk_opcao_questao_questao
    FOREIGN KEY (id_questao)
    REFERENCES CDT_QUESTAO (idQuestao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);