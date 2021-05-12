﻿------------------------------------------------------------------------------------- Checks for types_plus.insert_activity_v2 (data_in activity_v2[]) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'insert_activity_v2 (data_in activity_v2[])', '()', 'types_plus.insert_activity_v2 data_in activity_v2[] existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_activity_v2''   and pg_get_function_identity_arguments(oid) = ''data_in activity_v2[]'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'insert_activity_v2 (data_in activity_v2[])', '()', 'types_plus.insert_activity_v2 data_in activity_v2[] definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_activity_v2''   and pg_get_function_identity_arguments(oid) = ''data_in activity_v2[]'';', 'CREATE OR REPLACE FUNCTION types_plus.insert_activity_v2(data_in activity_v2[]) RETURNS integer LANGUAGE sqlAS $function$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO activity (			id,			facility_id,			facility_activities_id,			web_user_id,			last_updated_by_data_file_id,			updated_dts,			created_dts,			done_dts,			start_dts,			duration_seconds,			marked_for_deletion,			other_desc,			created_by,			updated_by)                  SELECT			rows_in.id,			rows_in.facility_id,			rows_in.facility_activities_id,			rows_in.web_user_id,			rows_in.last_updated_by_data_file_id,			rows_in.updated_dts,			rows_in.created_dts,			rows_in.done_dts,			rows_in.start_dts,			rows_in.duration_seconds,			rows_in.marked_for_deletion,			rows_in.other_desc,			rows_in.created_by,			rows_in.updated_by                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			facility_id = EXCLUDED.facility_id,			facility_activities_id = EXCLUDED.facility_activities_id,			web_user_id = EXCLUDED.web_user_id,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			updated_dts = EXCLUDED.updated_dts,			created_dts = EXCLUDED.created_dts,			done_dts = EXCLUDED.done_dts,			start_dts = EXCLUDED.start_dts,			duration_seconds = EXCLUDED.duration_seconds,			marked_for_deletion = EXCLUDED.marked_for_deletion,			other_desc = EXCLUDED.other_desc,			created_by = EXCLUDED.created_by,			updated_by = EXCLUDED.updated_by          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');