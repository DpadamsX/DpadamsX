--------------------- Good inputs.-------------------select null from test_case_setup('domain','domains','test_outcome','',E'Check \'Pass\' mixed',E'select \'Pass\'::test_outcome','Pass','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','',E'Check \'Warning\' mixed',E'select \'Warning\'::test_outcome','Warning','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','',E'Check \'Fail\' mixed',E'select \'Fail\'::test_outcome','Fail','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','',E'Check \'PASS\' upper',E'select \'PASS\'::test_outcome','Pass','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','',E'Check \'WARNING\' upper',E'select \'WARNING\'::test_outcome','Warning','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','',E'Check \'FAIL\' upper',E'select \'FAIL\'::test_outcome','Fail','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);--------------------- Bad inputs-------------------select null from test_case_setup('domain','domains','test_outcome','','Check NULL',E'select NULL::test_outcome','','Error: 23502, ERROR:  domain test_outcome does not allow null values','Text','{"case":"blind"}','Fail','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','','Check empty string','select ''''::test_outcome','',E'Error: 23514, ERROR:  value for domain test_outcome violates check constraint "test_outcome_legal_values"','Text','{"case":"blind"}','Fail','{user_iceberg}',false);select null from test_case_setup('domain','domains','test_outcome','','Check bad string','select ''Bad string''::test_outcome','',E'Error: 23514, ERROR:  value for domain test_outcome violates check constraint "test_outcome_legal_values"','Text','{"case":"blind"}','Fail','{user_iceberg}',false);