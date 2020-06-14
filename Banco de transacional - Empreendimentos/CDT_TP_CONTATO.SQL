CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_tp_contato` (
  `idtipo_contato` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_contato`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;