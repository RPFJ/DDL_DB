CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_tp_organizacao` (
  `idTipoOrganizacao` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipoOrganizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;