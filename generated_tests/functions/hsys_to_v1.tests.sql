﻿------------------------------------------------------------------------------------- Checks for types_plus.hsys_to_v1 (hsys_in hsys) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'hsys_to_v1 (hsys_in hsys)', '()', 'types_plus.hsys_to_v1 hsys_in hsys existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''hsys_to_v1''   and pg_get_function_identity_arguments(oid) = ''hsys_in hsys'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'hsys_to_v1 (hsys_in hsys)', '()', 'types_plus.hsys_to_v1 hsys_in hsys definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''hsys_to_v1''   and pg_get_function_identity_arguments(oid) = ''hsys_in hsys'';', 'CREATE OR REPLACE FUNCTION types_plus.hsys_to_v1(hsys_in hsys) RETURNS hsys_v1 LANGUAGE sqlAS $function$        SELECT			hsys_in.id,			hsys_in.marked_for_deletion,			hsys_in.name_$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');