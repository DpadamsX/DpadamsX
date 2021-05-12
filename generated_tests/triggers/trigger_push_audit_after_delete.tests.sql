﻿------------------------------------------------------------------------------------- Checks for dba.push_audit trigger_push_audit_after_delete trigger------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Trigger', 'dba', 'trigger_push_audit_after_delete', '', 'dba.push_audit trigger_push_audit_after_delete existence check', 'WITH trigger_grouping_search AS (select event_object_schema as table_schema,       event_object_table as table_name,       trigger_name,       trigger_schema as trigger_schema,       string_agg(event_manipulation, '','' order by event_manipulation) as event,       action_timing,       coalesce(action_condition,'''') as action_condition,       action_statement,       pg_get_triggerdef((select oid from pg_trigger where tgname = trigger_name)) as definition from information_schema.triggersgroup by table_schema, table_name, trigger_schema, trigger_name,  action_timing, action_condition, action_statementorder by table_schema,         table_name)select count(*)   from trigger_grouping_search  where table_schema              = ''dba''      and table_name                = ''push_audit''      and trigger_schema            = ''dba''      and trigger_name              = ''trigger_push_audit_after_delete''     and action_timing             = ''AFTER''     and action_condition          = ''''     and action_statement          = ''EXECUTE FUNCTION trigger_function_log_deletion_count()''     and definition                = ''CREATE TRIGGER trigger_push_audit_after_delete AFTER DELETE ON dba.push_audit REFERENCING OLD TABLE AS deleted_rows FOR EACH STATEMENT EXECUTE FUNCTION trigger_function_log_deletion_count()''   and trigger_name       not like ''RI_ConstraintTrigger_%''', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Trigger', 'dba', 'trigger_push_audit_after_delete', '', 'dba.push_audit trigger_push_audit_after_delete definition check', 'WITH trigger_grouping_search AS (select event_object_schema as table_schema,       event_object_table as table_name,       trigger_name,       ''Trigger'' as resource_type_name,       trigger_schema as trigger_schema,       string_agg(event_manipulation, '','' order by event_manipulation) as event,       action_timing,       coalesce (action_condition, '''') as action_condition,       action_statement,       pg_get_triggerdef((select oid from pg_trigger where tgname = trigger_name))  as definition       from information_schema.triggersgroup by table_schema, table_name, trigger_schema, trigger_name,  action_timing, action_condition, action_statementorder by table_schema,         table_name)select definition  from trigger_grouping_search  where table_schema         = ''dba''   and table_name           = ''push_audit''   and trigger_schema       = ''dba''   and trigger_name         = ''trigger_push_audit_after_delete''', 'CREATE TRIGGER trigger_push_audit_after_delete AFTER DELETE ON dba.push_audit REFERENCING OLD TABLE AS deleted_rows FOR EACH STATEMENT EXECUTE FUNCTION trigger_function_log_deletion_count()', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');