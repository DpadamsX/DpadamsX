﻿------------------------------------------------------------------------------------- Checks for ascendco.assembly assembly_id_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'assembly_id_pkey', '', 'ascendco.assembly assembly_id_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''assembly_id_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'assembly_id_pkey', '', 'ascendco.assembly assembly_id_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''assembly_id_pkey'';', 'CREATE UNIQUE INDEX assembly_id_pkey ON ascendco.assembly USING btree (id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');