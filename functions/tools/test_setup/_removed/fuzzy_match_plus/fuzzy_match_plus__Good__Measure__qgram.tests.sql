﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_match_plus', '(citext, uuid, citext, citext, int4, float4, int4)', 'fuzzy_match_plus: Good: Measure: qgram', 'select * from fuzzy_match_plus (   ''1 West Adult Finochietto Ret.'',   ''f00b4e79-880d-4efc-baa1-9f258e20ca7e'' ,    ''best_score'',   ''qgram'',    5,    0.2,    5);', '1	Tray Finochietto Retractor	A9CBAF086996E44CA744C297E115EC1C	Tray Finochietto Retractor	0.375	0.474576	0.474576	0.541111	0.735603	0.735603	0.594072	monge_elkan_quadratic', '', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');