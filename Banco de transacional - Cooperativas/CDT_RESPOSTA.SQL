CREATE TABLE IF NOT EXISTS CDT_RESPOSTA (
  idResposta INT NOT NULL,
  desc_resposta VARCHAR(500) NULL,
  id_questao INT NULL,
  id_evolucao INT NULL,
  PRIMARY KEY (idResposta),
  CONSTRAINT fk_respostas_evolucao
    FOREIGN KEY (id_evolucao)
    REFERENCES REL_EVOLUCAO (idEvolucao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_resposta_questao
    FOREIGN KEY (id_questao)
    REFERENCES CDT_QUESTAO (idQuestao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);