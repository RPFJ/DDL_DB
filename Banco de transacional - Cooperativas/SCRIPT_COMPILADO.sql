-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cooperativas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cooperativas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cooperativas` DEFAULT CHARACTER SET latin1 ;
USE `cooperativas` ;

-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_apoiador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_apoiador` (
  `idApoiador` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `cidade` VARCHAR(100) NULL DEFAULT NULL,
  `tipo_de_ajuda` VARCHAR(100) NULL DEFAULT NULL,
  `dt_cadastro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idApoiador`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_area_atuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_area_atuacao` (
  `idAreaAtuacao` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_area_atuacao` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idAreaAtuacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_atividade_cooperativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_atividade_cooperativa` (
  `idAtividade` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_atividade` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`idAtividade`),
  INDEX `fk_Atividade_has_Cooperativa_Cooperativa1` (`desc_atividade` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_localizacao` (
  `idLocalizacao` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_localizacao` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idLocalizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 8
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_tp_organizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_tp_organizacao` (
  `idTipoOrganizacao` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipoOrganizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_cooperativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_cooperativa` (
  `idCooperativa` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `endereco` VARCHAR(500) NULL DEFAULT NULL,
  `cidade` VARCHAR(100) NULL DEFAULT NULL,
  `latitude` FLOAT NULL DEFAULT NULL,
  `longitude` FLOAT NULL DEFAULT NULL,
  `senha` VARCHAR(8) NULL DEFAULT NULL,
  `sigla` VARCHAR(20) NULL DEFAULT NULL,
  `ano_inicio` INT(11) NULL DEFAULT NULL,
  `id_area_atuacao` INT(11) NULL DEFAULT NULL,
  `id_localizacao` INT(11) NULL DEFAULT NULL,
  `id_tipo_organizacao` INT(11) NULL DEFAULT NULL,
  `dt_cadastro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idCooperativa`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `fk_cooperativa_tp_organizacao` (`id_tipo_organizacao` ASC) VISIBLE,
  INDEX `fk_cooperativa_contato` (`id_localizacao` ASC) VISIBLE,
  INDEX `fk_cooperativa_area_atuacao` (`id_area_atuacao` ASC) VISIBLE,
  CONSTRAINT `fk_cooperativa_area_atuacao`
    FOREIGN KEY (`id_area_atuacao`)
    REFERENCES `cooperativas`.`cdt_area_atuacao` (`idAreaAtuacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cooperativa_contato`
    FOREIGN KEY (`id_localizacao`)
    REFERENCES `cooperativas`.`cdt_localizacao` (`idLocalizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cooperativa_tp_organizacao`
    FOREIGN KEY (`id_tipo_organizacao`)
    REFERENCES `cooperativas`.`cdt_tp_organizacao` (`idTipoOrganizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_tp_contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_tp_contato` (
  `idtipo_contato` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_contato`))
ENGINE = InnoDB
AUTO_INCREMENT = 15
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_contato` (
  `idContato` INT(11) NOT NULL AUTO_INCREMENT,
  `id_tipo_contato` INT(11) NULL DEFAULT NULL,
  `desc_contato` VARCHAR(100) NULL DEFAULT NULL,
  `id_cooperativa` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idContato`),
  INDEX `fk_contato_cooperativa` (`id_cooperativa` ASC) VISIBLE,
  INDEX `fk_contato_tp_contato` (`id_tipo_contato` ASC) VISIBLE,
  CONSTRAINT `fk_contato_cooperativa`
    FOREIGN KEY (`id_cooperativa`)
    REFERENCES `cooperativas`.`cdt_cooperativa` (`idCooperativa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contato_tp_contato`
    FOREIGN KEY (`id_tipo_contato`)
    REFERENCES `cooperativas`.`cdt_tp_contato` (`idtipo_contato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_formacao_coletiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_formacao_coletiva` (
  `idFormacao_coletiva` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_formacao_coletiva` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idFormacao_coletiva`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_questao` (
  `idQuestao` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_questao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idQuestao`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_opcao_questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_opcao_questao` (
  `idOpcao` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_opcao` TEXT NULL DEFAULT NULL,
  `id_questao` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idOpcao`),
  INDEX `fk_opcao_questao_questao` (`id_questao` ASC) VISIBLE,
  CONSTRAINT `fk_opcao_questao_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `cooperativas`.`cdt_questao` (`idQuestao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_tp_rede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_tp_rede` (
  `idtipo_rede` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_tipo` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_rede`),
  UNIQUE INDEX `desc_tipo` (`desc_tipo` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_rede_produtiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_rede_produtiva` (
  `idRede_produtiva` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_rede` VARCHAR(100) NULL DEFAULT NULL,
  `latitude` FLOAT NULL DEFAULT NULL,
  `longitude` FLOAT NULL DEFAULT NULL,
  `id_tipo_rede` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idRede_produtiva`),
  INDEX `fk_rede_produtiva_1` (`id_tipo_rede` ASC) VISIBLE,
  CONSTRAINT `fk_rede_produtiva_1`
    FOREIGN KEY (`id_tipo_rede`)
    REFERENCES `cooperativas`.`cdt_tp_rede` (`idtipo_rede`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`rel_evolucao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`rel_evolucao` (
  `idEvolucao` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATE NULL DEFAULT NULL,
  `geracao_renda` FLOAT NULL DEFAULT NULL,
  `n_homens` INT(11) NULL DEFAULT NULL,
  `n_mulheres` INT(11) NULL DEFAULT NULL,
  `computador` TINYINT(1) NULL DEFAULT NULL,
  `internet` TINYINT(1) NULL DEFAULT NULL,
  `id_cooperativa` INT(11) NULL DEFAULT NULL,
  `id_rede_produtiva` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idEvolucao`),
  INDEX `fk_evolucao_cooperativa` (`id_cooperativa` ASC) VISIBLE,
  INDEX `fk_evolucao_rede_produtiva` (`id_rede_produtiva` ASC) VISIBLE,
  CONSTRAINT `fk_evolucao_cooperativa`
    FOREIGN KEY (`id_cooperativa`)
    REFERENCES `cooperativas`.`cdt_cooperativa` (`idCooperativa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_evolucao_rede_produtiva`
    FOREIGN KEY (`id_rede_produtiva`)
    REFERENCES `cooperativas`.`cdt_rede_produtiva` (`idRede_produtiva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_resposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_resposta` (
  `idResposta` INT(11) NOT NULL AUTO_INCREMENT,
  `desc_resposta` VARCHAR(500) NULL DEFAULT NULL,
  `id_questao` INT(11) NULL DEFAULT NULL,
  `id_evolucao` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idResposta`),
  INDEX `fk_respostas_evolucao` (`id_evolucao` ASC) VISIBLE,
  INDEX `fk_resposta_questao` (`id_questao` ASC) VISIBLE,
  CONSTRAINT `fk_resposta_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `cooperativas`.`cdt_questao` (`idQuestao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_respostas_evolucao`
    FOREIGN KEY (`id_evolucao`)
    REFERENCES `cooperativas`.`rel_evolucao` (`idEvolucao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`cdt_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`cdt_usuarios` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `sobrenome` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `senha` VARCHAR(200) NULL DEFAULT NULL,
  `dt_cadastro` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`formacao_coletiva_cooperativa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`formacao_coletiva_cooperativa` (
  `id_formacao_coletiva` INT(11) NOT NULL,
  `id_cooperativa` INT(11) NOT NULL,
  PRIMARY KEY (`id_formacao_coletiva`, `id_cooperativa`),
  INDEX `fk_Formacao_coletiva_has_Cooperativa_Cooperativa1` (`id_cooperativa` ASC) VISIBLE,
  CONSTRAINT `fk_Formacao_coletiva_has_Cooperativa_Cooperativa1`
    FOREIGN KEY (`id_cooperativa`)
    REFERENCES `cooperativas`.`cdt_cooperativa` (`idCooperativa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Formacao_coletiva_has_Cooperativa_Formacao_coletiva1`
    FOREIGN KEY (`id_formacao_coletiva`)
    REFERENCES `cooperativas`.`cdt_formacao_coletiva` (`idFormacao_coletiva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cooperativas`.`rede_produtiva_apoiador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cooperativas`.`rede_produtiva_apoiador` (
  `id_rede_produtiva` INT(11) NOT NULL,
  `id_apoiador` INT(11) NOT NULL,
  PRIMARY KEY (`id_rede_produtiva`, `id_apoiador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
