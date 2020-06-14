CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_localizacao` (
  `idLocalizacao` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_localizacao` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idLocalizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;