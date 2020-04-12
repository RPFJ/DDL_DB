-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema empreendimentos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema empreendimentos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `empreendimentos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `empreendimentos` ;

-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_apoiador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_apoiador` (
  `idApoiador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `cidade` VARCHAR(100) NULL DEFAULT NULL,
  `tipo_de_ajuda` VARCHAR(100) NULL DEFAULT NULL,
  `dt_cadastro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idApoiador`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_area_atuacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_area_atuacao` (
  `idAreaAtuacao` INT NOT NULL AUTO_INCREMENT,
  `desc_area_atuacao` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idAreaAtuacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_atividade_emprrendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_atividade_emprrendimento` (
  `idAtividade` INT NOT NULL AUTO_INCREMENT,
  `desc_atividade` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`idAtividade`),
  INDEX `fk_Atividade_Empreendimento` (`desc_atividade` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_localizacao` (
  `idLocalizacao` INT NOT NULL AUTO_INCREMENT,
  `desc_localizacao` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idLocalizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_tp_organizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_tp_organizacao` (
  `idTipoOrganizacao` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idTipoOrganizacao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_empreendimento`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_tp_contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_tp_contato` (
  `idtipo_contato` INT NOT NULL AUTO_INCREMENT,
  `nome_tipo` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_contato`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_contato` (
  `idContato` INT NOT NULL AUTO_INCREMENT,
  `id_tipo_contato` INT NULL DEFAULT NULL,
  `desc_contato` VARCHAR(100) NULL DEFAULT NULL,
  `id_empreendimento` INT NULL DEFAULT NULL,
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


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_formacao_coletiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_formacao_coletiva` (
  `idFormacao_coletiva` INT NOT NULL AUTO_INCREMENT,
  `desc_formacao_coletiva` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idFormacao_coletiva`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_questao` (
  `idQuestao` INT NOT NULL AUTO_INCREMENT,
  `desc_questao` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`idQuestao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_opcao_questao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_opcao_questao` (
  `idOpcao` INT NOT NULL AUTO_INCREMENT,
  `desc_opcao` TEXT NULL DEFAULT NULL,
  `id_questao` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idOpcao`),
  INDEX `fk_opcao_questao_questao` (`id_questao` ASC) VISIBLE,
  CONSTRAINT `fk_opcao_questao_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `empreendimentos`.`cdt_questao` (`idQuestao`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_tp_rede`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_tp_rede` (
  `idtipo_rede` INT NOT NULL AUTO_INCREMENT,
  `desc_tipo` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`idtipo_rede`),
  UNIQUE INDEX `desc_tipo` (`desc_tipo` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_rede_economica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_rede_economica` (
  `idRede_economica` INT NOT NULL AUTO_INCREMENT,
  `desc_rede` VARCHAR(100) NULL DEFAULT NULL,
  `latitude` FLOAT NULL DEFAULT NULL,
  `longitude` FLOAT NULL DEFAULT NULL,
  `id_tipo_rede` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idRede_economica`),
  INDEX `fk_rede_economica_1` (`id_tipo_rede` ASC) VISIBLE,
  CONSTRAINT `fk_rede_economica_1`
    FOREIGN KEY (`id_tipo_rede`)
    REFERENCES `empreendimentos`.`cdt_tp_rede` (`idtipo_rede`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`rel_evolucao`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_resposta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_resposta` (
  `idResposta` INT NOT NULL AUTO_INCREMENT,
  `desc_resposta` VARCHAR(500) NULL DEFAULT NULL,
  `id_questao` INT NULL DEFAULT NULL,
  `id_evolucao` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idResposta`),
  INDEX `fk_respostas_evolucao` (`id_evolucao` ASC) VISIBLE,
  INDEX `fk_resposta_questao` (`id_questao` ASC) VISIBLE,
  CONSTRAINT `fk_resposta_questao`
    FOREIGN KEY (`id_questao`)
    REFERENCES `empreendimentos`.`cdt_questao` (`idQuestao`),
  CONSTRAINT `fk_respostas_evolucao`
    FOREIGN KEY (`id_evolucao`)
    REFERENCES `empreendimentos`.`rel_evolucao` (`idEvolucao`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`cdt_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`cdt_usuarios` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL DEFAULT NULL,
  `sobrenome` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `senha` VARCHAR(200) NULL DEFAULT NULL,
  `dt_cadastro` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`))
ENGINE = InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `empreendimentos`.`formacao_coletiva_emprrendimento`
-- -----------------------------------------------------
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


-- -----------------------------------------------------
-- Table `empreendimentos`.`rede_economica_apoiador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `empreendimentos`.`rede_economica_apoiador` (
  `id_rede_economica` INT NOT NULL,
  `id_apoiador` INT NOT NULL,
  PRIMARY KEY (`id_rede_economica`, `id_apoiador`),
  INDEX `fk_rede_economica_apoiador_apoiador_idx` (`id_apoiador` ASC) VISIBLE,
  CONSTRAINT `fk_rede_economica_apoiador_r_economica`
    FOREIGN KEY (`id_rede_economica`)
    REFERENCES `empreendimentos`.`cdt_rede_economica` (`idRede_economica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rede_economica_apoiador_apoiador`
    FOREIGN KEY (`id_apoiador`)
    REFERENCES `empreendimentos`.`cdt_apoiador` (`idApoiador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
