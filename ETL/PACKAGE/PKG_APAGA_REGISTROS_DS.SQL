CREATE OR REPLACE PACKAGE PKG_APAGA_REGISTROS_DS AS
    /*=== DIMENSAO ===*/
    PROCEDURE DELETE_D_COOPERATIVA_DS;
    PROCEDURE DELETE_D_REDE_PRODUTIVA_DS;

    /*=== FATO ===*/
    PROCEDURE DELETE_F_D_COLETA_DS;
    PROCEDURE DELETE_F_D_LOCAL_DS;
    PROCEDURE DELETE_F_EVOLUCAO_DS;

END PKG_APAGA_REGISTROS_DS;


CREATE OR REPLACE PACKAGE BODY PKG_APAGA_REGISTROS_DS AS

    PROCEDURE DELETE_D_COOPERATIVA_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
         LOOP
            --apaga de 10000 em 10000 registros
            DELETE FROM D_COOPERATIVA_DS WHERE ROWNUM <= 10000;
            vAux := sql%rowcount;
            --aplica commit quando atingir 10000
            COMMIT;
         END LOOP;
    END;


    PROCEDURE DELETE_D_REDE_PRODUTIVA_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
         LOOP
            --apaga de 10000 em 10000 registros
            DELETE FROM D_REDE_PRODUTIVA_DS WHERE ROWNUM <= 10000;
            vAux := sql%rowcount;
            --aplica commit quando atingir 10000
            COMMIT;
         END LOOP;
    END;


    PROCEDURE DELETE_F_D_COLETA_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
         LOOP
            --apaga de 10000 em 10000 registros
            DELETE FROM F_DESENVOLVIMENTO_COLETA_DS WHERE ROWNUM <= 10000;
            vAux := sql%rowcount;
            --aplica commit quando atingir 10000
            COMMIT;
         END LOOP;
    END;


    PROCEDURE DELETE_F_D_LOCAL_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
         LOOP
            --apaga de 10000 em 10000 registros
            DELETE FROM F_DESENVOLVIMENTO_LOCAL_DS WHERE ROWNUM <= 10000;
            vAux := sql%rowcount;
            --aplica commit quando atingir 10000
            COMMIT;
         END LOOP;
    END;


    PROCEDURE DELETE_F_EVOLUCAO_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
         LOOP
            --apaga de 10000 em 10000 registros
            DELETE FROM F_EVOLUCAO_DS WHERE ROWNUM <= 10000;
            vAux := sql%rowcount;
            --aplica commit quando atingir 10000
            COMMIT;
         END LOOP;
    END;

END;