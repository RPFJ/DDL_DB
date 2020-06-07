create or replace NONEDITIONABLE PROCEDURE PRC_CARREGA_DADOS_DW(p_excluir IN CHAR) AS
    v_log ADM_LOG_DS.ACONTECIMENTO%TYPE;

BEGIN
    /*=== DIMENSÃO ===*/
    PRC_IU_D_EMPREENDIMENTO;
    PRC_IU_D_GERACAO_RENDA;
    PRC_IU_D_QUESTAO;
    PRC_IU_D_REDE_ECONOMICA;

    /*=== FATO ===*/
    PRC_I_F_EVOLUCAO();
    PRC_I_F_DESENVOLVIMENTO_LOCAL(p_excluir);

    BEGIN
        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [PRC_CARREGA_DADOS_DW]'
            , 'T'
            , 'CARGA DE DE DADOS REALIZADA COM SUCESSO'
        );
    END;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

        v_log := 'FALHA NA TRANSFORMACAO DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] ';

        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [PRC_CARREGA_DADOS_DW]'
            , 'F'
            , v_log
        );
END PRC_CARREGA_DADOS_DW;