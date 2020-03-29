create or replace NONEDITIONABLE PROCEDURE PRC_IU_D_REDE_PRODUTIVA AS
    v_log               ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_fg_status_etl     D_REDE_PRODUTIVA_DS.FG_STATUS_ETL%TYPE;

    CURSOR v_rede_produtiva_cursor IS
        SELECT *
        FROM D_REDE_PRODUTIVA_DS
        WHERE FG_STATUS_ETL = 'T';
BEGIN

    FOR v_rede_produtiva IN v_rede_produtiva_cursor LOOP
        v_fg_status_etl := 'L';

        BEGIN
            INSERT INTO BI_USER.D_REDE_PRODUTIVA_DW(
                SK_REDE_PRODUTIVA
                , REDE_PRODUTIVA_ID
                , REDE_PRODUTIVA_DESC
                , LATITUDE
                , LONGITUDE
                , TIPO_REDE_ID
                , TIPO_REDE_DESC
            ) VALUES (
                BI_USER.SEQ_D_REDE_PRODUTIVA.NEXTVAL
                , v_rede_produtiva.ID_REDE_PRODUTIVA
                , v_rede_produtiva.REDE_PRODUTIVA_DESC
                , v_rede_produtiva.LATITUDE
                , v_rede_produtiva.LONGITUDE
                , v_rede_produtiva.TIPO_REDE_ID
                , v_rede_produtiva.TIPO_REDE_DESC 
            );

            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    UPDATE BI_USER.D_REDE_PRODUTIVA_DW
                    SET REDE_PRODUTIVA_DESC  = v_rede_produtiva.REDE_PRODUTIVA_DESC   
                        , LATITUDE               = v_rede_produtiva.LATITUDE       
                        , LONGITUDE              = v_rede_produtiva.LONGITUDE       
                        , TIPO_REDE_ID           = v_rede_produtiva.TIPO_REDE_ID       
                        , TIPO_REDE_DESC         = v_rede_produtiva.TIPO_REDE_DESC       
                        , DT_ALTERACAO_DW        = SYSDATE
                    WHERE REDE_PRODUTIVA_ID = v_rede_produtiva.ID_REDE_PRODUTIVA;
                WHEN OTHERS THEN
                    v_fg_status_etl  := 'P';
            END;

        BEGIN
            UPDATE D_REDE_PRODUTIVA_DS
            SET FG_STATUS_ETL = v_fg_status_etl
            WHERE ID_REDE_PRODUTIVA = v_rede_produtiva.ID_REDE_PRODUTIVA; 
        END;
    END LOOP;

    BEGIN
        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [D_REDE_PRODUTIVA_DS]'
            , 'T'
            , 'CARGA DE DE DADOS REALIZADA COM SUCESSO'
        );
    END;

    COMMIT WORK;

EXCEPTION WHEN OTHERS THEN 
    ROLLBACK;

    BEGIN 
         v_log := 'FALHA NA CARGA DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] '; 

        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [D_REDE_PRODUTIVA_DS]'
            , 'F'
            , v_log
        );
    END;

END PRC_IU_D_REDE_PRODUTIVA;