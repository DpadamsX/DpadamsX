﻿------------------------------------------------------------------------------------- Checks for types_plus.insert_form_template_v1 (data_in form_template_v1[]) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'insert_form_template_v1 (data_in form_template_v1[])', '()', 'types_plus.insert_form_template_v1 data_in form_template_v1[] existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_form_template_v1''   and pg_get_function_identity_arguments(oid) = ''data_in form_template_v1[]'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'insert_form_template_v1 (data_in form_template_v1[])', '()', 'types_plus.insert_form_template_v1 data_in form_template_v1[] definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_form_template_v1''   and pg_get_function_identity_arguments(oid) = ''data_in form_template_v1[]'';', 'CREATE OR REPLACE FUNCTION types_plus.insert_form_template_v1(data_in form_template_v1[]) RETURNS integer LANGUAGE sqlAS $function$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO form_template (			id,			created_dts,			updated_dts,			marked_for_deletion,			name_,			comments_,			updated_by,			created_by,			form_definition)                  SELECT			rows_in.id,			rows_in.created_dts,			rows_in.updated_dts,			rows_in.marked_for_deletion,			rows_in.name_,			rows_in.comments_,			rows_in.updated_by,			rows_in.created_by,			rows_in.form_definition                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			created_dts = EXCLUDED.created_dts,			updated_dts = EXCLUDED.updated_dts,			marked_for_deletion = EXCLUDED.marked_for_deletion,			name_ = EXCLUDED.name_,			comments_ = EXCLUDED.comments_,			updated_by = EXCLUDED.updated_by,			created_by = EXCLUDED.created_by,			form_definition = EXCLUDED.form_definition          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');