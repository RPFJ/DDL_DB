CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_empreendimento` (
  `idEmpreendimento` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `endereco` VARCHAR(500) NULL DEFAULT NULL,
  `cidade` VARCHAR(100) NULL DEFAULT NULL,
  `latitude` FLOAT NULL DEFAULT NULL,
  `longitude` FLOAT NULL DEFAULT NULL,
  `senha` VARCHAR(8) NULL DEFAULT NULL,
  `sigla` VARCHAR(20) NULL DEFAULT NULL,
  `ano_inicio` INT NULL DEFAULT NULL,
  `id_area_atuacao` INT NULL DEFAULT NULL,
  `id_localizacao` INT NULL DEFAULT NULL,
  `id_tipo_organizacao` INT NULL DEFAULT NULL,
  `dt_cadastro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idEmpreendimento`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `fk_empreendimento_tp_organizacao` (`id_tipo_organizacao` ASC) VISIBLE,
  INDEX `fk_empreendimento_contato` (`id_localizacao` ASC) VISIBLE,
  INDEX `fk_empreendimento_area_atuacao` (`id_area_atuacao` ASC) VISIBLE,
  CONSTRAINT `fk_empreendimento_area_atuacao`
    FOREIGN KEY (`id_area_atuacao`)
    REFERENCES `empreendimentos`.`cdt_area_atuacao` (`idAreaAtuacao`),
  CONSTRAINT `fk_empreendimento_contato`
    FOREIGN KEY (`id_localizacao`)
    REFERENCES `empreendimentos`.`cdt_localizacao` (`idLocalizacao`),
  CONSTRAINT `fk_empreendimento_tp_organizacao`
    FOREIGN KEY (`id_tipo_organizacao`)
    REFERENCES `empreendimentos`.`cdt_tp_organizacao` (`idTipoOrganizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;