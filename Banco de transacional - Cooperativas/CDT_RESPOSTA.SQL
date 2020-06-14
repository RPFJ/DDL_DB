CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_resposta` (
  `idResposta` INT(11) NOT NULL AUTO_INCREMENT,
  `id_opcao_questao` INT(11) NOT NULL,
  `id_questao` INT(11) NOT NULL,
  `id_evolucao` INT(11) NOT NULL,
  PRIMARY KEY (`idResposta`),
  INDEX `fk_respostas_evolucao` (`id_evolucao` ASC) VISIBLE,
  INDEX `fk_resposta_questao` (`id_questao` ASC) VISIBLE,
  INDEX `fk_respostas_opcao_questao_idx` (`id_opcao_questao` ASC) VISIBLE,
  CONSTRAINT `fk_resposta_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `empreendimentos`.`cdt_questao` (`idQuestao`),
  CONSTRAINT `fk_respostas_evolucao`
    FOREIGN KEY (`id_evolucao`)
    REFERENCES `empreendimentos`.`rel_evolucao` (`idEvolucao`),
  CONSTRAINT `fk_respostas_opcao_questao`
    FOREIGN KEY (`id_opcao_questao`)
    REFERENCES `empreendimentos`.`cdt_opcao_questao` (`idOpcao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;