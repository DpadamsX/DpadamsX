﻿------------------------------------------------------------------------------------- Checks for ascendco.row_compare row_compare_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'row_compare_pkey', '', 'ascendco.row_compare row_compare_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''row_compare_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'row_compare_pkey', '', 'ascendco.row_compare row_compare_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''row_compare_pkey'';', 'CREATE UNIQUE INDEX row_compare_pkey ON ascendco.row_compare USING btree (id, table_name)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');