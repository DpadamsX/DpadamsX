﻿------------------------------------------------------------------------------------- Checks for types_plus.domo_dataset_to_v1 (domo_dataset_in domo_dataset) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'domo_dataset_to_v1 (domo_dataset_in domo_dataset)', '()', 'types_plus.domo_dataset_to_v1 domo_dataset_in domo_dataset existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''domo_dataset_to_v1''   and pg_get_function_identity_arguments(oid) = ''domo_dataset_in domo_dataset'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'domo_dataset_to_v1 (domo_dataset_in domo_dataset)', '()', 'types_plus.domo_dataset_to_v1 domo_dataset_in domo_dataset definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''domo_dataset_to_v1''   and pg_get_function_identity_arguments(oid) = ''domo_dataset_in domo_dataset'';', 'CREATE OR REPLACE FUNCTION types_plus.domo_dataset_to_v1(domo_dataset_in domo_dataset) RETURNS domo_dataset_v1 LANGUAGE sqlAS $function$                   SELECT			domo_dataset_in.id,			domo_dataset_in.dataset_name,			domo_dataset_in.rows_count,			domo_dataset_in.columns_count,			domo_dataset_in.created_at_dts,			domo_dataset_in.updated_at_dts               $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');