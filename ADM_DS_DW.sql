-- Rodar como  usuário SYS/SYSDBA/SYSTEM
--CRIAÇÃO DOS USUÁRIOS
CREATE USER BI_USER     IDENTIFIED BY bi_user#1234;
CREATE USER BI_DS_USER  IDENTIFIED BY bi_DS_user#1234;

-- Caso não funcione, rodar script abaixo e tentar novamente
alter session set "_ORACLE_SCRIPT"=true;  

-- PERMISSÃO DE SESSÃO
GRANT CREATE SESSION TO BI_DS_USER;
GRANT CREATE SESSION TO BI_USER;

--PERMISSÃO PARA CRIAÇÃO DOS OBJETOS
GRANT CREATE TABLE, CREATE PROCEDURE,CREATE TABLESPACE, CREATE TRIGGER, CREATE VIEW, CREATE SEQUENCE TO BI_DS_USER;
GRANT CREATE TABLE, CREATE PROCEDURE,CREATE TABLESPACE, CREATE TRIGGER, CREATE VIEW, CREATE SEQUENCE TO BI_USER;

GRANT DROP TABLESPACE TO BI_DS_USER;
GRANT DROP TABLESPACE TO BI_USER;

-- Caso necessite de mais privilégios
GRANT ALL PRIVILEGES TO BI_USER;
GRANT ALL PRIVILEGES TO BI_DS_USER;

--CRIAÇÃO DAS TABLESPACES
-- Executar no DS antes da criação das tabelas
CREATE TABLESPACE TBP_BI_DS_USER_IDX
  DATAFILE 'TBP_BI_DS_USER_IDX.dat'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10M MAXSIZE 1000M;

-- Executar no DW antes da criação das tabelas
  CREATE TABLESPACE TBP_BI_USER_IDX
  DATAFILE 'TBP_BI_USER_IDX.dat'
    SIZE 10M
    REUSE
    AUTOEXTEND ON NEXT 10M MAXSIZE 1000M;

-- PERMISSÁO DE LEITURA - TABELAS (Rodar antes de aplicar os scripts das procedures e packages)
GRANT SELECT, INSERT, UPDATE, DELETE ON BI_USER.D_COOPERATIVA_DW TO BI_DS_USER;
GRANT SELECT, INSERT, UPDATE, DELETE ON BI_USER.D_REDE_PRODUTIVA_DW TO BI_DS_USER;
GRANT SELECT, INSERT, UPDATE, DELETE ON BI_USER.D_TEMPO_DW TO BI_DS_USER;
GRANT SELECT, INSERT, UPDATE, DELETE ON BI_USER.F_DESENVOLVIMENTO_LOCAL_DW TO BI_DS_USER;
GRANT SELECT, INSERT, UPDATE, DELETE ON BI_USER.F_DESENVOLVIMENTO_COLETA_DW TO BI_DS_USER;
GRANT SELECT ON BI_USER.D_TEMPO_DW TO BI_DS_USER;

-- PERMISSÃO DE LEITURA - SEQUENCES
GRANT SELECT ON BI_USER.SEQ_D_COOPERATIVA TO BI_DS_USER;
GRANT SELECT ON BI_USER.SEQ_D_REDE_PRODUTIVA TO BI_DS_USER;

-- Conexão com o banco Pentaho 
(DESCRIPTION=(ENABLE=BROKEN)(ADDRESS=(PROTOCOL=TCP)(HOST=192.168.0.5)(PORT=1521))(CONNECT_DATA=(SID=XE)))