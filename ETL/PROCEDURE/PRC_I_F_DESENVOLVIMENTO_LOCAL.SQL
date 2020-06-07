create or replace NONEDITIONABLE PROCEDURE PRC_I_F_DESENVOLVIMENTO_LOCAL(p_excluir IN CHAR) AS
    v_log    ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_dt_ini DATE;
    v_dt_fim DATE;
    CURSOR c_dados(aDT_registro DATE) IS
        SELECT empreendimento.SK_EMPREENDIMENTO
             , r_economica.SK_REDE_ECONOMICA
             , tempo.SK_TEMPO
             , g_renda.SK_GERACAO_RENDA
             , questao.SK_QUESTAO
             , ds.VL_QUANTIDADE
        FROM F_DESENVOLVIMENTO_LOCAL_DS ds
                 INNER JOIN BI_USER.D_TEMPO_DW tempo
                            ON ds.DT_REGISTRO = TEMPO.DATE_ID
                 INNER JOIN BI_USER.D_EMPREENDIMENTO_DW empreendimento
                            ON ds.ID_EMPREENDIMENTO = empreendimento.ID_EMPREENDIMENTO
                 INNER JOIN BI_USER.D_GERACAO_RENDA_DW g_renda
                            ON ds.ID_GERACAO_RENDA = g_renda.ID_GERACAO_RENDA
                 INNER JOIN BI_USER.D_QUESTAO_DW questao
                            ON ds.ID_GERACAO_RENDA = questao.ID_QUESTAO
                 INNER JOIN BI_USER.D_REDE_ECONOMICA_DW r_economica
                            ON ds.ID_REDE_ECONOMICA = r_economica.ID_REDE_ECONOMICA
        WHERE ds.FG_STATUS_ETL = 'T'
          AND ds.DT_REGISTRO = aDT_registro;
    TYPE t_dados IS TABLE OF c_dados%ROWTYPE INDEX BY BINARY_INTEGER;
    r_dados  t_dados;

BEGIN
    --log de inicio do processamento
    BEGIN
        INSERT INTO ADM_LOG_DS ( ID_LOG
                               , PASSO
                               , TIPO
                               , ACONTECIMENTO)
        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
               , 'CARREGANDO DADOS [PRC_I_F_DESENVOLVIMENTO_LOCAL]'
               , 'T'
               , 'INICIANDO PROCESSAMENTO');
        COMMIT;
    END;

    -- Deleta registros dos últimos [n] dias - Caso necessário
    BEGIN
        IF p_excluir = 'T' THEN
            SELECT MIN(DT_REGISTRO), MAX(DT_REGISTRO)
            INTO v_dt_ini, v_dt_fim
            FROM F_DESENVOLVIMENTO_LOCAL_DS
            WHERE FG_STATUS_ETL = 'T';

            IF (v_dt_ini IS NOT NULL) AND (v_dt_fim IS NOT NULL) THEN
                PKG_APAGA_REGISTROS_DW.DELETE_F_D_LOCAL_DW(v_dt_ini, v_dt_fim);
            END IF;
        END IF;
    END;

    -- Carega dados no DW
    FOR REG IN (SELECT DT_REGISTRO
                FROM F_DESENVOLVIMENTO_LOCAL_DS
                WHERE FG_STATUS_ETL = 'T'
                GROUP BY DT_REGISTRO
                ORDER BY DT_REGISTRO)
        LOOP

            OPEN c_dados(REG.DT_REGISTRO);
            LOOP
                FETCH c_dados BULK COLLECT INTO r_dados LIMIT 10000;
                EXIT WHEN r_dados.COUNT = 0;
                BEGIN
                    FORALL I IN 1 .. r_dados.COUNT
                        INSERT INTO BI_USER.F_DESENVOLVIMENTO_LOCAL_DW( SK_EMPREENDIMENTO
                                                                      , SK_REDE_ECONOMICA
                                                                      , SK_TEMPO
                                                                      , SK_GERACAO_RENDA
                                                                      , SK_QUESTAO
                                                                      , VL_QUANTIDADE)
                        VALUES ( r_dados(I).SK_EMPREENDIMENTO
                               , r_dados(I).SK_REDE_ECONOMICA
                               , r_dados(I).SK_TEMPO
                               , r_dados(I).SK_GERACAO_RENDA
                               , r_dados(I).SK_QUESTAO
                               , r_dados(I).VL_QUANTIDADE);
                EXCEPTION
                    WHEN OTHERS THEN
                        v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR [' ||
                                 DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] ';

                        INSERT INTO ADM_LOG_DS ( ID_LOG
                                               , PASSO
                                               , TIPO
                                               , ACONTECIMENTO)
                        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                               , 'CARGA DE DADOS[PRC_I_F_DESENVOLVIMENTO_LOCAL]'
                               , 'F'
                               , v_log);
                END;

            END LOOP;

            COMMIT WORK;
            CLOSE C_DADOS;
        END LOOP; -- FOR REG

    BEGIN
        UPDATE F_DESENVOLVIMENTO_LOCAL_DS
        SET FG_STATUS_ETL = 'L'
        WHERE FG_STATUS_ETL = 'T';
    END;

    BEGIN
        INSERT INTO ADM_LOG_DS ( ID_LOG
                               , PASSO
                               , TIPO
                               , ACONTECIMENTO)
        VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
               , 'CARREGANDO DADOS [PRC_I_F_DESENVOLVIMENTO_LOCAL]'
               , 'T'
               , 'cARGA DE DADOS REALIZADA COM SUCESSO');
    END;

    COMMIT WORK;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;

        BEGIN
            v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR [' ||
                     DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] ';

            INSERT INTO ADM_LOG_DS ( ID_LOG
                                   , PASSO
                                   , TIPO
                                   , ACONTECIMENTO)
            VALUES ( SEQ_ADM_LOG_DS.NEXTVAL
                   , 'CARGA DE DADOS[PRC_I_F_DESENVOLVIMENTO_LOCAL]'
                   , 'F'
                   , v_log);

            COMMIT;
        END;

END PRC_I_F_DESENVOLVIMENTO_LOCAL;