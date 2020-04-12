CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_resposta` (
  `idResposta` INT NOT NULL AUTO_INCREMENT,
  `desc_resposta` VARCHAR(500) NULL DEFAULT NULL,
  `id_questao` INT NULL DEFAULT NULL,
  `id_evolucao` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idResposta`),
  INDEX `fk_respostas_evolucao` (`id_evolucao` ASC) VISIBLE,
  INDEX `fk_resposta_questao` (`id_questao` ASC) VISIBLE,
  CONSTRAINT `fk_resposta_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `empreendimentos`.`cdt_questao` (`idQuestao`),
  CONSTRAINT `fk_respostas_evolucao`
    FOREIGN KEY (`id_evolucao`)
    REFERENCES `empreendimentos`.`rel_evolucao` (`idEvolucao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;