﻿------------------------------------------------------------------------------------- Checks for ascendco.facility_get_name (facility_id_in uuid) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'ascendco', 'facility_get_name (facility_id_in uuid)', '()', 'ascendco.facility_get_name facility_id_in uuid existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''facility_get_name''   and pg_get_function_identity_arguments(oid) = ''facility_id_in uuid'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'ascendco', 'facility_get_name (facility_id_in uuid)', '()', 'ascendco.facility_get_name facility_id_in uuid definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''facility_get_name''   and pg_get_function_identity_arguments(oid) = ''facility_id_in uuid'';', 'CREATE OR REPLACE FUNCTION ascendco.facility_get_name(facility_id_in uuid) RETURNS citext LANGUAGE sql STABLEAS $function$-- Need to put the select as an expression *inside* the COALESCE, or else it never fires on NULL. D''oh!-- Not the same in a straight select for Reasons That I Do Not Undestand.-- https://stackoverflow.com/questions/65973653/SELECT coalesce((SELECT name_ FROM ascendco.facility WHERE id = facility_id_in),'''');$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');