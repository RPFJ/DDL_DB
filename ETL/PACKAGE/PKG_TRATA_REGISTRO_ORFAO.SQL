CREATE OR REPLACE TYPE "TYP_QUESTAO" AS OBJECT
(
    id_questao  NUMBER,
    id_resposta NUMBER
);
CREATE OR REPLACE  PACKAGE PKG_TRATA_REGISTRO_ORFAO AS

    -- D_EMPREENDIMENTO_DS
    FUNCTION get_empreendimento(
        p_id_empreendimento IN D_EMPREENDIMENTO_DS.ID_EMPREENDIMENTO%TYPE)
        RETURN NUMBER;

    -- D_GERACAO_RENDA_DS
    FUNCTION get_geracao_renda(
        p_id_geracao_renda IN D_GERACAO_RENDA_DS.ID_GERACAO_RENDA%TYPE)
        RETURN NUMBER;

    -- D_QUESTAO_DS
    FUNCTION get_questao(p_id_questao IN D_QUESTAO_DS.ID_QUESTAO%TYPE,
                         p_id_resposta IN D_QUESTAO_DS.ID_RESPOSTA%TYPE)
        RETURN typ_questao;

    -- D_REDE_ECONOMICA_DS
    FUNCTION get_rede_economica(
        p_id_rede_economica IN D_REDE_ECONOMICA_DS.ID_REDE_ECONOMICA%TYPE)
        RETURN NUMBER;

END PKG_TRATA_REGISTRO_ORFAO;

/*-------------------------------  PACKAGE BODY ----------------------*/

CREATE OR REPLACE PACKAGE BODY PKG_TRATA_REGISTRO_ORFAO AS

    /*-- D_EMPREENDIMENTO_DS --*/
    FUNCTION get_empreendimento(
        p_id_empreendimento IN D_EMPREENDIMENTO_DS.ID_EMPREENDIMENTO%TYPE)
        RETURN NUMBER IS
        v_id_empreendimento D_EMPREENDIMENTO_DS.ID_EMPREENDIMENTO%TYPE;
    BEGIN
        BEGIN
            SELECT ID_EMPREENDIMENTO
            INTO v_id_empreendimento
            FROM D_EMPREENDIMENTO_DS
            where ID_EMPREENDIMENTO = p_id_empreendimento;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_empreendimento := NULL;
        END;

        IF v_id_empreendimento IS NULL THEN
            IF p_id_empreendimento IS NOT NULL THEN
                v_id_empreendimento := p_id_empreendimento;
            ELSE
                v_id_empreendimento := -1;
            END IF;

            BEGIN
                INSERT INTO D_EMPREENDIMENTO_DS(
                        ID_EMPREENDIMENTO
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
                        , ANO_INICIO
                        , FG_STATUS_ETL
                ) VALUES (v_id_empreendimento,
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
                           , 'REGISTRO_ORFAO[D_EMPREENDIMENTO_DS]'
                           , 'F'
                           , dbms_utility.format_error_backtrace);
            END;
        END IF;

        RETURN v_id_empreendimento;
    END;

    /*-- D_GERACAO_RENDA_DS --*/
    FUNCTION get_geracao_renda(
        p_id_geracao_renda IN D_GERACAO_RENDA_DS.ID_GERACAO_RENDA%TYPE)
        RETURN NUMBER IS
        v_id_geracao_renda D_GERACAO_RENDA_DS.ID_GERACAO_RENDA%TYPE;
    BEGIN
        BEGIN
            SELECT ID_GERACAO_RENDA
            INTO v_id_geracao_renda
            FROM D_GERACAO_RENDA_DS
            where ID_GERACAO_RENDA = p_id_geracao_renda;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_geracao_renda := NULL;
        END;

        IF v_id_geracao_renda IS NULL THEN
            IF p_id_geracao_renda IS NOT NULL THEN
                v_id_geracao_renda := p_id_geracao_renda;
            ELSE
                v_id_geracao_renda := -1;
            END IF;

            BEGIN
                INSERT INTO D_GERACAO_RENDA_DS(
                        ID_GERACAO_RENDA
                        , DESC_GERACAO_RENDA
                        , FG_STATUS_ETL
                ) VALUES (v_id_geracao_renda,
                        '* não definido *',
                        'T');
            EXCEPTION
                WHEN OTHERS THEN
                    INSERT INTO ADM_LOG_DS ( ID_LOG
                                           , PASSO
                                           , TIPO
                                           , ACONTECIMENTO)
                    VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                           , 'REGISTRO_ORFAO[D_GERACAO_RENDA_DS]'
                           , 'F'
                           , dbms_utility.format_error_backtrace);
            END;
        END IF;

        RETURN v_id_geracao_renda;
    END;

    /*-- D_QUESTAO_DS --*/
    FUNCTION get_questao(
        p_id_questao    IN D_QUESTAO_DS.ID_QUESTAO%TYPE,
        p_id_resposta   IN D_QUESTAO_DS.ID_RESPOSTA%TYPE)
        RETURN typ_questao IS
        v_id_questao D_QUESTAO_DS.ID_QUESTAO%TYPE;
        v_id_resposta D_QUESTAO_DS.ID_RESPOSTA%TYPE;
        v_questao       typ_questao;
    BEGIN
        BEGIN
            SELECT ID_QUESTAO, ID_RESPOSTA
            INTO v_id_questao, v_id_resposta
            FROM D_QUESTAO_DS
            where ID_QUESTAO = p_id_questao
            AND ID_RESPOSTA = p_id_resposta;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_questao := NULL;
                v_id_resposta := NULL;

        END;

        IF v_id_questao IS NULL THEN
            IF p_id_questao IS NOT NULL THEN
                v_id_questao := p_id_questao;
            ELSE
                v_id_questao := -1;
            END IF;

            IF p_id_resposta IS NOT NULL THEN
                v_id_resposta := p_id_resposta;
            ELSE
                v_id_resposta := -1;
            END IF;


            BEGIN
                INSERT INTO D_QUESTAO_DS(
                     ID_QUESTAO
                    , ID_RESPOSTA
                    , DESC_QUESTAO
                    , DESC_RESPOSTA
                    , FG_STATUS_ETL
                ) VALUES (v_id_questao
                    , v_id_resposta
                    , '* não definido *'
                    , '* não definido *'
                    , 'T');
            EXCEPTION
                WHEN OTHERS THEN
                    INSERT INTO ADM_LOG_DS ( ID_LOG
                                           , PASSO
                                           , TIPO
                                           , ACONTECIMENTO)
                    VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                           , 'REGISTRO_ORFAO[D_QUESTAO_DS]'
                           , 'F'
                           , dbms_utility.format_error_backtrace);
            END;
        END IF;

        v_questao := typ_questao(v_id_questao, v_id_resposta);

        RETURN v_questao;
    END;

    -- REDE ECONOMICA
    FUNCTION get_rede_economica(
        p_id_rede_economica IN D_REDE_ECONOMICA_DS.ID_REDE_ECONOMICA%TYPE)
        RETURN NUMBER IS
        v_id_rede_economica D_REDE_ECONOMICA_DS.ID_REDE_ECONOMICA%TYPE;
    BEGIN
        BEGIN
            SELECT ID_REDE_ECONOMICA
            INTO v_id_rede_economica
            FROM D_REDE_ECONOMICA_DS
            where ID_REDE_ECONOMICA = p_id_rede_economica;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_id_rede_economica := NULL;
        END;

        IF v_id_rede_economica IS NULL THEN
            IF p_id_rede_economica IS NOT NULL THEN
                v_id_rede_economica := p_id_rede_economica;
            ELSE
                v_id_rede_economica := -1;
            END IF;

            BEGIN
                INSERT INTO D_REDE_ECONOMICA_DS(ID_REDE_ECONOMICA,
                                                DESC_REDE_ECONOMICA,
                                                LATITUDE,
                                                LONGITUDE,
                                                ID_TIPO_REDE,
                                                DESC_TIPO_REDE,
                                                FG_STATUS_ETL)
                VALUES (v_id_rede_economica,
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
                           , 'REGISTRO_ORFAO[D_REDE_ECONOMICA_DS]'
                           , 'F'
                           , dbms_utility.format_error_backtrace);
            END;
        END IF;

        RETURN v_id_rede_economica;
    END;

END PKG_TRATA_REGISTRO_ORFAO;