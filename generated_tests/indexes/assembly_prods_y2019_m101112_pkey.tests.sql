﻿------------------------------------------------------------------------------------- Checks for api.assembly_prods_y2019_m101112 assembly_prods_y2019_m101112_pkey index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2019_m101112_pkey', '', 'api.assembly_prods_y2019_m101112 assembly_prods_y2019_m101112_pkey existence check', 'select count(*) from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2019_m101112_pkey'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2019_m101112_pkey', '', 'api.assembly_prods_y2019_m101112 assembly_prods_y2019_m101112_pkey definition check', 'select indexdef from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2019_m101112_pkey'';', 'CREATE UNIQUE INDEX assembly_prods_y2019_m101112_pkey ON api.assembly_prods_y2019_m101112 USING btree (updated_date, id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');