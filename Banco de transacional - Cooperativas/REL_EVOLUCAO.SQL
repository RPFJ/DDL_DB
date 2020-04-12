CREATE TABLE IF NOT EXISTS `empreendimentos`.`rel_evolucao` (
  `idEvolucao` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL DEFAULT NULL,
  `geracao_renda` FLOAT NULL DEFAULT NULL,
  `n_homens` INT NULL DEFAULT NULL,
  `n_mulheres` INT NULL DEFAULT NULL,
  `computador` TINYINT(1) NULL DEFAULT NULL,
  `internet` TINYINT(1) NULL DEFAULT NULL,
  `id_empreendimento` INT NULL DEFAULT NULL,
  `id_rede_economica` INT NULL DEFAULT NULL,
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
DEFAULT CHARACTER SET = latin1;