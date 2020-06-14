CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_formacao_coletiva` (
  `idFormacao_coletiva` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_formacao_coletiva` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idFormacao_coletiva`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;