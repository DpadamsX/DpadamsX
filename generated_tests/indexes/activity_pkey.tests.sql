﻿------------------------------------------------------------------------------------- Checks for ascendco.activity activity_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'activity_pkey', '', 'ascendco.activity activity_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''activity_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'activity_pkey', '', 'ascendco.activity activity_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''activity_pkey'';', 'CREATE UNIQUE INDEX activity_pkey ON ascendco.activity USING btree (id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');