CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_area_atuacao` (
  `idAreaAtuacao` INT NOT NULL AUTO_INCREMENT,
  `desc_area_atuacao` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idAreaAtuacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;