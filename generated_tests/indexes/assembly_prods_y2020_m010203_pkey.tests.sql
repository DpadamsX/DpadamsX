﻿------------------------------------------------------------------------------------- Checks for api.assembly_prods_y2020_m010203 assembly_prods_y2020_m010203_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2020_m010203_pkey', '', 'api.assembly_prods_y2020_m010203 assembly_prods_y2020_m010203_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2020_m010203_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2020_m010203_pkey', '', 'api.assembly_prods_y2020_m010203 assembly_prods_y2020_m010203_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2020_m010203_pkey'';', 'CREATE UNIQUE INDEX assembly_prods_y2020_m010203_pkey ON api.assembly_prods_y2020_m010203 USING btree (updated_date, id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');