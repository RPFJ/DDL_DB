create or replace NONEDITIONABLE PROCEDURE PRC_IU_D_QUESTAO AS
    v_log           ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_fg_status_etl D_QUESTAO_DS.FG_STATUS_ETL%TYPE;
    CURSOR v_questao_cursor IS
        SELECT *
        FROM D_QUESTAO_DS
        WHERE FG_STATUS_ETL = 'T';
BEGIN
    FOR v_questao IN v_questao_cursor
        LOOP
            v_fg_status_etl := 'L';
            BEGIN
                INSERT INTO BI_USER.D_QUESTAO_DW( SK_QUESTAO
                                                , ID_QUESTAO
                                                , ID_RESPOSTA
                                                , DESC_QUESTAO
                                                , DESC_RESPOSTA)
                VALUES ( BI_USER.SEQ_D_QUESTAO.nextval
                       , v_questao.ID_QUESTAO
                       , v_questao.ID_RESPOSTA
                       , v_questao.DESC_QUESTAO
                       , v_questao.DESC_RESPOSTA);
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    UPDATE BI_USER.D_QUESTAO_DW
                    SET DESC_QUESTAO    = v_questao.DESC_QUESTAO
                      , DESC_RESPOSTA   = v_questao.DESC_RESPOSTA
                      , DT_ALTERACAO_DW = SYSDATE
                    WHERE ID_QUESTAO = v_questao.ID_QUESTAO
                      AND ID_RESPOSTA = v_questao.ID_RESPOSTA;
                WHEN OTHERS THEN
                    v_fg_status_etl := 'F';
            END;
            BEGIN
                UPDATE D_QUESTAO_DS
                SET FG_STATUS_ETL = v_fg_status_etl
                WHERE ID_QUESTAO = v_questao.ID_QUESTAO
                  AND ID_RESPOSTA = v_questao.ID_RESPOSTA;
            END;
        END LOOP;

    BEGIN
        INSERT INTO ADM_LOG_DS ( ID_LOG
                               , PASSO
                               , TIPO
                               , ACONTECIMENTO)
        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
               , 'CARREGANDO DADOS [D_QUESTAO_DW]'
               , 'T'
               , 'CARGA DE DE DADOS REALIZADA COM SUCESSO');
    END;

    COMMIT WORK;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

        BEGIN
            v_log := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

            INSERT INTO ADM_LOG_DS ( ID_LOG
                                   , PASSO
                                   , TIPO
                                   , ACONTECIMENTO)
            VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                   , 'CARREGANDO DADOS [D_QUESTAO_DW]'
                   , 'F'
                   , v_log);
        END;

END PRC_IU_D_QUESTAO;