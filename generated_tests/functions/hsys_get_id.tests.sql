﻿------------------------------------------------------------------------------------- Checks for ascendco.hsys_get_id (hsys_name_in citext) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'ascendco', 'hsys_get_id (hsys_name_in citext)', '()', 'ascendco.hsys_get_id hsys_name_in citext existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''hsys_get_id''   and pg_get_function_identity_arguments(oid) = ''hsys_name_in citext'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'ascendco', 'hsys_get_id (hsys_name_in citext)', '()', 'ascendco.hsys_get_id hsys_name_in citext definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''hsys_get_id''   and pg_get_function_identity_arguments(oid) = ''hsys_name_in citext'';', 'CREATE OR REPLACE FUNCTION ascendco.hsys_get_id(hsys_name_in citext) RETURNS uuid LANGUAGE sql STABLEAS $function$SELECT coalesce(    (SELECT id FROM ascendco.hsys WHERE name_ = hsys_name_in),    ''00000000-0000-0000-0000-000000000000''::uuid);$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');