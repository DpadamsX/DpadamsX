﻿------------------------------------------------------------------------------------- Checks for ascendco.system_delete_marked_and_log_sp () procedure------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Procedure', 'ascendco', 'system_delete_marked_and_log_sp ()', '', 'ascendco.system_delete_marked_and_log_sp  existence check', 'select count(*) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''system_delete_marked_and_log_sp''   and pg_get_function_identity_arguments(oid) = '''';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Procedure', 'ascendco', 'system_delete_marked_and_log_sp ()', '', 'ascendco.system_delete_marked_and_log_sp  definition check', 'select pg_get_functiondef(oid) from pg_proc where pronamespace::regnamespace::text = ''ascendco''   and proname = ''system_delete_marked_and_log_sp''   and pg_get_function_identity_arguments(oid) = '''';', 'CREATE OR REPLACE PROCEDURE ascendco.system_delete_marked_and_log_sp() LANGUAGE plpgsqlAS $procedure$BEGIN-- Execute configured auto-deletes and save results in a CTE.with deletion_results as (    SELECT *      FROM system_delete_marked()    )-- Take the results from the CTE where something actually got deleted and push them into deletion_log.INSERT INTO deletion_log (                  schema_name,                  table_name,                  operation_name,                  deleted_count)         SELECT  schema,                 table_name,                 ''DELETE'',                 count            FROM deletion_results           WHERE count > 0;-- ANALYZE modified tables.-- Note: We''re in a stored procedure, there is no result returned. Use PERFORM on this function instead of SELECT.PERFORM system_analyze_after_deletions();END;$procedure$', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');