create or replace PACKAGE PKG_TRANSFORMA_DADOS AS

    -- Procedures de transformação de cada uma das fatos do DS
    PROCEDURE T_F_EVOLUCAO;
    PROCEDURE T_F_DESENVOLVIMENTO_LOCAL;

END PKG_TRANSFORMA_DADOS;

create or replace PACKAGE BODY PKG_TRANSFORMA_DADOS AS

    -- F_EVOLUCAO
    PROCEDURE T_F_EVOLUCAO AS
        CURSOR C_CURSOR(aDT_registro DATE) IS
            SELECT rowid
                 , id_empreendimento
                 , id_rede_economica
                 , id_geracao_renda
            FROM F_EVOLUCAO_DS
            WHERE FG_STATUS_ETL = 'E'
              AND DT_REGISTRO = aDT_registro;
        TYPE TYPE_CURSOR IS TABLE OF C_CURSOR%ROWTYPE INDEX BY BINARY_INTEGER;
        R_CURSOR            TYPE_CURSOR;
        v_id_empreendimento D_EMPREENDIMENTO_DS.id_empreendimento%TYPE;
        v_id_geracao_renda  D_GERACAO_RENDA_DS.id_geracao_renda%TYPE;
        v_id_rede_economica D_REDE_ECONOMICA_DS.id_rede_economica%TYPE;

    BEGIN
        FOR REG IN (SELECT DT_REGISTRO
                    FROM F_EVOLUCAO_DS
                    WHERE FG_STATUS_ETL = 'E'
                    GROUP BY DT_REGISTRO
                    ORDER BY DT_REGISTRO)
            LOOP

                OPEN C_CURSOR(REG.DT_REGISTRO);

                LOOP
                    -- Popula o cursor de 10000 em 10000 registros
                    FETCH C_CURSOR
                        BULK COLLECT INTO R_CURSOR
                        LIMIT 10000;
                    EXIT WHEN R_CURSOR.COUNT = 0;

                    FOR I IN 1 .. R_CURSOR.COUNT
                        LOOP

                            v_id_empreendimento :=
                                    PKG_TRATA_REGISTRO_ORFAO.GET_EMPREENDIMENTO(R_CURSOR(I).id_empreendimento);
                            v_id_geracao_renda := PKG_TRATA_REGISTRO_ORFAO.GET_GERACAO_RENDA(
                                    R_CURSOR(I).id_geracao_renda);
                            v_id_rede_economica := PKG_TRATA_REGISTRO_ORFAO.GET_REDE_ECONOMICA(
                                    R_CURSOR(I).id_rede_economica);

                            BEGIN
                                UPDATE F_EVOLUCAO_DS
                                SET id_empreendimento = v_id_empreendimento
                                  , id_geracao_renda  = v_id_geracao_renda
                                  , id_rede_economica = v_id_geracao_renda
                                  , FG_STATUS_ETL     = 'T'
                                WHERE rowid = R_CURSOR(I).rowid;
                            END;

                        END LOOP;

                    -- Commit depois de 10000 registros
                    COMMIT;
                END LOOP C_CURSOR;

                CLOSE C_CURSOR;
            END LOOP;
    END ;


    -- F_DESENVOLVIMENTO_LOCAL_DS
    PROCEDURE T_F_DESENVOLVIMENTO_LOCAL AS
        CURSOR C_CURSOR(aDT_registro DATE) IS
            SELECT rowid
                 , id_empreendimento
                 , id_rede_economica
                 , id_geracao_renda
                 , id_questao
                 , id_resposta
            FROM F_DESENVOLVIMENTO_LOCAL_DS
            WHERE FG_STATUS_ETL = 'E'
              AND DT_REGISTRO = aDT_registro;
        TYPE TYPE_CURSOR IS TABLE OF C_CURSOR%ROWTYPE INDEX BY BINARY_INTEGER;
        R_CURSOR            TYPE_CURSOR;
        v_id_empreendimento D_EMPREENDIMENTO_DS.id_empreendimento%TYPE;
        v_id_geracao_renda  D_GERACAO_RENDA_DS.id_geracao_renda%TYPE;
        v_id_questao        D_QUESTAO_DS.id_questao%TYPE;
        v_id_resposta       D_QUESTAO_DS.id_resposta%TYPE;
        v_id_rede_economica D_REDE_ECONOMICA_DS.id_rede_economica%TYPE;
        v_questao           typ_questao;

    BEGIN
        FOR REG IN (SELECT DT_REGISTRO
                    FROM F_DESENVOLVIMENTO_LOCAL_DS
                    WHERE FG_STATUS_ETL = 'E'
                    GROUP BY DT_REGISTRO
                    ORDER BY DT_REGISTRO)
            LOOP

                OPEN C_CURSOR(REG.DT_REGISTRO);

                LOOP
                    -- Popula o cursor de 10000 em 10000 registros
                    FETCH C_CURSOR
                        BULK COLLECT INTO R_CURSOR
                        LIMIT 10000;
                    EXIT WHEN R_CURSOR.COUNT = 0;

                    FOR I IN 1 .. R_CURSOR.COUNT
                        LOOP
                            v_questao := PKG_TRATA_REGISTRO_ORFAO.GET_QUESTAO(R_CURSOR(I).id_questao, R_CURSOR(I).id_resposta);
                            v_id_questao := v_questao.id_questao;
                            v_id_resposta := v_questao.id_resposta;

                            v_id_empreendimento := PKG_TRATA_REGISTRO_ORFAO.GET_EMPREENDIMENTO(
                                    R_CURSOR(I).id_empreendimento);
                            v_id_geracao_renda := PKG_TRATA_REGISTRO_ORFAO.GET_GERACAO_RENDA(
                                    R_CURSOR(I).id_geracao_renda);
                            v_id_rede_economica := PKG_TRATA_REGISTRO_ORFAO.GET_REDE_ECONOMICA(
                                    R_CURSOR(I).id_rede_economica);

                            BEGIN
                                UPDATE F_DESENVOLVIMENTO_LOCAL_DS
                                SET id_empreendimento = v_id_empreendimento
                                  , id_rede_economica = v_id_rede_economica
                                  , id_geracao_renda  = v_id_geracao_renda
                                  , id_questao        = v_id_questao
                                  , id_resposta        = v_id_resposta
                                  , FG_STATUS_ETL     = 'T'
                                WHERE rowid = R_CURSOR(I).rowid;
                            END;

                        END LOOP;

                    -- Commit depois de 10000 registros
                    COMMIT;
                END LOOP C_CURSOR;

                CLOSE C_CURSOR;
            END LOOP;
    END ;

END PKG_TRANSFORMA_DADOS;