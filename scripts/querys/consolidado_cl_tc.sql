-- DELETE FROM public.paneles_panel_integral_base;
-- drop table paneles_panel_integral_base
--SELECT fecha_proceso, cast(fecha_proceso as date), cast(fecha_proceso as timestamp) 
select 
    --periodo,
    concepto,
    --tenencia_tarjeta,
    --tipo_tc,
    --segmento_gestion,
    to_char(SUM(CAST(valor as FLOAT)), '999G999G990') as valor
FROM public.paneles_panel_integral_base
WHERE 1=1
AND tipo_tc in ('TAM','TR')
AND concepto not in (
	'01.01 VU: Clientes',
	'02.01 ACTIVOS: Clientes',
	'04. Con EPU',
	'05. Con EPU Cobro',
	'03.01.01 Con Saldo Solo TC',
	'03.01.03 Con Saldo TC y TD'
)
AND concepto like '%Uso%TC%'
AND concepto = '06.08 Uso: Clientes - TC:A.SOLO TDA'
-- and tenencia_tarjeta = '2. Solo TC'
--AND tipo_tc in ('No Aplica')
AND periodo = '202012'
GROUP BY 
	concepto
    --,tenencia_tarjeta
    --tipo_tc,
    --segmento_gestion
ORDER BY --concepto,
    CASE concepto
        WHEN '01.01 VU: Clientes' THEN 1
        WHEN '02.01 ACTIVOS: Clientes' THEN 2
		WHEN '04. Con EPU' THEN 3
		WHEN '05. Con EPU Cobro' THEN 4
		WHEN '03.01.01 Con Saldo Solo TC' THEN 5
		WHEN '03.01.03 Con Saldo TC y TD' THEN 6
		ELSE 7
    END
--concepto--,
    --tenencia_tarjeta
    --tipo_tc,
    --segmento_gestion;
	
	