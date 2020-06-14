SELECT IDEMPREENDIMENTO AS ID_EMPREENDIMENTO
    , empreendimento.descricao AS NOME_EMPREENDIMENTO
    , empreendimento.ENDERECO
    , empreendimento.CIDADE
    , empreendimento.LATITUDE
    , empreendimento.LONGITUDE
    , empreendimento.SIGLA
    , empreendimento.ID_AREA_ATUACAO 
    , a_atuacao.DESC_AREA_ATUACAO 
    , empreendimento.ID_LOCALIZACAO
    , local.DESC_LOCALIZACAO
    , empreendimento.ID_TIPO_ORGANIZACAO 
    , t_organizacao.NOME_TIPO AS DESC_TIPO_ORGANIZACAO
    , empreendimento.ANO_INICIO
    , 'T' AS FG_STATUS_ETL
FROM CDT_EMPREENDIMENTO empreendimento
LEFT JOIN CDT_AREA_ATUACAO a_atuacao
ON a_atuacao.IDAREAATUACAO = empreendimento.ID_AREA_ATUACAO
LEFT JOIN CDT_TP_ORGANIZACAO t_organizacao
ON empreendimento.ID_TIPO_ORGANIZACAO = t_organizacao.IDTIPOORGANIZACAO
LEFT JOIN CDT_LOCALIZACAO local
ON local.IDLOCALIZACAO = empreendimento.ID_LOCALIZACAO