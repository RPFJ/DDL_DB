SELECT IDEMPREENDIMENTO AS ID_EMPREENDIMENTO
    , COALESCE(empreendimento.descricao, '-1')  AS NOME_EMPREENDIMENTO
    , COALESCE(empreendimento.ENDERECO, '* não definido *')  AS ENDERECO
    , COALESCE(empreendimento.CIDADE, '* não definido *' )  AS CIDADE
    , COALESCE(empreendimento.LATITUDE, -1 )  AS LATITUDE
    , COALESCE(empreendimento.LONGITUDE, -1 )  AS LONGITUDE
    , COALESCE(empreendimento.SIGLA, '* não definido *' )  AS SIGLA
    , COALESCE(empreendimento.ID_AREA_ATUACAO, '-1' )   AS ID_AREA_ATUACAO
    , COALESCE(a_atuacao.DESC_AREA_ATUACAO, '* não definido *' )   AS DESC_AREA_ATUACAO
    , COALESCE(empreendimento.ID_LOCALIZACAO, -1 )  AS ID_LOCALIZACAO
    , COALESCE(local.DESC_LOCALIZACAO, '* não definido *' )  AS DESC_LOCALIZACAO
    , COALESCE(empreendimento.ID_TIPO_ORGANIZACAO, -1 )   AS ID_TIPO_ORGANIZACAO
    , COALESCE(t_organizacao.NOME_TIPO, '* não definido *' )  AS  DESC_TIPO_ORGANIZACAO
    , COALESCE(empreendimento.ANO_INICIO,  0000 )  AS ANO_INICIO
    , 'T' AS FG_STATUS_ETL
FROM CDT_EMPREENDIMENTO empreendimento
LEFT JOIN CDT_AREA_ATUACAO a_atuacao
ON a_atuacao.IDAREAATUACAO = empreendimento.ID_AREA_ATUACAO
LEFT JOIN CDT_TP_ORGANIZACAO t_organizacao
ON empreendimento.ID_TIPO_ORGANIZACAO = t_organizacao.IDTIPOORGANIZACAO
LEFT JOIN CDT_LOCALIZACAO local
ON local.IDLOCALIZACAO = empreendimento.ID_LOCALIZACAO