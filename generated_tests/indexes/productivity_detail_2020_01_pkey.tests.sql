﻿------------------------------------------------------------------------------------- Checks for ascendco.productivity_detail_2020_01 productivity_detail_2020_01_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'productivity_detail_2020_01_pkey', '', 'ascendco.productivity_detail_2020_01 productivity_detail_2020_01_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''productivity_detail_2020_01_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'productivity_detail_2020_01_pkey', '', 'ascendco.productivity_detail_2020_01 productivity_detail_2020_01_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''productivity_detail_2020_01_pkey'';', 'CREATE UNIQUE INDEX productivity_detail_2020_01_pkey ON ascendco.productivity_detail_2020_01 USING btree (id, source_record_row_counter, year_and_month)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');