﻿------------------------------------------------------------------------------------- Checks for api.assembly_prods_y2016_m101112 assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx', '', 'api.assembly_prods_y2016_m101112 assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx existence check', 'select count(*) from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'api', 'assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx', '', 'api.assembly_prods_y2016_m101112 assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx definition check', 'select indexdef from pg_indexes where schemaname = ''api'' and indexname = ''assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx'';', 'CREATE INDEX assembly_prods_y2016_m101112_assembly_id_marked_for_deletio_idx ON api.assembly_prods_y2016_m101112 USING btree (assembly_id) INCLUDE (marked_for_deletion)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');