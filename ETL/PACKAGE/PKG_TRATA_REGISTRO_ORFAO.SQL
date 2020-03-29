CREATE OR REPLACE PACKAGE PKG_TRATA_REGISTRO_ORFAO AS

    -- D_COOPERATIVA_DS
    FUNCTION get_cooperativa(
        p_id_cooperativa        IN D_COOPERATIVA_DS.ID_COOPERATIVA%TYPE)
    RETURN NUMBER;


    -- D_REDE_PRODUTIVA_DS
    FUNCTION get_rede_produtiva(
        p_id_rede_produtiva     IN D_REDE_PRODUTIVA_DS.ID_REDE_PRODUTIVA%TYPE)
    RETURN NUMBER;

END PKG_TRATA_REGISTRO_ORFAO;

/*-------------------------------  PACKAGE BODY ----------------------*/

CREATE OR REPLACE PACKAGE BODY PKG_TRATA_REGISTRO_ORFAO AS

       /*-- COOPERATIVA --*/
    FUNCTION get_cooperativa(
        p_id_cooperativa IN D_COOPERATIVA_DS.ID_COOPERATIVA%TYPE)
        RETURN NUMBER IS
        v_id_cooperativa D_COOPERATIVA_DS.ID_COOPERATIVA%TYPE;
    BEGIN
        BEGIN
            SELECT ID_COOPERATIVA
            INTO v_id_cooperativa
            FROM D_COOPERATIVA_DS
            where ID_COOPERATIVA = p_id_cooperativa;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_cooperativa := NULL;
        END;

        IF v_id_cooperativa IS NULL THEN
            IF p_id_cooperativa IS NOT NULL THEN
                v_id_cooperativa := p_id_cooperativa;
            ELSE
                v_id_cooperativa := -1;
            END IF;

            BEGIN
                INSERT INTO D_COOPERATIVA_DS(ID_COOPERATIVA,
                                             COOPERATIVA_NOME,
                                             ENDERECO,
                                             CIDADE,
                                             LATITUDE,
                                             LONGITUDE,
                                             SIGLA,
                                             AREA_ATUACAO_ID,
                                             AREA_ATUACAO_DESC,
                                             LOCALIZACAO_ID,
                                             LOCALIZACAO_DESC,
                                             TIPO_ORGANIZACAO_ID,
                                             TIPO_ORGANIZACAO_NOME,
                                             ANO_INICIO,
                                             FG_STATUS_ETL)
                VALUES (v_id_cooperativa,
                        '* não definido *',
                        '* não definido *',
                        '* não definido *',
                        0.0,
                        0.0,
                        '* não definido *',
                        -1,
                        '* não definido *',
                        -1,
                        '* não definido *',
                        -1,
                        '* não definido *',
                        -1,
                        'T');
            EXCEPTION
                WHEN OTHERS THEN
                    INSERT INTO ADM_LOG_DS ( ID_LOG
                                           , PASSO
                                           , TIPO
                                           , ACONTECIMENTO)
                    VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                           , 'REGISTRO_ORFAO[D_COOPERATIVA_DS]'
                           , 'F'
                           , dbms_utility.format_error_backtrace);
            END;
        END IF;

        RETURN v_id_cooperativa;
    END;

    -- REDE PRODUTIVA
    FUNCTION get_rede_produtiva(
        p_id_rede_produtiva IN D_REDE_PRODUTIVA_DS.ID_REDE_PRODUTIVA%TYPE)
        RETURN NUMBER IS
        v_id_rede_produtiva D_REDE_PRODUTIVA_DS.ID_REDE_PRODUTIVA%TYPE;
    BEGIN
        BEGIN
            SELECT ID_REDE_PRODUTIVA
            INTO v_id_rede_produtiva
            FROM D_REDE_PRODUTIVA_DS
            where ID_REDE_PRODUTIVA = p_id_rede_produtiva;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_rede_produtiva := NULL;
        END;

        IF v_id_rede_produtiva IS NULL THEN
            IF p_id_rede_produtiva IS NOT NULL THEN
                v_id_rede_produtiva := p_id_rede_produtiva;
            ELSE
                v_id_rede_produtiva := -1;
            END IF;

            BEGIN
                INSERT INTO D_REDE_PRODUTIVA_DS(ID_REDE_PRODUTIVA,
                                                REDE_PRODUTIVA_DESC,
                                                LATITUDE,
                                                LONGITUDE,
                                                TIPO_REDE_ID,
                                                TIPO_REDE_DESC,
                                                FG_STATUS_ETL)
                VALUES (v_id_rede_produtiva,
                        '* não definido *',
                        0.0,
                        0.0,
                        -1,
                        '* não definido *',
                        'T');
            EXCEPTION
                WHEN OTHERS THEN
                    INSERT INTO ADM_LOG_DS ( ID_LOG
                                           , PASSO
                                           , TIPO
                                           , ACONTECIMENTO)
                    VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                           , 'REGISTRO_ORFAO[D_REDE_PRODUTIVA_DS]'
                           , 'F'
                           , dbms_utility.format_error_backtrace);
            END;
        END IF;

        RETURN v_id_rede_produtiva;
    END;

END PKG_TRATA_REGISTRO_ORFAO;