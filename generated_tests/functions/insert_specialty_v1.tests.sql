﻿------------------------------------------------------------------------------------- Checks for types_plus.insert_specialty_v1 (data_in specialty_v1[]) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'insert_specialty_v1 (data_in specialty_v1[])', '()', 'types_plus.insert_specialty_v1 data_in specialty_v1[] existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_specialty_v1''   and pg_get_function_identity_arguments(oid) = ''data_in specialty_v1[]'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'insert_specialty_v1 (data_in specialty_v1[])', '()', 'types_plus.insert_specialty_v1 data_in specialty_v1[] definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_specialty_v1''   and pg_get_function_identity_arguments(oid) = ''data_in specialty_v1[]'';', 'CREATE OR REPLACE FUNCTION types_plus.insert_specialty_v1(data_in specialty_v1[]) RETURNS integer LANGUAGE sqlAS $function$-- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO specialty (			id,			data_file_id,			marked_for_deletion,			name_,			name_short)        SELECT			rows_in.id,			rows_in.data_file_id,			rows_in.marked_for_deletion,			rows_in.name_,			rows_in.name_short        FROM unnest(data_in) as rows_in        ON CONFLICT(id) DO UPDATE SET			data_file_id = EXCLUDED.data_file_id,			marked_for_deletion = EXCLUDED.marked_for_deletion,			name_ = EXCLUDED.name_,			name_short = EXCLUDED.name_short        returning 1 as row_counter)    select sum(row_counter)::integer from inserted_rows;$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');