﻿------------------------------------------------------------------------------------- Checks for ascendco.trigger_function_calendar_day_before_insert () function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'ascendco', 'trigger_function_calendar_day_before_insert ()', '()', 'ascendco.trigger_function_calendar_day_before_insert  existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''trigger_function_calendar_day_before_insert''   and pg_get_function_identity_arguments(oid) = '''';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'ascendco', 'trigger_function_calendar_day_before_insert ()', '()', 'ascendco.trigger_function_calendar_day_before_insert  definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''trigger_function_calendar_day_before_insert''   and pg_get_function_identity_arguments(oid) = '''';', 'CREATE OR REPLACE FUNCTION ascendco.trigger_function_calendar_day_before_insert() RETURNS trigger LANGUAGE plpgsqlAS $function$BEGIN	NEW.id := NEW.calendar_id || ''.'' || TO_CHAR(NEW.date_actual, ''YYYY-MM-DD''); RETURN NEW;END$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');