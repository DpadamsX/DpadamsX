﻿------------------------------------------------------------------------------------- Checks for dba.analytic_scan analytic_scan_ndistinct_hsys statistic------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Statistic', 'dba', 'analytic_scan_ndistinct_hsys', '', 'dba.analytic_scan analytic_scan_ndistinct_hsys existence check', 'select count(*)  from pg_catalog.pg_statistic_ext  where stxrelid::regclass::text           = ''analytic_scan''    and stxnamespace::regnamespace::text   = ''dba''   and stxname                            = ''analytic_scan_ndistinct_hsys''', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Statistic', 'dba', 'analytic_scan_ndistinct_hsys', '', 'dba.analytic_scan analytic_scan_ndistinct_hsys definition check', 'select pg_get_statisticsobjdef(oid)  from pg_catalog.pg_statistic_ext  where stxrelid::regclass::text           = ''analytic_scan''    and stxnamespace::regnamespace::text   = ''dba''   and stxname                            = ''analytic_scan_ndistinct_hsys''', 'CREATE STATISTICS dba.analytic_scan_ndistinct_hsys (ndistinct) ON hsys_id, facility_id FROM analytic_scan', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');