SELECT r_economica.IDREDE_ECONOMICA AS ID_REDE_ECONOMICA
    , r_economica.descricao AS DESC_REDE_ECONOMICA
    , r_economica.LATITUDE 
    , r_economica.LONGITUDE
    , r_economica.ID_TIPO_REDE 
    , t_rede.desc_tipo AS DESC_TIPO_REDE
	, 'T' AS FG_STATUS_ETL
FROM CDT_REDE_ECONOMICA r_economica
LEFT JOIN CDT_TP_REDE t_rede
ON r_economica.ID_TIPO_REDE =  t_rede.IDTIPO_REDE;
