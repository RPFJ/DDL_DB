CREATE TABLE IF NOT EXISTS `empreendimentos`.`formacao_coletiva_emprrendimento` (
  `id_formacao_coletiva` INT NOT NULL,
  `id_empreendimento` INT NOT NULL,
  PRIMARY KEY (`id_formacao_coletiva`, `id_empreendimento`),
  INDEX `fk_Formacao_coletiva_has_empreendimento_empreendimento1` (`id_empreendimento` ASC) VISIBLE,
  CONSTRAINT `fk_Formacao_coletiva_has_empreendimento_empreendimento1`
    FOREIGN KEY (`id_empreendimento`)
    REFERENCES `empreendimentos`.`cdt_empreendimento` (`idEmpreendimento`),
  CONSTRAINT `fk_Formacao_coletiva_has_empreendimento_Formacao_coletiva1`
    FOREIGN KEY (`id_formacao_coletiva`)
    REFERENCES `empreendimentos`.`cdt_formacao_coletiva` (`idFormacao_coletiva`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;