CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_tp_rede` (
  `idtipo_rede` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_tipo` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_rede`),
  UNIQUE INDEX `desc_tipo` (`desc_tipo` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;