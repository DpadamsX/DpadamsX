﻿------------------------------------------------------------------------------------- Checks for ascendco.clinic clinic_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'clinic_pkey', '', 'ascendco.clinic clinic_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''clinic_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'clinic_pkey', '', 'ascendco.clinic clinic_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''clinic_pkey'';', 'CREATE UNIQUE INDEX clinic_pkey ON ascendco.clinic USING btree (id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');