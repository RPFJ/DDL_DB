CREATE TABLE IF NOT EXISTS `empreendimentos`.`rede_economica_apoiador` (
  `id_rede_economica` INT NOT NULL,
  `id_apoiador` INT NOT NULL,
  PRIMARY KEY (`id_rede_economica`, `id_apoiador`),
  INDEX `fk_rede_economica_apoiador_apoiador_idx` (`id_apoiador` ASC) VISIBLE,
  CONSTRAINT `fk_rede_economica_apoiador_r_economica`
    FOREIGN KEY (`id_rede_economica`)
    REFERENCES `empreendimentos`.`cdt_rede_economica` (`idRede_economica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rede_economica_apoiador_apoiador`
    FOREIGN KEY (`id_apoiador`)
    REFERENCES `empreendimentos`.`cdt_apoiador` (`idApoiador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;