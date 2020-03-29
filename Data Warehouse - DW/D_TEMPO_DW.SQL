CREATE TABLE D_TEMPO_DW
(
    SK_TEMPO            VARCHAR2(8),
    DATE_ID             DATE,
    WEEK_DAY_FULL       VARCHAR2(52),
    WEEK_DAY_SHORT      VARCHAR2(12),
    DAY_NUM_OF_WEEK     NUMBER,
    DAY_NUM_OF_MONTH    NUMBER,
    DAY_NUM_OF_YEAR     NUMBER,
    MONTH_ID            VARCHAR2(17),
    MONTH_END_DATE      DATE,
    MONTH_SHORT_DESC    VARCHAR2(17),
    MONTH_LONG_DESC     VARCHAR2(41),
    MONTH_SHORT         VARCHAR2(12),
    MONTH_LONG          VARCHAR2(36),
    MONTH_NUM_OF_YEAR   NUMBER,
    QUARTER_ID          VARCHAR2(7),
    QUARTER_END_DATE    DATE,
    QUARTER_NUM_OF_YEAR NUMBER,
    HALF_NUM_OF_YEAR    NUMBER,
    HALF_OF_YEAR_ID     VARCHAR2(7),
    HALF_YEAR_LAST_DATE DATE,
    YEAR_ID             VARCHAR2(4),
    YEAR_LAST_DATE      DATE,

    CONSTRAINT PK_D_TEMPO_DW PRIMARY KEY (SK_TEMPO)
);

-- Script que cria e já seta valores (300 anos) 

CREATE TABLE D_TEMPO_DW AS
WITH D_TEMPO_DW AS
         (SELECT TO_NUMBER(TO_CHAR(CurrDate, 'RRRRMMDD'))       AS sk_tempo,
                 CurrDate                                       AS date_id,

                 TO_CHAR(CurrDate, 'Day')                       AS Week_Day_Full,
                 TO_CHAR(CurrDate, 'DY')                        AS Week_Day_Short,
                 TO_NUMBER(TRIM(leading '0'
                                FROM TO_CHAR(CurrDate, 'D')))   AS Day_Num_of_Week,
                 TO_NUMBER(TRIM(leading '0'
                                FROM TO_CHAR(CurrDate, 'DD')))  AS Day_Num_of_Month,
                 TO_NUMBER(TRIM(leading '0'
                                FROM TO_CHAR(CurrDate, 'DDD'))) AS Day_Num_of_Year,
                 UPPER(TO_CHAR(CurrDate, 'Mon')
                     || '-'
                     || TO_CHAR(CurrDate, 'YYYY'))              AS Month_ID,
                 TO_CHAR(CurrDate, 'Mon')
                     || ' '
                     || TO_CHAR(CurrDate, 'YYYY')               AS Month_Short_Desc,
                 RTRIM(TO_CHAR(CurrDate, 'Month'))
                     || ' '
                     || TO_CHAR(CurrDate, 'YYYY')               AS Month_Long_Desc,
                 TO_CHAR(CurrDate, 'Mon')                       AS Month_Short,
                 TO_CHAR(CurrDate, 'Month')                     AS Month_Long,
                 TO_NUMBER(TRIM(leading '0'
                                FROM TO_CHAR(CurrDate, 'MM')))  AS Month_Num_of_Year,
                 'Q'
                     || UPPER(TO_CHAR(CurrDate, 'Q')
                     || '-'
                     || TO_CHAR(CurrDate, 'YYYY'))              AS Quarter_ID,
                 TO_NUMBER(TO_CHAR(CurrDate, 'Q'))              AS Quarter_Num_of_Year,
                 CASE
                     WHEN TO_NUMBER(TO_CHAR(CurrDate, 'Q')) <= 2
                         THEN 1
                     ELSE 2
                     END                                        AS half_num_of_year,
                 CASE
                     WHEN TO_NUMBER(TO_CHAR(CurrDate, 'Q')) <= 2
                         THEN 'H'
                         || 1
                         || '-'
                         || TO_CHAR(CurrDate, 'YYYY')
                     ELSE 'H'
                         || 2
                         || '-'
                         || TO_CHAR(CurrDate, 'YYYY')
                     END                                        AS half_of_year_id,
                 TO_CHAR(CurrDate, 'YYYY')                      AS Year_ID
          FROM (SELECT level                                                               n,
                       -- Parâmetro para data de inicio da tabela de tempo
                       TO_DATE('31/12/2000', 'DD/MM/YYYY') + NUMTODSINTERVAL(level, 'DAY') CurrDate
                       --TO_DATE(:p_ini_date, 'DD/MM/YYYY') + NUMTODSINTERVAL(level, 'DAY') CurrDate

                FROM dual
                     -- Parâmetro que recebe quantidade de dias que serão inseridos na tabela
                CONNECT BY level <= 300 * 365
                   -- CONNECT BY level <= :p_num_years * 365
               )
         )
SELECT sk_tempo,
       date_id,
       week_day_full,
       week_day_short,
       day_num_of_week,
       day_num_of_month,
       day_num_of_year,
       month_id,
       MAX(date_id) OVER (PARTITION BY month_id)        AS Month_End_Date,
       month_short_desc,
       month_long_desc,
       month_short,
       month_long,
       month_num_of_year,
       quarter_id,
       MAX(date_id) OVER (PARTITION BY quarter_id)      AS Quarter_End_Date,
       quarter_num_of_year,
       half_num_of_year,
       half_of_year_id,
       MAX(date_id) OVER (PARTITION BY half_of_year_id) AS Half_Year_last_Date,
       year_id,
       MAX(date_id) OVER (PARTITION BY year_id)         AS year_last_Date
FROM D_TEMPO_DW
ORDER BY date_id;
);

-- Criação de chave primária, pós alimentação
ALTER TABLE D_TEMPO_DW
    ADD CONSTRAINT PK_D_TEMPO_DW PRIMARY KEY (SK_TEMPO);