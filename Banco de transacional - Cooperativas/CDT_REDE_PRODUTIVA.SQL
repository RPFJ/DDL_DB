CREATE TABLE IF NOT EXISTS CDT_REDE_PRODUTIVA (
  idRede_produtiva INT NOT NULL,
  desc_rede VARCHAR(100) NULL,
  latitude FLOAT NULL,
  longitude FLOAT NULL,
  id_tipo_rede INT NULL,
  PRIMARY KEY (idRede_produtiva),
  CONSTRAINT fk_rede_produtiva_1
    FOREIGN KEY (id_tipo_rede)
    REFERENCES CDT_TP_REDE (idtipo_rede)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);