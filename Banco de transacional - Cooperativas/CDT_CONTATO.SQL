CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_contato` (
  `idContato` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_contato` INT(11) NULL DEFAULT NULL,
  `desc_contato` VARCHAR(100) NULL DEFAULT NULL,
  `id_empreendimento` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idContato`),
  INDEX `fk_contato_empreendimento` (`id_empreendimento` ASC) VISIBLE,
  INDEX `fk_contato_tp_contato` (`id_tipo_contato` ASC) VISIBLE,
  CONSTRAINT `fk_contato_empreendimento`
    FOREIGN KEY (`id_empreendimento`)
    REFERENCES `empreendimentos`.`cdt_empreendimento` (`idEmpreendimento`),
  CONSTRAINT `fk_contato_tp_contato`
    FOREIGN KEY (`id_tipo_contato`)
    REFERENCES `empreendimentos`.`cdt_tp_contato` (`idtipo_contato`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;