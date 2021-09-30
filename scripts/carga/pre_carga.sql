CREATE TABLE IF NOT EXISTS public.${tabla_panel_integral_base}
(
    fecha_proceso VARCHAR(255),
    periodo VARCHAR(255),
    concepto VARCHAR(255),
    tenencia_tarjeta VARCHAR(255),
    tipo_tc VARCHAR(255),
    segmento_gestion VARCHAR(255),
    valor VARCHAR(255),
    periodo2 VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.${tabla_panel_fuga_consolidado}
(
    periodo VARCHAR(255),
    item VARCHAR(255),
    valor double precision
);

CREATE TABLE IF NOT EXISTS public.${tabla_panel_fuga}
(
    item VARCHAR(255),
    feb19 VARCHAR(255),
    mar19 VARCHAR(255),
    apr19 VARCHAR(255),
    may19 VARCHAR(255),
    jun19 VARCHAR(255),
    jul19 VARCHAR(255),
    aug19 VARCHAR(255),
    sep19 VARCHAR(255),
    oct19 VARCHAR(255),
    nov19 VARCHAR(255),
    dec19 VARCHAR(255),
    jan20 VARCHAR(255),
    feb20 VARCHAR(255),
    mar20 VARCHAR(255),
    apr20 VARCHAR(255),
    may20 VARCHAR(255),
    jun20 VARCHAR(255),
    jul20 VARCHAR(255),
    aug20 VARCHAR(255),
    sep20 VARCHAR(255),
    oct20 VARCHAR(255),
    nov20 VARCHAR(255),
    dec20 VARCHAR(255),
    jan21 VARCHAR(255),
    feb21 VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS public.${tabla_panel_clientes_consolidado}
(
    periodo VARCHAR(255),
    item VARCHAR(255),
    tipo_tc VARCHAR(255),
    valor double precision
);

CREATE TABLE IF NOT EXISTS public.${tabla_panel_cliente}
(
    item VARCHAR(255),
    jan17 VARCHAR(255),
    feb17 VARCHAR(255),
    mar17 VARCHAR(255),
    apr17 VARCHAR(255),
    may17 VARCHAR(255),
    jun17 VARCHAR(255),
    jul17 VARCHAR(255),
    aug17 VARCHAR(255),
    sep17 VARCHAR(255),
    oct17 VARCHAR(255),
    nov17 VARCHAR(255),
    dec17 VARCHAR(255),
    jan18 VARCHAR(255),
    feb18 VARCHAR(255),
    mar18 VARCHAR(255),
    apr18 VARCHAR(255),
    may18 VARCHAR(255),
    jun18 VARCHAR(255),
    jul18 VARCHAR(255),
    aug18 VARCHAR(255),
    sep18 VARCHAR(255),
    oct18 VARCHAR(255),
    nov18 VARCHAR(255),
    dec18 VARCHAR(255),
    jan19 VARCHAR(255),
    feb19 VARCHAR(255),
    mar19 VARCHAR(255),
    apr19 VARCHAR(255),
    may19 VARCHAR(255),
    jun19 VARCHAR(255),
    jul19 VARCHAR(255),
    aug19 VARCHAR(255),
    sep19 VARCHAR(255),
    oct19 VARCHAR(255),
    nov19 VARCHAR(255),
    dec19 VARCHAR(255),
    jan20 VARCHAR(255),
    feb20 VARCHAR(255),
    mar20 VARCHAR(255),
    apr20 VARCHAR(255),
    may20 VARCHAR(255),
    jun20 VARCHAR(255),
    jul20 VARCHAR(255),
    aug20 VARCHAR(255),
    sep20 VARCHAR(255),
    oct20 VARCHAR(255),
    nov20 VARCHAR(255),
    dec20 VARCHAR(255),
    jan21 VARCHAR(255),
    feb21 VARCHAR(255),
    tipo_tc VARCHAR(255)
);


CREATE OR REPLACE PROCEDURE public.consolidarPanelCliente(
	index_datos integer,
	tabla_datos character varying,
	tabla_cons character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    columna RECORD;
BEGIN
    RAISE NOTICE 'Refreshing all materialized views...%',index_datos;
	
    FOR columna IN
		select
		column_name as nombre,
		TO_DATE(column_name, 'monYY') as fecha,
		TO_CHAR(TO_DATE(column_name, 'monYY'), 'YYYYmm') as periodo,
		data_type as tipo
		--select *
		from information_schema.columns 
		where 1=1
		and table_name = tabla_datos --'paneles_panel_clientes' --tabla_datos
		and ordinal_position > index_datos
		and ordinal_position <> (
			select max(ordinal_position)
			from information_schema.columns 
			where table_name = tabla_datos
		)
		order by ordinal_position
    LOOP
		EXECUTE format(''
		|| 'INSERT INTO %I(periodo, item,tipo_tc,valor) '
		|| 'SELECT '
		|| '%L as periodo, item, tipo_tc,CAST(%I as NUMERIC) as valor '
		|| 'FROM %I;',tabla_cons, columna.periodo, columna.nombre, tabla_datos);
		
        RAISE NOTICE 'Insertada columna %',quote_ident(columna.nombre);
    END LOOP;

    RAISE NOTICE 'Done refreshing materialized views.';
END;
$BODY$;
CREATE OR REPLACE PROCEDURE public.consolidarPanelFuga(
	index_datos integer,
	tabla_datos character varying,
	tabla_cons character varying)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE
    columna RECORD;
BEGIN
    RAISE NOTICE 'Refreshing all materialized views...%',index_datos;
	
    FOR columna IN
		select
		column_name as nombre,
		TO_DATE(column_name, 'monYY') as fecha,
		TO_CHAR(TO_DATE(column_name, 'monYY'), 'YYYYmm') as periodo,
		data_type as tipo
		--select *
		from information_schema.columns 
		where 1=1
		and table_name = tabla_datos 
		and ordinal_position > index_datos
		and ordinal_position <> (
			select max(ordinal_position)
			from information_schema.columns 
			where table_name = tabla_datos
		)
		order by ordinal_position
    LOOP
		EXECUTE format(''
		|| 'INSERT INTO %I(periodo, item,tipo_tc,valor) '
		|| 'SELECT '
		|| '%L as periodo, item, tipo_tc,CAST(%I as NUMERIC) as valor '
		|| 'FROM %I;',tabla_cons, columna.periodo, columna.nombre, tabla_datos);
		
        RAISE NOTICE 'Insertada columna %',quote_ident(columna.nombre);
    END LOOP;

    RAISE NOTICE 'Done refreshing materialized views.';
END;
$BODY$;