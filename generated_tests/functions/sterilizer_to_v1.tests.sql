﻿------------------------------------------------------------------------------------- Checks for types_plus.sterilizer_to_v1 (sterilizer_in sterilizer) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'sterilizer_to_v1 (sterilizer_in sterilizer)', '()', 'types_plus.sterilizer_to_v1 sterilizer_in sterilizer existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''sterilizer_to_v1''   and pg_get_function_identity_arguments(oid) = ''sterilizer_in sterilizer'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'sterilizer_to_v1 (sterilizer_in sterilizer)', '()', 'types_plus.sterilizer_to_v1 sterilizer_in sterilizer definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''sterilizer_to_v1''   and pg_get_function_identity_arguments(oid) = ''sterilizer_in sterilizer'';', 'CREATE OR REPLACE FUNCTION types_plus.sterilizer_to_v1(sterilizer_in sterilizer) RETURNS sterilizer_v1 LANGUAGE sqlAS $function$                   SELECT			sterilizer_in.id,			sterilizer_in.data_file_id,			sterilizer_in.marked_for_deletion,			sterilizer_in.facility_id,			sterilizer_in.sterilize_method_id,			sterilizer_in.name_               $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');