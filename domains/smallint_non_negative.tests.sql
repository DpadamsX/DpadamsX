--------------------- Good inputs.-------------------select null from test_case_setup('Domain', 'domains', 'smallint_not_negative', '', 'Check 0', 'select 0::smallint_non_negative;', '0', '', 'Longint', '{"comparison":"=","column_order":"Ignore"}', 'Pass', '{user_change_structure, user_iceberg}', FALSE);select null from test_case_setup('Domain', 'domains', 'smallint_not_negative', '', 'Check 1', 'select 1::smallint_non_negative;', '1', '', 'Longint', '{"comparison":"=","column_order":"Ignore"}', 'Pass', '{user_change_structure, user_iceberg}', FALSE);--------------------- Bad inputs-------------------select null from test_case_setup('Domain', 'domains', 'smallint_not_negative', '', 'Check -1', 'select (0-1)::smallint_non_negative; -- Need to use (0-1) to get a working test here, not an issue with real fields.', '', 'Error: 23514, ERROR:  value for domain smallint_non_negative violates check constraint "smallint_non_negative_check"', 'Longint', '{"comparison":"=","column_order":"Ignore"}', 'Fail', '{user_change_structure, user_iceberg}', FALSE);select null from test_case_setup('Domain', 'domains', 'smallint_not_negative', '', 'Check NULL', 'select NULL::smallint_non_negative', '', 'Error: 23502, ERROR:  domain smallint_non_negative does not allow null values', 'Longint', '{"comparison":"=","column_order":"Ignore"}', 'Fail', '{user_change_structure, user_iceberg}', FALSE);