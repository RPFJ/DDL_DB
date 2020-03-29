CREATE TABLE IF NOT EXISTS REDE_PRODUTIVA_APOIADOR (
  id_rede_produtiva INT NOT NULL,
  id_apoiador INT NULL,
  PRIMARY KEY (id_rede_produtiva),
  CONSTRAINT fK_rede_produtiva
    FOREIGN KEY (id_rede_produtiva)
    REFERENCES CDT_REDE_PRODUTIVA (idRede_produtiva)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_apoiador
    FOREIGN KEY (id_apoiador)
    REFERENCES CDT_APOIADOR (idApoiador)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);