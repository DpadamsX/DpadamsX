﻿select * from test_case_setup('Procedure', 'Global', 'procedure_list', '', 'Procedure list comparison', 'select string_agg(oid::regprocedure::text, '','' order by oid::regprocedure::text) as procedure_list  from pg_proc where prokind = ''p''   and pronamespace::regnamespace::text NOT IN (''information_schema'',''pg_catalog'',''extensions'');', 'cleanup_fuzzy_text(),count_targets(),system_delete_marked_and_log_sp(),view_register(citext,citext,citext,citext)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');