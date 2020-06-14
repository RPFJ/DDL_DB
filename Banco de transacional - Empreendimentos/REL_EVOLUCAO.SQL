CREATE TABLE IF NOT EXISTS `empreendimentos`.`rel_evolucao` (
  `idEvolucao` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NULL DEFAULT NULL,
  `id_geracao_renda` INT(11) NOT NULL,
  `n_homens` INT(11) NULL DEFAULT NULL,
  `n_mulheres` INT(11) NULL DEFAULT NULL,
  `computador` TINYINT(1) NULL DEFAULT NULL,
  `internet` TINYINT(1) NULL DEFAULT NULL,
  `id_empreendimento` INT(11) NULL DEFAULT NULL,
  `id_rede_economica` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idEvolucao`),
  INDEX `fk_evolucao_empreendimento` (`id_empreendimento` ASC) VISIBLE,
  INDEX `fk_evolucao_rede_economica` (`id_rede_economica` ASC) VISIBLE,
  CONSTRAINT `fk_evolucao_empreendimento`
    FOREIGN KEY (`id_empreendimento`)
    REFERENCES `empreendimentos`.`cdt_empreendimento` (`idEmpreendimento`),
  CONSTRAINT `fk_evolucao_rede_economica`
    FOREIGN KEY (`id_rede_economica`)
    REFERENCES `empreendimentos`.`cdt_rede_economica` (`idRede_economica`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;