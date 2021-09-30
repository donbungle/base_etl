
select  
    concepto,
    to_char(SUM(CAST(valor as FLOAT)/1000.0), '999G999G990') as valor
FROM public.paneles_panel_integral_base
WHERE 1=1
AND concepto in (
	'01.01 VU: Clientes',
	'02.01 ACTIVOS: Clientes',
	'04. Con EPU',
	'05. Con EPU Cobro',
	'03.01.01 Con Saldo Solo TC',
	'03.01.03 Con Saldo TC y TD'
)
and segmento_gestion in ('1. Gold', '2. Silver', '3. Bronce', '4. RGB', '5. S.I.')
and tenencia_tarjeta in ('1. TC + TD', '2. Solo TC')  --null
AND tipo_tc in ('TR', 'TAM')--, 'No Aplica') --null
AND periodo = '201909'
GROUP BY 
	concepto
ORDER BY 
    CASE concepto
        WHEN '01.01 VU: Clientes' THEN 1
        WHEN '02.01 ACTIVOS: Clientes' THEN 2
		WHEN '04. Con EPU' THEN 3
		WHEN '05. Con EPU Cobro' THEN 4
		WHEN '03.01.01 Con Saldo Solo TC' THEN 5
		WHEN '03.01.03 Con Saldo TC y TD' THEN 6
		ELSE 7
    END
	
	