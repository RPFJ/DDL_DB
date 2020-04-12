CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_rede_economica` (
  `idRede_economica` INT NOT NULL AUTO_INCREMENT,
  `desc_rede` VARCHAR(100) NULL DEFAULT NULL,
  `latitude` FLOAT NULL DEFAULT NULL,
  `longitude` FLOAT NULL DEFAULT NULL,
  `id_tipo_rede` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idRede_economica`),
  INDEX `fk_rede_economica_1` (`id_tipo_rede` ASC) VISIBLE,
  CONSTRAINT `fk_rede_economica_1`
    FOREIGN KEY (`id_tipo_rede`)
    REFERENCES `empreendimentos`.`cdt_tp_rede` (`idtipo_rede`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;