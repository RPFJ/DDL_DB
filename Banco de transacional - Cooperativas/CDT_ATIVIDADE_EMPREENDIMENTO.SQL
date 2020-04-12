CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_atividade_emprrendimento` (
  `idAtividade` INT NOT NULL AUTO_INCREMENT,
  `desc_atividade` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`idAtividade`),
  INDEX `fk_Atividade_Empreendimento` (`desc_atividade` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;
