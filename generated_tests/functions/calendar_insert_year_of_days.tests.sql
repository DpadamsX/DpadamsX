﻿------------------------------------------------------------------------------------- Checks for ascendco.calendar_insert_year_of_days (calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'ascendco', 'calendar_insert_year_of_days (calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer)', '()', 'ascendco.calendar_insert_year_of_days calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''calendar_insert_year_of_days''   and pg_get_function_identity_arguments(oid) = ''calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'ascendco', 'calendar_insert_year_of_days (calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer)', '()', 'ascendco.calendar_insert_year_of_days calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''calendar_insert_year_of_days''   and pg_get_function_identity_arguments(oid) = ''calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer'';', 'CREATE OR REPLACE FUNCTION ascendco.calendar_insert_year_of_days(calendar_id_in uuid, calendar_year_id_in uuid, fiscal_year_name_in text, fiscal_year_abbr_in text, first_date_in_year_in date, last_date_in_year_in date, week_start_offset integer) RETURNS void LANGUAGE plpgsqlAS $function$BEGININSERT INTO calendar_day (            calendar_id,            calendar_year_id,            date_actual,            epoch,            day_suffix,            day_name,            day_name_abbreviated,            day_of_week_usa,            day_of_week_iso,            day_of_month_actual,            day_of_quarter_iso,            day_of_year_actual,            day_of_year_fiscal,            week_of_month_actual,            week_of_year_actual,            week_of_year_fiscal_name,            week_of_year_fiscal,            week_of_year_iso,            month_actual,            month_actual_name,            month_actual_name_abbreviated,            month_fiscal,            month_fiscal_name,            month_fiscal_name_abbreviated,            quarter_actual,            quarter_actual_name,            quarter_fiscal,            quarter_fiscal_name,            year_actual,            first_date_of_week,            last_date_of_week,            first_date_of_month,            last_date_of_month,            first_date_of_quarter,            last_date_of_quarter,            first_date_of_year_actual,            last_date_of_year_actual,            first_date_of_year_fiscal,            last_date_of_year_fiscal,            mmyyyyy,            mmddyyyy,            ddmmyyyyy,            weekend         )     SELECT calendar_id_in,            calendar_year_id_in,            date_actual,            epoch,            day_suffix,            day_name,            day_name_abbreviated,            day_of_week_usa,            day_of_week_iso,            day_of_month_actual,            day_of_quarter_iso,            day_of_year_actual,            day_of_year_fiscal,            week_of_month_actual,            week_of_year_actual,            week_of_year_fiscal_name,            week_of_year_fiscal,            week_of_year_iso,            month_actual,            month_actual_name,            month_actual_name_abbreviated,            month_fiscal,            month_fiscal_name,            month_fiscal_name_abbreviated,            quarter_actual,            quarter_actual_name,            quarter_fiscal,            quarter_fiscal_name,            year_actual,            first_date_of_week,            last_date_of_week,            first_date_of_month,            last_date_of_month,            first_date_of_quarter,            last_date_of_quarter,            first_date_of_year_actual,            last_date_of_year_actual,            first_date_of_year_fiscal,            last_date_of_year_fiscal,            mmyyyyy,            mmddyyyy,            ddmmyyyyy,            weekend     from  calendar_generate_year_of_days (                  fiscal_year_name_in,                  fiscal_year_abbr_in,                  first_date_in_year_in,                  last_date_in_year_in,                  week_start_offset)      order by date_actual;RETURN; -- void/NULLEND$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');