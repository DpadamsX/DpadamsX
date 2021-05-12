﻿------------------------------------------------------------------------------------- Checks for types_plus.insert_loaner_v1 (data_in loaner_v1[]) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'insert_loaner_v1 (data_in loaner_v1[])', '()', 'types_plus.insert_loaner_v1 data_in loaner_v1[] existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_loaner_v1''   and pg_get_function_identity_arguments(oid) = ''data_in loaner_v1[]'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'insert_loaner_v1 (data_in loaner_v1[])', '()', 'types_plus.insert_loaner_v1 data_in loaner_v1[] definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''insert_loaner_v1''   and pg_get_function_identity_arguments(oid) = ''data_in loaner_v1[]'';', 'CREATE OR REPLACE FUNCTION types_plus.insert_loaner_v1(data_in loaner_v1[]) RETURNS integer LANGUAGE sqlAS $function$ -- The CTE below is a roundabout way of returning an insertion count from a pure SQL function in Postgres.with inserted_rows as (        INSERT INTO loaner (			s_case_id,			id,			sup_id,			rep_id,			facility_id,			last_updated_by_data_file_id,			pickup_dts,			created_dts,			updated_dts,			datetime_local,			drop_off_dts,			num_items,			marked_for_deletion,			is_printed,			created_by,			updated_by,			status,			notes)                  SELECT			rows_in.s_case_id,			rows_in.id,			rows_in.sup_id,			rows_in.rep_id,			rows_in.facility_id,			rows_in.last_updated_by_data_file_id,			rows_in.pickup_dts,			rows_in.created_dts,			rows_in.updated_dts,			rows_in.datetime_local,			rows_in.drop_off_dts,			rows_in.num_items,			rows_in.marked_for_deletion,			rows_in.is_printed,			rows_in.created_by,			rows_in.updated_by,			rows_in.status,			rows_in.notes                      FROM unnest(data_in) as rows_in                  ON CONFLICT(id) DO UPDATE SET			s_case_id = EXCLUDED.s_case_id,			sup_id = EXCLUDED.sup_id,			rep_id = EXCLUDED.rep_id,			facility_id = EXCLUDED.facility_id,			last_updated_by_data_file_id = EXCLUDED.last_updated_by_data_file_id,			pickup_dts = EXCLUDED.pickup_dts,			created_dts = EXCLUDED.created_dts,			updated_dts = EXCLUDED.updated_dts,			datetime_local = EXCLUDED.datetime_local,			drop_off_dts = EXCLUDED.drop_off_dts,			num_items = EXCLUDED.num_items,			marked_for_deletion = EXCLUDED.marked_for_deletion,			is_printed = EXCLUDED.is_printed,			created_by = EXCLUDED.created_by,			updated_by = EXCLUDED.updated_by,			status = EXCLUDED.status,			notes = EXCLUDED.notes          returning 1 as row_counter)         select sum(row_counter)::integer from inserted_rows; $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');