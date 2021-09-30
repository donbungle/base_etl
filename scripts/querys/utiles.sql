select column_name as nombre,data_type, TO_DATE(column_name, 'monYY') as tipo
--select *
from information_schema.columns 
where 1=1
and table_name = 'paneles_panel_clientes2' --tabla_datos
and ordinal_position > 1
order by ordinal_position

--SELECT TO_DATE('jul17', 'monYY');7
--SELECT TO_CHAR(NOW(), 'monYY');