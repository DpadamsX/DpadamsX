﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_match', '(citext, uuid, citext, citext, int4, float4, int4)', 'fuzzy_match: Good: Pick by: qgram_score', 'select * from fuzzy_match (   ''1 West Adult Finochietto Ret.'',   ''f00b4e79-880d-4efc-baa1-9f258e20ca7e'' ,    ''trigram_score'',   ''jarowinkler'',    5,    0.2,    5);', '1	Tray Finochietto Retractor	A9CBAF086996E44CA744C297E115EC1C	Tray Finochietto Retractor	0.375	0.474576	0.637419	0.541111	0.637419	0.601177', '', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');