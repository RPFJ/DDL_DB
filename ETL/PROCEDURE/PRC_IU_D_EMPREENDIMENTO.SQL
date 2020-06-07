create or replace NONEDITIONABLE PROCEDURE PRC_IU_D_EMPREENDIMENTO AS
    v_log           ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_fg_status_etl D_EMPREENDIMENTO_DS.FG_STATUS_ETL%TYPE;
    CURSOR v_empreendimento_cursor IS
        SELECT *
        FROM D_EMPREENDIMENTO_DS
        WHERE FG_STATUS_ETL = 'T';
BEGIN
    FOR v_empreendimento IN v_empreendimento_cursor
        LOOP
            v_fg_status_etl := 'L';
            BEGIN
                INSERT INTO BI_USER.D_EMPREENDIMENTO_DW( SK_EMPREENDIMENTO
                                                       , ID_EMPREENDIMENTO
                                                       , NOME_EMPREENDIMENTO
                                                       , ENDERECO
                                                       , CIDADE
                                                       , LATITUDE
                                                       , LONGITUDE
                                                       , SIGLA
                                                       , ID_AREA_ATUACAO
                                                       , DESC_AREA_ATUACAO
                                                       , ID_LOCALIZACAO
                                                       , DESC_LOCALIZACAO
                                                       , ID_TIPO_ORGANIZACAO
                                                       , DESC_TIPO_ORGANIZACAO
                                                       , ANO_INICIO)
                VALUES ( BI_USER.SEQ_D_EMPREENDIMENTO.NEXTVAL
                       , v_empreendimento.ID_EMPREENDIMENTO
                       , v_empreendimento.NOME_EMPREENDIMENTO
                       , v_empreendimento.ENDERECO
                       , v_empreendimento.CIDADE
                       , v_empreendimento.LATITUDE
                       , v_empreendimento.LONGITUDE
                       , v_empreendimento.SIGLA
                       , v_empreendimento.ID_AREA_ATUACAO
                       , v_empreendimento.DESC_AREA_ATUACAO
                       , v_empreendimento.ID_LOCALIZACAO
                       , v_empreendimento.DESC_LOCALIZACAO
                       , v_empreendimento.ID_TIPO_ORGANIZACAO
                       , v_empreendimento.DESC_TIPO_ORGANIZACAO
                       , v_empreendimento.ANO_INICIO);

            EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN
                    UPDATE BI_USER.D_EMPREENDIMENTO_DW
                    SET NOME_EMPREENDIMENTO   = v_empreendimento.NOME_EMPREENDIMENTO
                      , ENDERECO              = v_empreendimento.ENDERECO
                      , CIDADE                = v_empreendimento.CIDADE
                      , LATITUDE              = v_empreendimento.LATITUDE
                      , LONGITUDE             = v_empreendimento.LONGITUDE
                      , SIGLA                 = v_empreendimento.SIGLA
                      , ID_AREA_ATUACAO       = v_empreendimento.ID_AREA_ATUACAO
                      , DESC_AREA_ATUACAO     = v_empreendimento.DESC_AREA_ATUACAO
                      , ID_LOCALIZACAO        = v_empreendimento.ID_LOCALIZACAO
                      , DESC_LOCALIZACAO      = v_empreendimento.DESC_LOCALIZACAO
                      , ID_TIPO_ORGANIZACAO   = v_empreendimento.ID_TIPO_ORGANIZACAO
                      , DESC_TIPO_ORGANIZACAO = v_empreendimento.DESC_TIPO_ORGANIZACAO
                      , ANO_INICIO            = v_empreendimento.ANO_INICIO
                      , DT_ALTERACAO_DW       = SYSDATE
                    WHERE ID_EMPREENDIMENTO = v_empreendimento.ID_EMPREENDIMENTO;
                WHEN OTHERS THEN
                    v_fg_status_etl := 'F';
            END;

            BEGIN
                UPDATE D_EMPREENDIMENTO_DS
                SET FG_STATUS_ETL = v_fg_status_etl
                WHERE ID_EMPREENDIMENTO = v_empreendimento.ID_EMPREENDIMENTO;
            END;
        END LOOP;

    BEGIN
        INSERT INTO ADM_LOG_DS ( ID_LOG
                               , PASSO
                               , TIPO
                               , ACONTECIMENTO)
        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
               , 'CARREGANDO DADOS [D_EMPREENDIMENTO_DW]'
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
                   , 'CARREGANDO DADOS [D_EMPREENDIMENTO_DW]'
                   , 'F'
                   , v_log);
        END;

END PRC_IU_D_EMPREENDIMENTO;