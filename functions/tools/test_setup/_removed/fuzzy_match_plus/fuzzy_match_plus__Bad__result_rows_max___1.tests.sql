﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_match_plus', '(citext, uuid, citext, citext, int4, float4, int4)', 'fuzzy_match_plus: Bad: result_rows_max < 1', 'select * from fuzzy_match_plus (   ''1 West Adult Finochietto Ret.'',   ''f00b4e79-880d-4efc-baa1-9f258e20ca7e'' ,    ''best_score'',   ''jarowinkler'',    5,    0.2,    0);', '', 'Error: KC200, ERROR:  result_rows_max value is too low.HINT:  Value must be 1 or higher.CONTEXT:  PL/pgSQL function fuzzy_match_plus(citext,uuid,citext,citext,integer,real,integer) line 171 at RAISE', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');