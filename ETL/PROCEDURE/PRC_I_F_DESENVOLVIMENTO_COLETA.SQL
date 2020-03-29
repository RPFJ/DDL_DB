CREATE OR REPLACE PROCEDURE PRC_I_F_DESENVOLVIMENTO_COLETA(p_excluir IN CHAR) AS
    v_log       ADM_LOG.ACONTECIMENTO%TYPE;
    v_dt_ini    DATE;
    v_dt_fim    DATE;
CURSOR c_dados(aDT_registro DATE) IS
SELECT rede_produtiva.SK_REDE_PRODUTIVA
        , tempo.SK_TEMPO
        , ds.VL_QT_COOPERATIVAS
        , ds.VL_QT_GRUPO_INFORMAL
        , ds.VL_QT_SOCIEDADE_MERCANTIL
        , ds.VL_QT_EMPRESA_RECUPERADA
        , ds.VL_QT_OUTROS
        , ds.VL_AUX_MINISTERIOS
        , ds.VL_AUX_LEIS
        , ds.VL_AUX_PREFEITURA
        , ds.VL_AUX_CNPQ
        , ds.VL_AUX_ASSOC_MERCADO
    FROM F_DESENVOLVIMENTO_COLETA_DS ds
    INNER JOIN BI_USER.D_TEMPO_DW tempo
        ON ds.DT_REGISTRO = TEMPO.day_dt
    INNER JOIN BI_USER.D_REDE_PRODUTIVA_DW rede_produtiva
        ON ds.ID_REDE_PRODUTIVA = rede_produtiva.REDE_PRODUTIVA_ID
    WHERE ds.FG_STATUS_ETL = 'T'
        AND ds.DT_REGISTRO = aDT_registro;

TYPE t_dados IS TABLE OF c_dados%ROWTYPE INDEX BY BINARY_INTEGER;
r_dados t_dados;

BEGIN  
    --log de inicio do processamento
    BEGIN
        INSERT INTO adm_log (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG.NEXTVAL
            , 'CARREGANDO DADOS [PRC_CARREGADA_DADOS]'
            , 'T'
            , 'INICIANDO PROCESSAMENTO'
        );
        COMMIT;
    END;

    -- Deleta registros dos últimos [n] dias - Caso necessário
    BEGIN
        IF p_excluir = 'T' THEN
            SELECT MIN(DT_REGISTRO), MAX(DT_REGISTRO)
            INTO v_dt_ini, v_dt_fim
            FROM F_DESENVOLVIMENTO_COLETA_DS
            WHERE FG_STATUS_ETL = 'T';

            IF (v_dt_ini IS NOT NULL) AND (v_dt_fim IS NOT NULL) THEN
                PKG_APAGA_REGISTROS_DW.DELETE_F_D_COLETA_DW(v_dt_ini, v_dt_fim);
            END IF; 
        END IF;        
    END;

    -- Carega dados no DW
    FOR REG IN (SELECT DT_REGISTRO
                FROM F_DESENVOLVIMENTO_COLETA_DS
                WHERE FG_STATUS_ETL = 'T'
                GROUP BY DT_REGISTRO
                ORDER BY DT_REGISTRO) LOOP

    OPEN c_dados(REG.DT_REGISTRO);
    LOOP
        FETCH c_dados BULK COLLECT INTO r_dados LIMIT 10000;
        EXIT WHEN r_dados.COUNT = 0;
        BEGIN 
            FORALL I IN 1 .. r_dados.COUNT

            INSERT INTO BI_USER.F_DESENVOLVIMENTO_COLETA_DW(
                SK_REDE_PRODUTIVA
                SK_TEMPO
                VL_QT_COOPERATIVAS
                VL_QT_GRUPO_INFORMAL
                VL_QT_SOCIEDADE_MERCANTIL
                VL_QT_EMPRESA_RECUPERADA
                VL_QT_OUTROS
                VL_AUX_MINISTERIOS
                VL_AUX_LEIS
                VL_AUX_PREFEITURA
                VL_AUX_CNPQ
                VL_AUX_ASSOC_MERCADO
            ) VALUES(
                r_dados(I).SK_REDE_PRODUTIVA
                r_dados(I).SK_TEMPO
                r_dados(I).VL_QT_COOPERATIVAS
                r_dados(I).VL_QT_GRUPO_INFORMAL
                r_dados(I).VL_QT_SOCIEDADE_MERCANTIL
                r_dados(I).VL_QT_EMPRESA_RECUPERADA
                r_dados(I).VL_QT_OUTROS
                r_dados(I).VL_AUX_MINISTERIOS
                r_dados(I).VL_AUX_LEIS
                r_dados(I).VL_AUX_PREFEITURA
                r_dados(I).VL_AUX_CNPQ
                r_dados(I).VL_AUX_ASSOC_MERCADO
            );
        EXCEPTION WHEN OTHERS THEN 
            v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] '; 
            
            INSERT INTO adm_log (
                ID_LOG
                , PASSO
                , TIPO
                , ACONTECIMENTO
            ) VALUES (
                SEQ_ADM_LOG.NEXTVAL
                , 'CARGA DE DADOS[PRC_I_F_DESENVOLVIMENTO_COLETA]'
                , 'F'
                , v_log
            );
        END;
    
     END LOOP;
    
    COMMIT WORK;
    CLOSE C_DADOS;
    END LOOP; -- FOR REG

    BEGIN 
        UPDATE F_DESENVOLVIMENTO_COLETA_DW 
        SET FG_STATUS_ETL = 'L'
        WHERE FG_STATUS_ETL = 'T';
    END;

    BEGIN
        INSERT INTO adm_log (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG.NEXTVAL
            , 'CARREGANDO DADOS [PRC_I_F_DESENVOLVIMENTO_COLETA]'
            , 'T'
            , 'cARGA DE DADOS REALIZADA COM SUCESSO'
        );
    END;

    COMMIT WORK;

EXCEPTION WHEN OTHERS THEN
    ROLLBACK;

    BEGIN
        v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] '; 
        
        INSERT INTO adm_log (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG.NEXTVAL
            , 'CARGA DE DADOS[PRC_I_F_DESENVOLVIMENTO_COLETA]'
            , 'F'
            , v_log
        );
        
        COMMIT;
    END;

END PRC_I_F_EVOLUCAO; 