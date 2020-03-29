create or replace NONEDITIONABLE PROCEDURE PRC_I_F_DESENVOLVIMENTO_COLETA(p_excluir IN CHAR) AS
    v_log       ADM_LOG_DS.ACONTECIMENTO%TYPE;
    v_dt_ini    DATE;
    v_dt_fim    DATE;
CURSOR c_dados(aDT_registro DATE) IS
SELECT rede_produtiva.SK_REDE_PRODUTIVA
        , tempo.SK_TEMPO
        , ds.VL_FNT_EMPREENDIMENTO
        , ds.VL_FNT_PREFEITURA
        , ds.VL_FNT_CONDOMINIOS
        , ds.VL_FNT_COMPRA
        , ds.VL_COL_MANUAL
        , ds.VL_COL_PREFEITURA
        , ds.VL_COL_EMPREENDIMENTO
        , ds.VL_COL_DOACAO
        , ds.VL_ATV_TROCA
        , ds.VL_ATV_PRODUCAO
        , ds.VL_ATV_COMERCIALIZACAO
        , ds.VL_ATV_SERVICOS
        , ds.VL_ATV_FINANCEIRO
        , ds.VL_ATV_CONSUMO
        , ds.VL_VND_CONSUMIDOR
        , ds.VL_VND_REVENDEDOR
        , ds.VL_VND_GOVERNO
        , ds.VL_VND_EMPRESA
        , ds.VL_VND_E_SOLIDARIA
    FROM F_DESENVOLVIMENTO_COLETA_DS ds
    INNER JOIN BI_USER.D_TEMPO_DW tempo
        ON ds.DT_REGISTRO = TEMPO.DATE_ID
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
                , SK_TEMPO
                , VL_FNT_EMPREENDIMENTO
                , VL_FNT_PREFEITURA
                , VL_FNT_CONDOMINIOS
                , VL_FNT_COMPRA
                , VL_COL_MANUAL
                , VL_COL_PREFEITURA
                , VL_COL_EMPREENDIMENTO
                , VL_COL_DOACAO
                , VL_ATV_TROCA
                , VL_ATV_PRODUCAO
                , VL_ATV_COMERCIALIZACAO
                , VL_ATV_SERVICOS
                , VL_ATV_FINANCEIRO
                , VL_ATV_CONSUMO
                , VL_VND_CONSUMIDOR
                , VL_VND_REVENDEDOR
                , VL_VND_GOVERNO
                , VL_VND_EMPRESA
                , VL_VND_E_SOLIDARIA
            ) VALUES(
                r_dados(I).SK_REDE_PRODUTIVA
                , r_dados(I).SK_TEMPO
                , r_dados(I).VL_FNT_EMPREENDIMENTO
                , r_dados(I).VL_FNT_PREFEITURA
                , r_dados(I).VL_FNT_CONDOMINIOS
                , r_dados(I).VL_FNT_COMPRA
                , r_dados(I).VL_COL_MANUAL
                , r_dados(I).VL_COL_PREFEITURA
                , r_dados(I).VL_COL_EMPREENDIMENTO
                , r_dados(I).VL_COL_DOACAO
                , r_dados(I).VL_ATV_TROCA
                , r_dados(I).VL_ATV_PRODUCAO
                , r_dados(I).VL_ATV_COMERCIALIZACAO
                , r_dados(I).VL_ATV_SERVICOS
                , r_dados(I).VL_ATV_FINANCEIRO
                , r_dados(I).VL_ATV_CONSUMO
                , r_dados(I).VL_VND_CONSUMIDOR
                , r_dados(I).VL_VND_REVENDEDOR
                , r_dados(I).VL_VND_GOVERNO
                , r_dados(I).VL_VND_EMPRESA
                , r_dados(I).VL_VND_E_SOLIDARIA
            );
        EXCEPTION WHEN OTHERS THEN
            v_log := 'FALHA NO CARREGAMENTO DE DADOS [' || SQLERRM || ']' || 'ERROR ['|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE || '] ';

            INSERT INTO ADM_LOG_DS(
                ID_LOG
                , PASSO
                , TIPO
                , ACONTECIMENTO
            ) VALUES (
                SEQ_ADM_LOG_DS.NEXTVAL
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
        UPDATE F_DESENVOLVIMENTO_COLETA_DS
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

        INSERT INTO ADM_LOG_DS (
            ID_LOG
            , PASSO
            , TIPO
            , ACONTECIMENTO
        ) VALUES (
            SEQ_ADM_LOG_DS.NEXTVAL
            , 'CARGA DE DADOS[PRC_I_F_DESENVOLVIMENTO_COLETA]'
            , 'F'
            , v_log
        );

        COMMIT;
    END;

END PRC_I_F_DESENVOLVIMENTO_COLETA;