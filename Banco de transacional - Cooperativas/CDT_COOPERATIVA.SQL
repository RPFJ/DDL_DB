CREATE TABLE IF NOT EXISTS CDT_COOPERATIVA (
  idCooperativa INT NOT NULL,
  nome VARCHAR(100) NULL,
  endereco VARCHAR(500) NULL,
  cidade VARCHAR(100) NULL,
  latitude FLOAT NULL,
  longitude FLOAT NULL,
  login VARCHAR(50) NULL,
  senha VARCHAR(8) NULL,
  sigla VARCHAR(20) NULL,
  ano_inicio INT NULL,
  id_area_atuacao INT NULL,
  id_localizacao INT NULL,
  id_tipo_organizacao INT NULL,
  dt_cadastro DATE NULL,
  PRIMARY KEY (idCooperativa),
  CONSTRAINT fk_cooperativa_tp_organizacao
    FOREIGN KEY (id_tipo_organizacao)
    REFERENCES CDT_TP_ORGANIZACAO (idTipoOrganizacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cooperativa_contato
    FOREIGN KEY (id_localizacao)
    REFERENCES CDT_LOCALIZACAO (idLocalizacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_cooperativa_area_atuacao
    FOREIGN KEY (id_area_atuacao)
    REFERENCES CDT_AREA_ATUACAO (idAreaAtuacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);