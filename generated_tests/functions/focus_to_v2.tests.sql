﻿------------------------------------------------------------------------------------- Checks for types_plus.focus_to_v2 (focus_in focus) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'focus_to_v2 (focus_in focus)', '()', 'types_plus.focus_to_v2 focus_in focus existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''focus_to_v2''   and pg_get_function_identity_arguments(oid) = ''focus_in focus'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'focus_to_v2 (focus_in focus)', '()', 'types_plus.focus_to_v2 focus_in focus definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''focus_to_v2''   and pg_get_function_identity_arguments(oid) = ''focus_in focus'';', 'CREATE OR REPLACE FUNCTION types_plus.focus_to_v2(focus_in focus) RETURNS focus_v2 LANGUAGE sqlAS $function$                   SELECT			focus_in.scase_id,			focus_in.hsys_id,			focus_in.facility_id,			focus_in.sched_dts,			focus_in.facility_name,			focus_in.or_name,			focus_in.case_seq,			focus_in.desc_,			focus_in.status,			focus_in.transport_from,			focus_in.surgeon_name,			focus_in.proc_name,			focus_in.when_               $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');