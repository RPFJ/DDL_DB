create or replace NONEDITIONABLE PACKAGE PKG_APAGA_REGISTROS_DS AS
    /*=== DIMENSAO ===*/
    PROCEDURE DELETE_D_EMPREENDIMENTO_DS;
    PROCEDURE DELETE_D_GERACAO_RENDA_DS;
    PROCEDURE DELETE_D_QUESTAO_DS;
    PROCEDURE DELETE_D_REDE_ECONOMICA_DS;

    /*=== FATO ===*/
    PROCEDURE DELETE_F_D_LOCAL_DS;
    PROCEDURE DELETE_F_EVOLUCAO_DS;

END PKG_APAGA_REGISTROS_DS;

create or replace PACKAGE BODY PKG_APAGA_REGISTROS_DS AS

    -- D_EMPREENDIMENTO_DS
    PROCEDURE DELETE_D_EMPREENDIMENTO_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
            LOOP
                --apaga de 10000 em 10000 registros
                DELETE FROM D_EMPREENDIMENTO_DS WHERE ROWNUM <= 10000;
                vAux := sql%rowcount;
                --aplica commit quando atingir 10000
                COMMIT;
            END LOOP;
    END;

    -- D_GERACAO_RENDA_DS
    PROCEDURE DELETE_D_GERACAO_RENDA_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
            LOOP
                --apaga de 10000 em 10000 registros
                DELETE FROM D_GERACAO_RENDA_DS WHERE ROWNUM <= 10000;
                vAux := sql%rowcount;
                --aplica commit quando atingir 10000
                COMMIT;
            END LOOP;
    END;

    -- D_QUESTAO_DS
    PROCEDURE DELETE_D_QUESTAO_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
            LOOP
                --apaga de 10000 em 10000 registros
                DELETE FROM D_QUESTAO_DS WHERE ROWNUM <= 10000;
                vAux := sql%rowcount;
                --aplica commit quando atingir 10000
                COMMIT;
            END LOOP;
    END;

    -- D_REDE_ECONOMICA_DS
    PROCEDURE DELETE_D_REDE_ECONOMICA_DS AS
        vAux NUMBER := 1;
    BEGIN
        WHILE vAux > 0
            LOOP
                --apaga de 10000 em 10000 registros
                DELETE FROM D_REDE_ECONOMICA_DS WHERE ROWNUM <= 10000;
                vAux := sql%rowcount;
                --aplica commit quando atingir 10000
                COMMIT;
            END LOOP;
    END;

    -- F_DESENVOLVIMENTO_LOCAL_DS
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

    -- F_EVOLUCAO_DS
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