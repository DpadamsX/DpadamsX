﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_compare', '(citext, citext, citext, citext, real, citext)', 'fuzzy_compare: Good: Defaults', 'select * from fuzzy_compare(''1 West Adult Finochietto Ret'',''Tray Finochietto Retractor'')', '1 West Adult Finochietto Ret	Tray Finochietto Retractor			0.755719	monge_elkan_quadratic	0.566196	0.75246	0.375	0	0.645219	0.645219	0.428571	0.571111	0.755719	0.528254	0.712862	0.482759	0.375	0.517241', '', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');