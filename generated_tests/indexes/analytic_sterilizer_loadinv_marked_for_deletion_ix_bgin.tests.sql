﻿------------------------------------------------------------------------------------- Checks for ascendco.analytic_sterilizer_loadinv analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin index------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Index', 'ascendco', 'analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin', '', 'ascendco.analytic_sterilizer_loadinv analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin existence check', 'select count(*) from pg_indexes where schemaname = ''ascendco'' and indexname = ''analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin'';', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Index', 'ascendco', 'analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin', '', 'ascendco.analytic_sterilizer_loadinv analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin definition check', 'select indexdef from pg_indexes where schemaname = ''ascendco'' and indexname = ''analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin'';', 'CREATE INDEX analytic_sterilizer_loadinv_marked_for_deletion_ix_bgin ON ascendco.analytic_sterilizer_loadinv USING gin (marked_for_deletion) WHERE (marked_for_deletion = true)', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');