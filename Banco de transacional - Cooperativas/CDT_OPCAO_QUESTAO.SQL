CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_opcao_questao` (
  `idOpcao` INT NOT NULL AUTO_INCREMENT,
  `desc_opcao` TEXT NULL DEFAULT NULL,
  `id_questao` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idOpcao`),
  INDEX `fk_opcao_questao_questao` (`id_questao` ASC) VISIBLE,
  CONSTRAINT `fk_opcao_questao_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `empreendimentos`.`cdt_questao` (`idQuestao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;