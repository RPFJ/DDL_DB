create or replace NONEDITIONABLE PROCEDURE PRC_IU_D_REDE_ECONOMICA AS
    v_log           ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_fg_status_etl D_REDE_ECONOMICA_DS.FG_STATUS_ETL%TYPE;
    CURSOR v_rede_economica_cursor IS
        SELECT *
        FROM D_REDE_ECONOMICA_DS
        WHERE FG_STATUS_ETL = 'T';
BEGIN
    FOR v_rede_economica IN v_rede_economica_cursor
        LOOP
            v_fg_status_etl := 'L';
            BEGIN
                INSERT INTO BI_USER.D_REDE_ECONOMICA_DW( SK_REDE_ECONOMICA
                                                       , ID_REDE_ECONOMICA
                                                       , DESC_REDE_ECONOMICA
                                                       , LATITUDE
                                                       , LONGITUDE
                                                       , ID_TIPO_REDE
                                                       , DESC_TIPO_REDE)
                VALUES ( BI_USER.SEQ_D_REDE_ECONOMICA.nextval
                       , v_rede_economica.ID_REDE_ECONOMICA
                       , v_rede_economica.DESC_REDE_ECONOMICA
                       , v_rede_economica.LATITUDE
                       , v_rede_economica.LONGITUDE
                       , v_rede_economica.ID_TIPO_REDE
                       , v_rede_economica.DESC_TIPO_REDE);
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    UPDATE BI_USER.D_REDE_ECONOMICA_DW
                    SET DESC_REDE_ECONOMICA  = v_rede_economica.DESC_REDE_ECONOMICA
                        , LATITUDE           = v_rede_economica.LATITUDE                              
                        , LONGITUDE          = v_rede_economica.LONGITUDE                             
                        , ID_TIPO_REDE       = v_rede_economica.ID_TIPO_REDE                                  
                        , DESC_TIPO_REDE     = v_rede_economica.DESC_TIPO_REDE                                         
                        , DT_ALTERACAO_DW = SYSDATE
                    WHERE ID_REDE_ECONOMICA = v_rede_economica.ID_REDE_ECONOMICA;
                WHEN OTHERS THEN
                    v_fg_status_etl := 'F';
            END;
            BEGIN
                UPDATE D_REDE_ECONOMICA_DS
                SET FG_STATUS_ETL = v_fg_status_etl
                WHERE ID_REDE_ECONOMICA = v_rede_economica.ID_REDE_ECONOMICA;
            END;
        END LOOP;

    BEGIN
        INSERT INTO ADM_LOG_DS ( ID_LOG
                               , PASSO
                               , TIPO
                               , ACONTECIMENTO)
        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
               , 'CARREGANDO DADOS [D_REDE_ECONOMICA_DW]'
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
                   , 'CARREGANDO DADOS [D_REDE_ECONOMICA_DW]'
                   , 'F'
                   , v_log);
        END;

END PRC_IU_D_REDE_ECONOMICA;