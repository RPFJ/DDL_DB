SELECT r_economica.IDREDE_ECONOMICA AS ID_REDE_ECONOMICA
    , COALESCE(r_economica.descricao, 0 ) AS DESC_REDE_ECONOMICA
    , COALESCE(r_economica.LATITUDE, 0) AS VL_LATITUDE  
    , COALESCE(r_economica.LONGITUDE, 0) AS VL_LONGITUDE 
    , COALESCE(r_economica.ID_TIPO_REDE, -1) AS ID_TIPO_REDE  
    , COALESCE(t_rede.desc_tipo, '* não definido *') AS DESC_TIPO_REDE
	, 'T' AS FG_STATUS_ETL
FROM CDT_REDE_ECONOMICA r_economica
LEFT JOIN CDT_TP_REDE t_rede
ON r_economica.ID_TIPO_REDE =  t_rede.IDTIPO_REDE;
