﻿select * from test_case_setup('Function', 'ascendco', 'fuzzy_match', '(citext, uuid, int4, citext, float4, int4)', 'fuzzy_match: Bad: text_collection ID not found', 'select * from fuzzy_match (   ''1 West Adult Finochietto Ret.'',   ''00000000-0000-0000-0000-000000000000'' ,      5,   ''jaro'',    0.2,    5);', '', 'Error: KC100, ERROR:  text_collection not found with id = ''00000000-0000-0000-0000-000000000000''CONTEXT:  PL/pgSQL function fuzzy_match(citext,uuid,integer,citext,real,integer) line 143 at RAISE', 'text', '{"comparator":"equals","column_order":"Ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure, user_iceberg}', FALSE, TRUE, '', '');