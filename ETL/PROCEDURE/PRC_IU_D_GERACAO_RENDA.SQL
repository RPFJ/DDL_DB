create or replace NONEDITIONABLE PROCEDURE PRC_IU_D_GERACAO_RENDA AS
    v_log           ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_fg_status_etl D_GERACAO_RENDA_DS.FG_STATUS_ETL%TYPE;
    CURSOR v_geracao_renda_cursor IS
        SELECT *
        FROM D_GERACAO_RENDA_DS
        WHERE FG_STATUS_ETL = 'T';
BEGIN
    FOR v_geracao_renda IN v_geracao_renda_cursor
        LOOP
            v_fg_status_etl := 'L';
            BEGIN
                INSERT INTO BI_USER.D_GERACAO_RENDA_DW( SK_GERACAO_RENDA
                                                      , ID_GERACAO_RENDA
                                                      , DESC_GERACAO_RENDA)
                VALUES ( BI_USER.SEQ_D_GERACAO_RENDA.nextval
                       , v_geracao_renda.ID_GERACAO_RENDA
                       , v_geracao_renda.DESC_GERACAO_RENDA);
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    UPDATE BI_USER.D_GERACAO_RENDA_DW
                    SET DESC_GERACAO_RENDA = v_geracao_renda.DESC_GERACAO_RENDA
                      , DT_ALTERACAO_DW    = SYSDATE
                    WHERE ID_GERACAO_RENDA = v_geracao_renda.ID_GERACAO_RENDA;
                WHEN OTHERS THEN
                    v_fg_status_etl := 'F';
            END;
            BEGIN
                UPDATE D_GERACAO_RENDA_DS
                SET FG_STATUS_ETL = v_fg_status_etl
                WHERE ID_GERACAO_RENDA = v_geracao_renda.ID_GERACAO_RENDA;
            END;
        END LOOP;

    BEGIN
        INSERT INTO ADM_LOG_DS ( ID_LOG
                               , PASSO
                               , TIPO
                               , ACONTECIMENTO)
        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
               , 'CARREGANDO DADOS [D_GERACAO_RENDA_DW]'
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
                   , 'CARREGANDO DADOS [D_GERACAO_RENDA_DW]'
                   , 'F'
                   , v_log);
        END;

END PRC_IU_D_GERACAO_RENDA;