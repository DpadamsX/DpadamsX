﻿------------------------------------------------------------------------------------- Checks for api.assembly_prods_y2016_m070809 assembly_prods_y2016_m070809_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2016_m070809_pkey', '', 'api.assembly_prods_y2016_m070809 assembly_prods_y2016_m070809_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2016_m070809_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2016_m070809_pkey', '', 'api.assembly_prods_y2016_m070809 assembly_prods_y2016_m070809_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2016_m070809_pkey'';', 'CREATE UNIQUE INDEX assembly_prods_y2016_m070809_pkey ON api.assembly_prods_y2016_m070809 USING btree (updated_date, id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');