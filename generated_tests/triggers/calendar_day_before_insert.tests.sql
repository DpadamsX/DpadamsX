﻿------------------------------------------------------------------------------------- Checks for ascendco.calendar_day calendar_day_before_insert trigger------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Trigger', 'ascendco', 'calendar_day_before_insert', '', 'ascendco.calendar_day calendar_day_before_insert existence check', 'WITH trigger_grouping_search AS (select event_object_schema as table_schema,       event_object_table as table_name,       trigger_name,       trigger_schema as trigger_schema,       string_agg(event_manipulation, '','' order by event_manipulation) as event,       action_timing,       coalesce(action_condition,'''') as action_condition,       action_statement,       pg_get_triggerdef((select oid from pg_trigger where tgname = trigger_name)) as definition from information_schema.triggersgroup by table_schema, table_name, trigger_schema, trigger_name,  action_timing, action_condition, action_statementorder by table_schema,         table_name)select count(*)   from trigger_grouping_search  where table_schema              = ''ascendco''      and table_name                = ''calendar_day''      and trigger_schema            = ''ascendco''      and trigger_name              = ''calendar_day_before_insert''     and action_timing             = ''BEFORE''     and action_condition          = ''''     and action_statement          = ''EXECUTE FUNCTION trigger_function_calendar_day_before_insert()''     and definition                = ''CREATE TRIGGER calendar_day_before_insert BEFORE INSERT ON ascendco.calendar_day FOR EACH ROW EXECUTE FUNCTION trigger_function_calendar_day_before_insert()''   and trigger_name       not like ''RI_ConstraintTrigger_%''', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Trigger', 'ascendco', 'calendar_day_before_insert', '', 'ascendco.calendar_day calendar_day_before_insert definition check', 'WITH trigger_grouping_search AS (select event_object_schema as table_schema,       event_object_table as table_name,       trigger_name,       ''Trigger'' as resource_type_name,       trigger_schema as trigger_schema,       string_agg(event_manipulation, '','' order by event_manipulation) as event,       action_timing,       coalesce (action_condition, '''') as action_condition,       action_statement,       pg_get_triggerdef((select oid from pg_trigger where tgname = trigger_name))  as definition       from information_schema.triggersgroup by table_schema, table_name, trigger_schema, trigger_name,  action_timing, action_condition, action_statementorder by table_schema,         table_name)select definition  from trigger_grouping_search  where table_schema         = ''ascendco''   and table_name           = ''calendar_day''   and trigger_schema       = ''ascendco''   and trigger_name         = ''calendar_day_before_insert''', 'CREATE TRIGGER calendar_day_before_insert BEFORE INSERT ON ascendco.calendar_day FOR EACH ROW EXECUTE FUNCTION trigger_function_calendar_day_before_insert()', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');