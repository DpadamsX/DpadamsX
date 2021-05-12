﻿------------------------------------------------------------------------------------- Checks for ascendco.calendar_generate_year_of_days (fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'ascendco', 'calendar_generate_year_of_days (fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer)', '()', 'ascendco.calendar_generate_year_of_days fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''calendar_generate_year_of_days''   and pg_get_function_identity_arguments(oid) = ''fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'ascendco', 'calendar_generate_year_of_days (fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer)', '()', 'ascendco.calendar_generate_year_of_days fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''calendar_generate_year_of_days''   and pg_get_function_identity_arguments(oid) = ''fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer'';', 'CREATE OR REPLACE FUNCTION ascendco.calendar_generate_year_of_days(fiscal_year_name_in text_not_empty, fiscal_year_abbr_in text_not_empty, first_date_of_fiscal_year_in date, last_date_of_fiscal_year_in date, week_start_offset integer DEFAULT 1) RETURNS TABLE(date_actual date, epoch bigint, day_suffix citext, day_name citext, day_name_abbreviated citext, day_of_week_usa integer, day_of_week_iso integer, day_of_month_actual integer, day_of_quarter_iso integer, day_of_year_actual integer, day_of_year_fiscal integer, week_of_month_actual integer, week_of_year_actual integer, week_of_year_fiscal_name citext, week_of_year_fiscal citext, week_of_year_iso citext, month_actual integer, month_actual_name citext, month_actual_name_abbreviated citext, month_fiscal integer, month_fiscal_name citext, month_fiscal_name_abbreviated citext, quarter_actual integer, quarter_actual_name citext, quarter_fiscal integer, quarter_fiscal_name citext, year_actual integer, first_date_of_week date, last_date_of_week date, first_date_of_month date, last_date_of_month date, first_date_of_quarter date, last_date_of_quarter date, first_date_of_year_actual date, last_date_of_year_actual date, first_date_of_year_fiscal date, last_date_of_year_fiscal date, mmyyyyy citext, mmddyyyy citext, ddmmyyyyy citext, weekend boolean) LANGUAGE plpgsqlAS $function$DECLARE   days_in_year_calculated integer := last_date_of_fiscal_year_in - first_date_of_fiscal_year_in +1;BEGIN-- The parameter types screen out most bad inputs, but it''s still possible to screw up the start-end range. A few quick checks.IF first_date_of_fiscal_year_in > last_date_of_fiscal_year_in THEN  RAISE EXCEPTION USING     message = ''Invalid date range: '' || first_date_of_fiscal_year_in::text || '' to '' || last_date_of_fiscal_year_in::text,     hint = ''The first day in the year is later than the last day in the year.'',     errcode = ''KC400''; -- Custom code, see the error_code table.END IF;IF days_in_year_calculated < 364 OR days_in_year_calculated > 371 THEN  RAISE EXCEPTION USING     message = ''Invalid date range: ''  || first_date_of_fiscal_year_in::text || '' to '' || last_date_of_fiscal_year_in::text,     hint =  days_in_year_calculated::text || '' days in the fiscal year.'' || ''. fiscal years are expected to have 52 or 53 weeks for 364 or 371 days'',     errcode = ''KC401''; -- Custom code, see the error_code table.END IF;RETURN QUERYSELECT	datum                                                           AS date_actual,	EXTRACT(EPOCH FROM datum)::int8                                 AS epoch,-- Note: TO_CHAR ("string" to us 4D folk) argument fm/FM = Fill Mode. Which means "strip padding." Eh?	TO_CHAR(datum, ''fmDDth'')::citext                                AS day_suffix,	TO_CHAR(datum, ''fmDay'')::citext                                 AS day_name,	TO_CHAR(datum, ''fmDy'') ::citext                                 AS day_name_abbreviated,	(EXTRACT(DOW FROM datum) + 1)::integer                          AS day_of_week_usa,     -- 1-7 for Sunday-Monday, like 4D.	(EXTRACT(ISODOW FROM datum))::integer                           AS day_of_week_iso,     -- 1-7 for Monday-Sunday.	(EXTRACT(DAY FROM datum))::integer                              AS day_of_month_actual,	(datum - DATE_TRUNC(''quarter'', datum)::DATE + 1)::integer       AS day_of_quarter_iso,	(EXTRACT(DOY FROM datum))::integer                              AS day_of_year_actual,	(datum - first_date_of_fiscal_year_in +1)::integer              AS day_of_year_fiscal,	TO_CHAR(datum, ''W'')::integer                                    AS week_of_month_actual,	TO_CHAR(datum,''WW'')::integer                                    AS week_of_year_actual,	-- OMG! This next lines really are *horrible*. Want Abbr-00 format. Yeah, maybe there''s a simpler way, maybe this *is* the simpler way.	CONCAT(''Week '', to_char(calendar_get_fiscal_week(datum, first_date_of_fiscal_year_in),''fm00'')::citext, '' '', fiscal_year_abbr_in)::citext  AS week_of_year_fiscal_name,	CONCAT(fiscal_year_abbr_in, ''-'', to_char(calendar_get_fiscal_week(datum, first_date_of_fiscal_year_in),''fm00'')::citext)::citext  AS week_of_year_fiscal,	(EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, ''"-W"IW-'') || EXTRACT(ISODOW FROM datum))::citext                      AS week_of_year_iso,	(EXTRACT(MONTH FROM datum))::integer                            AS month_actual,	TO_CHAR(datum, ''Month'')::citext                                 AS month_actual_name,	TO_CHAR(datum, ''Mon'')::citext                                   AS month_actual_name_abbreviated,    calendar_get_fiscal_month (datum, first_date_of_fiscal_year_in) AS month_fiscal, -- Redundnat data with different column names for convenience	TO_CHAR(datum, ''Month'')::citext                                 AS month_fiscal_name,	TO_CHAR(datum, ''Mon'')::citext                                   AS month_fiscal_name_abbreviated,	(EXTRACT(QUARTER FROM datum))::integer                          AS quarter_actual,	CASE	   WHEN EXTRACT(QUARTER FROM datum) = 1 THEN ''First''::citext	   WHEN EXTRACT(QUARTER FROM datum) = 2 THEN ''Second''::citext	   WHEN EXTRACT(QUARTER FROM datum) = 3 THEN ''Third''::citext	   WHEN EXTRACT(QUARTER FROM datum) = 4 THEN ''Fourth''::citext	   ELSE ''''::citext	END                                                                 AS quarter_actual_name,	((datum - first_date_of_fiscal_year_in +1) / (7 * 13) +1)::integer  AS quarter_fiscal,	CASE	   WHEN (datum - first_date_of_fiscal_year_in +1) / (7 * 13) +1 = 1 THEN ''First''::citext	   WHEN (datum - first_date_of_fiscal_year_in +1) / (7 * 13) +1 = 2 THEN ''Second''::citext	   WHEN (datum - first_date_of_fiscal_year_in +1) / (7 * 13) +1 = 3 THEN ''Third''::citext	   WHEN (datum - first_date_of_fiscal_year_in +1) / (7 * 13) +1 = 4 THEN ''Fourth''::citext	   ELSE ''''::citext	END                                                                 AS quarter_fiscal_name,	(EXTRACT(ISOYEAR FROM datum))::integer AS year_actual,  -- calendar year	datum + (week_start_offset     - EXTRACT(ISODOW FROM datum))::int   AS first_date_of_week,	datum + (week_start_offset + 6 - EXTRACT(ISODOW FROM datum))::int   AS last_date_of_week,	datum + (1 - EXTRACT(DAY FROM datum))::INT                          AS first_date_of_month,	(DATE_TRUNC(''MONTH'', datum) + INTERVAL ''1 MONTH - 1 day'')::DATE     AS last_date_of_month,	DATE_TRUNC(''quarter'', datum)::DATE                                  AS first_date_of_quarter,    (DATE_TRUNC(''quarter'', datum) + INTERVAL ''3 MONTH - 1 day'')::DATE   AS last_date_of_quarter,	TO_DATE(EXTRACT(YEAR FROM datum) || ''-01-01'', ''YYYY-MM-DD'')         AS first_date_of_year_actual,	TO_DATE(EXTRACT(YEAR FROM datum) || ''-12-31'', ''YYYY-MM-DD'')         AS last_date_of_year_actual,	first_date_of_fiscal_year_in                                        AS first_date_of_year_fiscal,	last_date_of_fiscal_year_in                                         AS last_date_of_year_fiscal,	TO_CHAR(datum, ''mmyyyyy'')::citext                                   AS mmyyyyy,	TO_CHAR(datum, ''mmddyyyy'')::citext                                  AS mmddyyyy,	TO_CHAR(datum, ''ddmmyyyyy'')::citext                                 AS ddmmyyyyy,	CASE	   WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE	   ELSE FALSE	END AS weekend-- Synthesize a list of dates. This is then run against each line in the SELECT above,-- and the result is inserted into calendar_date.FROM (SELECT first_date_of_fiscal_year_in + SEQUENCE.DAY AS datum      FROM GENERATE_SERIES(0, days_in_year_calculated -1 ) AS SEQUENCE (DAY)      GROUP BY SEQUENCE.DAY) DQORDER BY 1;RAISE NOTICE ''fiscal_year_name_in: %'', fiscal_year_name_in;END$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');