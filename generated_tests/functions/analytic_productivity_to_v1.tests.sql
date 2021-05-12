﻿------------------------------------------------------------------------------------- Checks for types_plus.analytic_productivity_to_v1 (analytic_productivity_in analytic_productivity) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'analytic_productivity_to_v1 (analytic_productivity_in analytic_productivity)', '()', 'types_plus.analytic_productivity_to_v1 analytic_productivity_in analytic_productivity existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''analytic_productivity_to_v1''   and pg_get_function_identity_arguments(oid) = ''analytic_productivity_in analytic_productivity'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'analytic_productivity_to_v1 (analytic_productivity_in analytic_productivity)', '()', 'types_plus.analytic_productivity_to_v1 analytic_productivity_in analytic_productivity definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''analytic_productivity_to_v1''   and pg_get_function_identity_arguments(oid) = ''analytic_productivity_in analytic_productivity'';', 'CREATE OR REPLACE FUNCTION types_plus.analytic_productivity_to_v1(analytic_productivity_in analytic_productivity) RETURNS analytic_productivity_v1 LANGUAGE sqlAS $function$        SELECT			analytic_productivity_in.id,			analytic_productivity_in.data_file_id,			analytic_productivity_in.marked_for_deletion,			analytic_productivity_in.hsys_id,			analytic_productivity_in.facility_id,			analytic_productivity_in.facility_location_id,			analytic_productivity_in.specialty_id,			analytic_productivity_in.item_type_id,			analytic_productivity_in.user_name,			analytic_productivity_in.inv_name,			analytic_productivity_in.item_name,			analytic_productivity_in.tray_or_pack,			analytic_productivity_in.num_inst,			analytic_productivity_in.assembly_minutes,			analytic_productivity_in.pause_minutes,			analytic_productivity_in.points,			analytic_productivity_in.points_per_hour,			analytic_productivity_in.assembly_hour,			analytic_productivity_in.pause_hour,			analytic_productivity_in.start_utc,			analytic_productivity_in.start_local,			analytic_productivity_in.end_utc,			analytic_productivity_in.end_local$function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');