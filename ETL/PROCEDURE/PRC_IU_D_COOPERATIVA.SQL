create or replace NONEDITIONABLE PROCEDURE PRC_IU_D_COOPERATIVA AS
    v_log               ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_fg_status_etl     D_COOPERATIVA_DS.FG_STATUS_ETL%TYPE;

    CURSOR v_cooperativa_cursor IS
        SELECT *
        FROM D_COOPERATIVA_DS
        WHERE FG_STATUS_ETL = 'T';
BEGIN

    FOR v_cooperativa IN v_cooperativa_cursor LOOP
        v_fg_status_etl := 'L';

        BEGIN
            INSERT INTO BI_USER.D_COOPERATIVA_DW(
                SK_COOPERATIVA
                , COOPERATIVA_ID
                , COOPERATIVA_NOME
                , ENDERECO
                , CIDADE
                , LATITUDE
                , LONGITUDE
                , SIGLA
                , AREA_ATUACAO_ID
                , AREA_ATUACAO_DESC
                , LOCALIZACAO_ID
                , LOCALIZACAO_DESC
                , TIPO_ORGANIZACAO_ID
                , TIPO_ORGANIZACAO_NOME
                , ANO_INICIO
            ) VALUES (
                BI_USER.SEQ_D_COOPERATIVA.NEXTVAL
                , v_cooperativa.ID_COOPERATIVA
                , v_cooperativa.COOPERATIVA_NOME
                , v_cooperativa.ENDERECO
                , v_cooperativa.CIDADE
                , v_cooperativa.LATITUDE
                , v_cooperativa.LONGITUDE
                , v_cooperativa.SIGLA
                , v_cooperativa.AREA_ATUACAO_ID
                , v_cooperativa.AREA_ATUACAO_DESC
                , v_cooperativa.LOCALIZACAO_ID
                , v_cooperativa.LOCALIZACAO_DESC
                , v_cooperativa.TIPO_ORGANIZACAO_ID
                , v_cooperativa.TIPO_ORGANIZACAO_NOME
                , v_cooperativa.ANO_INICIO
            );

            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    UPDATE BI_USER.D_COOPERATIVA_DW
                    SET COOPERATIVA_NOME         = v_cooperativa.COOPERATIVA_NOME
                        , ENDERECO                 = v_cooperativa.ENDERECO
                        , CIDADE                   = v_cooperativa.CIDADE
                        , LATITUDE                 = v_cooperativa.LATITUDE
                        , LONGITUDE                = v_cooperativa.LONGITUDE
                        , SIGLA                    = v_cooperativa.SIGLA
                        , AREA_ATUACAO_ID          = v_cooperativa.AREA_ATUACAO_ID
                        , AREA_ATUACAO_DESC        = v_cooperativa.AREA_ATUACAO_DESC
                        , LOCALIZACAO_ID           = v_cooperativa.LOCALIZACAO_ID
                        , LOCALIZACAO_DESC         = v_cooperativa.LOCALIZACAO_DESC
                        , TIPO_ORGANIZACAO_ID      = v_cooperativa.TIPO_ORGANIZACAO_ID
                        , TIPO_ORGANIZACAO_NOME    = v_cooperativa.TIPO_ORGANIZACAO_NOME
                        , ANO_INICIO               = v_cooperativa.ANO_INICIO
                        , DT_ALTERACAO_DW        = SYSDATE
                    WHERE COOPERATIVA_ID = v_cooperativa.ID_COOPERATIVA;
                WHEN OTHERS THEN
                    v_fg_status_etl := 'P';
        END;

        BEGIN
            UPDATE D_COOPERATIVA_DS
            SET FG_STATUS_ETL = v_fg_status_etl
            WHERE ID_COOPERATIVA = v_cooperativa.ID_COOPERATIVA;
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
            , 'CARREGANDO DADOS [D_COOPERATIVA_DW]'
            , 'T'
            , 'CARGA DE DE DADOS REALIZADA COM SUCESSO'
        );
    END;

    COMMIT WORK;

EXCEPTION WHEN OTHERS THEN
    ROLLBACK;

    BEGIN
         v_log := DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;

        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [D_COOPERATIVA_DW]'
            , 'F'
            , v_log
        );
    END;

END PRC_IU_D_COOPERATIVA;