﻿------------------------------------------------------------------------------------- Checks for ascendco.loaner_item loaner_item_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'loaner_item_pkey', '', 'ascendco.loaner_item loaner_item_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''loaner_item_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'loaner_item_pkey', '', 'ascendco.loaner_item loaner_item_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''loaner_item_pkey'';', 'CREATE UNIQUE INDEX loaner_item_pkey ON ascendco.loaner_item USING btree (id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');