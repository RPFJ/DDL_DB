CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_questao` (
  `idQuestao` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_questao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idQuestao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;