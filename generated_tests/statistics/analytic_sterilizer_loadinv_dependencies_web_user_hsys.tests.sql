﻿------------------------------------------------------------------------------------- Checks for dba.analytic_sterilizer_loadinv analytic_sterilizer_loadinv_dependencies_web_user_hsys statistic------------------------------------------------------------------------------------- Existence check:select * from test_case_setup('Statistic', 'dba', 'analytic_sterilizer_loadinv_dependencies_web_user_hsys', '', 'dba.analytic_sterilizer_loadinv analytic_sterilizer_loadinv_dependencies_web_user_hsys existence check', 'select count(*)  from pg_catalog.pg_statistic_ext  where stxrelid::regclass::text           = ''analytic_sterilizer_loadinv''    and stxnamespace::regnamespace::text   = ''dba''   and stxname                            = ''analytic_sterilizer_loadinv_dependencies_web_user_hsys''', '1', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');-- Definition check:select * from test_case_setup('Statistic', 'dba', 'analytic_sterilizer_loadinv_dependencies_web_user_hsys', '', 'dba.analytic_sterilizer_loadinv analytic_sterilizer_loadinv_dependencies_web_user_hsys definition check', 'select pg_get_statisticsobjdef(oid)  from pg_catalog.pg_statistic_ext  where stxrelid::regclass::text           = ''analytic_sterilizer_loadinv''    and stxnamespace::regnamespace::text   = ''dba''   and stxname                            = ''analytic_sterilizer_loadinv_dependencies_web_user_hsys''', 'CREATE STATISTICS dba.analytic_sterilizer_loadinv_dependencies_web_user_hsys (dependencies) ON hsys_id, web_user_id FROM analytic_sterilizer_loadinv', '', 'text', '{"comparator":"equals","column_order":"ignore","case_sensitivity":"blind","whitespace_cleaning":"all","normalize_line_endings":true}', 'Pass', '{user_change_structure}', FALSE, FALSE, '', '');