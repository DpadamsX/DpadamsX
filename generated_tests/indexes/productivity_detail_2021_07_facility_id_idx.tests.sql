﻿------------------------------------------------------------------------------------- Checks for ascendco.productivity_detail_2021_07 productivity_detail_2021_07_facility_id_idx index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'productivity_detail_2021_07_facility_id_idx', '', 'ascendco.productivity_detail_2021_07 productivity_detail_2021_07_facility_id_idx existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''productivity_detail_2021_07_facility_id_idx'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'productivity_detail_2021_07_facility_id_idx', '', 'ascendco.productivity_detail_2021_07 productivity_detail_2021_07_facility_id_idx definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''productivity_detail_2021_07_facility_id_idx'';', 'CREATE INDEX productivity_detail_2021_07_facility_id_idx ON ascendco.productivity_detail_2021_07 USING btree (facility_id)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');