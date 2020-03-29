CREATE OR REPLACE PACKAGE PKG_TRANSFORMA_DADOS AS


    PROCEDURE T_F_EVOLUCAO;
    PROCEDURE T_F_DESENVOLVIMENTO_LOCAL;
    PROCEDURE T_F_DESENVOLVIMENTO_COLETA;


END PKG_TRANSFORMA_DADOS;

CREATE OR REPLACE PACKAGE BODY PKG_TRANSFORMA_DADOS AS

    -- F_EVOLUCAO
    PROCEDURE T_F_EVOLUCAO AS
        CURSOR C_CURSOR(aDT_registro DATE) IS
            SELECT rowid
                 , id_cooperativa
                 , id_rede_produtiva
            FROM F_EVOLUCAO_DS
            WHERE FG_STATUS_ETL = 'E'
              AND DT_REGISTRO = aDT_registro;
        TYPE TYPE_CURSOR IS TABLE OF C_CURSOR%ROWTYPE INDEX BY BINARY_INTEGER;
        R_CURSOR            TYPE_CURSOR;
        v_id_cooperativa    D_COOPERATIVA_DS.id_cooperativa%TYPE;
        v_id_rede_produtiva D_REDE_PRODUTIVA_DS.id_rede_produtiva%TYPE;

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

                            v_id_cooperativa := PKG_TRATA_REGISTRO_ORFAO.GET_COOPERATIVA(R_CURSOR(I).id_cooperativa);
                            v_id_rede_produtiva := PKG_TRATA_REGISTRO_ORFAO.GET_REDE_PRODUTIVA(
                                    R_CURSOR(I).id_rede_produtiva);

                            BEGIN
                                UPDATE F_EVOLUCAO_DS
                                SET id_cooperativa    = v_id_cooperativa
                                  , id_rede_produtiva = v_id_rede_produtiva
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
                 , id_rede_produtiva
            FROM F_DESENVOLVIMENTO_LOCAL_DS
            WHERE FG_STATUS_ETL = 'E'
              AND DT_REGISTRO = aDT_registro;
        TYPE TYPE_CURSOR IS TABLE OF C_CURSOR%ROWTYPE INDEX BY BINARY_INTEGER;
        R_CURSOR            TYPE_CURSOR;
        v_id_rede_produtiva D_REDE_PRODUTIVA_DS.id_rede_produtiva%TYPE;

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

                            v_id_rede_produtiva :=
                                    PKG_TRATA_REGISTRO_ORFAO.GET_REDE_PRODUTIVA(R_CURSOR(I).id_rede_produtiva);

                            BEGIN
                                UPDATE F_DESENVOLVIMENTO_LOCAL_DS
                                SET id_rede_produtiva = v_id_rede_produtiva
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

    -- F_EVOLUCAO
    PROCEDURE T_F_DESENVOLVIMENTO_COLETA AS
        CURSOR C_CURSOR(aDT_registro DATE) IS
            SELECT rowid
                 , id_rede_produtiva
            FROM F_DESENVOLVIMENTO_COLETA_DS
            WHERE FG_STATUS_ETL = 'E'
              AND DT_REGISTRO = aDT_registro;
        TYPE TYPE_CURSOR IS TABLE OF C_CURSOR%ROWTYPE INDEX BY BINARY_INTEGER;
        R_CURSOR            TYPE_CURSOR;
        v_id_rede_produtiva D_REDE_PRODUTIVA_DS.id_rede_produtiva%TYPE;

    BEGIN
        FOR REG IN (SELECT DT_REGISTRO
                    FROM F_DESENVOLVIMENTO_COLETA_DS
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

                            v_id_rede_produtiva :=
                                    PKG_TRATA_REGISTRO_ORFAO.GET_REDE_PRODUTIVA(R_CURSOR(I).id_rede_produtiva);

                            BEGIN
                                UPDATE F_DESENVOLVIMENTO_COLETA_DS
                                SET id_rede_produtiva = v_id_rede_produtiva
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