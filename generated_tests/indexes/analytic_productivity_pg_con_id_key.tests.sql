﻿------------------------------------------------------------------------------------- Checks for ascendco.analytic_productivity analytic_productivity_pg_con_id_key index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'analytic_productivity_pg_con_id_key', '', 'ascendco.analytic_productivity analytic_productivity_pg_con_id_key existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''analytic_productivity_pg_con_id_key'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'analytic_productivity_pg_con_id_key', '', 'ascendco.analytic_productivity analytic_productivity_pg_con_id_key definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''analytic_productivity_pg_con_id_key'';', 'CREATE UNIQUE INDEX analytic_productivity_pg_con_id_key ON ascendco.analytic_productivity USING btree (pg_con_id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');