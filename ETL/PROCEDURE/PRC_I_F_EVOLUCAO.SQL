CREATE OR REPLACE PROCEDURE PRC_I_F_EVOLUCAO AS 
    v_log       ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_dt_ini    DATE;
    v_dt_fim    DATE;

CURSOR c_dados(aDT_registro DATE) IS
SELECT cooperativa.SK_COOPERATIVA
       , tempo.SK_TEMPO
       , rede_produtiva.SK_REDE_PRODUTIVA
       , ds.ID_EVOLUCAO
       , ds.VL_GERACAO_RENDA
       , ds.VL_N_HOMENS
       , ds.VL_N_MULHERES
       , ds.FG_ACESSO_COMPUTADOR
       , ds.FG_ACESSO_INTERNET
    FROM F_EVOLUCAO_DS ds
    INNER JOIN BI_USER.D_TEMPO_DW tempo
        ON ds.DT_REGISTRO = TEMPO.DATE_ID
    INNER JOIN BI_USER.D_COOPERATIVA_DW cooperativa
        ON ds.ID_COOPERATIVA = cooperativa.COOPERATIVA_ID
    INNER JOIN BI_USER.D_REDE_PRODUTIVA_DW rede_produtiva
        ON ds.ID_REDE_PRODUTIVA = rede_produtiva.REDE_PRODUTIVA_ID
    WHERE ds.FG_STATUS_ETL = 'T'
        AND ds.DT_REGISTRO = aDT_registro;

TYPE t_dados IS TABLE OF c_dados%ROWTYPE INDEX BY BINARY_INTEGER;
r_dados t_dados;

BEGIN  
    --log de inicio do processamento
    BEGIN
        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [PRC_CARREGADA_DADOS]'
            , 'T'
            , 'INICIANDO CARREGAMENTO DAS INFORMAÇÕES'
        );
        COMMIT;
    END;

    -- Carega dados no DW
    FOR REG IN (SELECT DT_REGISTRO
                FROM F_EVOLUCAO_DS
                WHERE FG_STATUS_ETL = 'T'
                GROUP BY DT_REGISTRO
                ORDER BY DT_REGISTRO) LOOP

    OPEN c_dados(REG.DT_REGISTRO);
    LOOP
        FETCH c_dados BULK COLLECT INTO r_dados LIMIT 10000;
        EXIT WHEN r_dados.COUNT = 0;
        BEGIN 
            FORALL I IN 1 .. r_dados.COUNT

            INSERT INTO BI_USER.F_EVOLUCAO_DW(
                SK_COOPERATIVA
                , SK_TEMPO
                , SK_REDE_PRODUTIVA
                , ID_EVOLUCAO
                , VL_GERACAO_RENDA
                , VL_N_HOMENS
                , VL_N_MULHERES
                , FG_ACESSO_COMPUTADOR
                , FG_ACESSO_INTERNET
            ) VALUES(
               r_dados(I).SK_COOPERATIVA
                , r_dados(I).SK_TEMPO
                , r_dados(I).SK_REDE_PRODUTIVA
                , r_dados(I).ID_EVOLUCAO
                , r_dados(I).VL_GERACAO_RENDA
                , r_dados(I).VL_N_HOMENS
                , r_dados(I).VL_N_MULHERES
                , r_dados(I).FG_ACESSO_COMPUTADOR
                , r_dados(I).FG_ACESSO_INTERNET
            );
        EXCEPTION WHEN OTHERS THEN 
            v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] '; 

            INSERT INTO ADM_LOG_DS (
                ID_LOG
                , PASSO
                , TIPO
                , ACONTECIMENTO
            ) VALUES (
                SEQ_ADM_LOG_DS.NEXTVAL
                , 'CARGA DE DADOS[PRC_I_F_EVOLUCAO]'
                , 'F'
                , v_log
            );
        END;

     END LOOP;

    COMMIT WORK;
    CLOSE C_DADOS;
    END LOOP; -- FOR REG

    BEGIN 
        UPDATE F_EVOLUCAO_DS 
        SET FG_STATUS_ETL = 'L'
        WHERE FG_STATUS_ETL = 'T';
    END;

    BEGIN
        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARREGANDO DADOS [PRC_I_F_EVOLUCAO]'
            , 'T'
            , 'cARGA DE DADOS REALIZADA COM SUCESSO'
        );
    END;

    COMMIT WORK;

EXCEPTION WHEN OTHERS THEN
    ROLLBACK;

    BEGIN
        v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] '; 

        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARGA DE DADOS[PRC_I_F_EVOLUCAO]'
            , 'F'
            , v_log
        );

        COMMIT;
    END;

END PRC_I_F_EVOLUCAO;