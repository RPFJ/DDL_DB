 SELECT evolucao.ID_EMPREENDIMENTO
	, evolucao.ID_REDE_ECONOMICA
    , DATE_ADD(DATE(COALESCE(data, current_timestamp)), INTERVAL -2 MONTH)  as DT_REGISTRO
    , evolucao.ID_GERACAO_RENDA
    , resposta.id_questao as ID_QUESTAO
	, resposta.id_opcao_questao as ID_RESPOSTA
    , 1 AS VL_QUANTIDADE
    , 'E' AS FG_STATUS_ETL
FROM CDT_RESPOSTA resposta
inner join REL_EVOLUCAO evolucao
ON resposta.id_evolucao = evolucao.idevolucao;