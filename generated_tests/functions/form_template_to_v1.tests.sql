﻿------------------------------------------------------------------------------------- Checks for types_plus.form_template_to_v1 (form_template_in form_template) function------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Function', 'types_plus', 'form_template_to_v1 (form_template_in form_template)', '()', 'types_plus.form_template_to_v1 form_template_in form_template existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''form_template_to_v1''   and pg_get_function_identity_arguments(oid) = ''form_template_in form_template'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Function', 'types_plus', 'form_template_to_v1 (form_template_in form_template)', '()', 'types_plus.form_template_to_v1 form_template_in form_template definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''types_plus''   and proname = ''form_template_to_v1''   and pg_get_function_identity_arguments(oid) = ''form_template_in form_template'';', 'CREATE OR REPLACE FUNCTION types_plus.form_template_to_v1(form_template_in form_template) RETURNS form_template_v1 LANGUAGE sqlAS $function$                   SELECT			form_template_in.id,			form_template_in.created_dts,			form_template_in.updated_dts,			form_template_in.marked_for_deletion,			form_template_in.name_,			form_template_in.comments_,			form_template_in.updated_by,			form_template_in.created_by,			form_template_in.form_definition               $function$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');