﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_compare', '(citext, citext, citext, citext, real, citext)', 'fuzzy_compare: Bad: Handicap too high', 'select * from fuzzy_compare(''1 West Adult Finochietto Ret'',''Tray Finochietto Retractor'','''','''',2)', '', 'Error: KC202, ERROR:  handicap_factor value is out of range.HINT:  Value must be in the range 0-1.CONTEXT:  PL/pgSQL function fuzzy_compare(citext,citext,citext,citext,real,citext) line 214 at RAISE', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');