CREATE TABLE IF NOT EXISTS CDT_CONTATO (
  idContato INT NOT NULL,
  nome VARCHAR(100) NULL,
  id_tipo_contato INT NULL,
  desc_contato VARCHAR(100) NULL,
  id_cooperativa INT NULL,
  PRIMARY KEY (idContato),
  CONSTRAINT fk_contato_cooperativa
    FOREIGN KEY (id_cooperativa)
    REFERENCES CDT_COOPERATIVA (idCooperativa)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_contato_tp_contato
    FOREIGN KEY (id_tipo_contato)
    REFERENCES CDT_TP_CONTATO (idtipo_contato)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);