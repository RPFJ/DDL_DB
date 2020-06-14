SELECT DISTINCT resposta.id_questao as id_questao
 , resposta.id_opcao_questao as id_resposta
 , questao.desc_questao
 , opcao_questao.desc_opcao as desc_resposta
 , 'T' AS FG_STATUS_ETL
 FROM CDT_RESPOSTA resposta
 INNER JOIN CDT_QUESTAO questao
 ON questao.idQuestao = resposta.id_questao
 INNER JOIN CDT_OPCAO_QUESTAO opcao_questao
 ON resposta.id_opcao_questao = opcao_questao.idOpcao ;