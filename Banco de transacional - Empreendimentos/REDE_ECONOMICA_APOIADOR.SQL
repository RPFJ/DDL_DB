CREATE TABLE IF NOT EXISTS `empreendimentos`.`rede_economica_apoiador` (
  `id_rede_economica` INT(11) NOT NULL,
  `id_apoiador` INT(11) NOT NULL,
  PRIMARY KEY (`id_rede_economica`, `id_apoiador`),
  INDEX `fk_rede_economica_apoiador_apoiador_idx` (`id_apoiador` ASC) VISIBLE,
  CONSTRAINT `fk_rede_economica_apoiador_apoiador`
    FOREIGN KEY (`id_apoiador`)
    REFERENCES `empreendimentos`.`cdt_apoiador` (`idApoiador`),
  CONSTRAINT `fk_rede_economica_apoiador_r_economica`
    FOREIGN KEY (`id_rede_economica`)
    REFERENCES `empreendimentos`.`cdt_rede_economica` (`idRede_economica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;