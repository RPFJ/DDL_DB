CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_geracao_renda` (
  `idGeracao_renda` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`idGeracao_renda`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;