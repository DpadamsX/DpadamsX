﻿------------------------------------------------------------------------------------- Checks for dba.stat_facility stat_facility_dependencies_facility_hsys statistic------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Statistic', 'dba', 'stat_facility_dependencies_facility_hsys', '', 'dba.stat_facility stat_facility_dependencies_facility_hsys existence check', 'select count(*)  from pg_catalog.pg_statistic_ext  where stxrelid::regclass::text           = ''stat_facility''    and stxnamespace::regnamespace::text   = ''dba''   and stxname                            = ''stat_facility_dependencies_facility_hsys''', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Statistic', 'dba', 'stat_facility_dependencies_facility_hsys', '', 'dba.stat_facility stat_facility_dependencies_facility_hsys definition check', 'select pg_get_statisticsobjdef(oid)  from pg_catalog.pg_statistic_ext  where stxrelid::regclass::text           = ''stat_facility''    and stxnamespace::regnamespace::text   = ''dba''   and stxname                            = ''stat_facility_dependencies_facility_hsys''', 'CREATE STATISTICS dba.stat_facility_dependencies_facility_hsys (dependencies) ON facility_id, hsys_id FROM stat_facility', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');