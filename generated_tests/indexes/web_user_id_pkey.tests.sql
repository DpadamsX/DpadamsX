﻿------------------------------------------------------------------------------------- Checks for ascendco.web_user web_user_id_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'web_user_id_pkey', '', 'ascendco.web_user web_user_id_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''web_user_id_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'web_user_id_pkey', '', 'ascendco.web_user web_user_id_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''web_user_id_pkey'';', 'CREATE UNIQUE INDEX web_user_id_pkey ON ascendco.web_user USING btree (id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');