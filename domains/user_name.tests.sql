--------------------- Good inputs.-------------------select null from test_case_setup('domain','domains','user_name','','Check postgres','select ''postgres''::user_name','postgres','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'rds_super\'',E'select \'rds_super\'::user_name','rds_super','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_bender\'',E'select \'user_bender\'::user_name','user_bender','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_change_structure\'',E'select \'user_change_structure\'::user_name','user_change_structure','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_cleanup\'',E'select \'user_cleanup\'::user_name','user_cleanup','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_domo_pull\'',E'select \'user_domo_pull\'::user_name','user_domo_pull','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_iceberg\'',E'select \'user_iceberg\'::user_name','user_iceberg','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_iceberg_remote\'',E'select \'user_iceberg_remote\'::user_name','user_iceberg_remote','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_leviathan\'',E'select \'user_leviathan\'::user_name','user_leviathan','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_reporting\'',E'select \'user_reporting\'::user_name','user_reporting','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_saws\'',E'select \'user_saws\'::user_name','user_saws','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'user_sonar\'',E'select \'user_sonar\'::user_name','user_sonar','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','',E'Check \'USER_CHANGE_STRUCTURE\' upper',E'select \'USER_CHANGE_STRUCTURE\'::user_name','user_change_structure','','Text','{"case":"blind"}','Pass','{user_iceberg}',false);--------------------- Bad inputs-------------------select null from test_case_setup('domain','domains','user_name','','Check NULL',E'select NULL::user_name','','Error: 23502, ERROR:  domain user_name does not allow null values','Text','{"case":"blind"}','Fail','{user_iceberg}');select null from test_case_setup('domain','domains','user_name','','Check empty string','select ''''::user_name','',E'Error: 23514, ERROR:  value for domain user_name violates check constraint "user_name_legal_values"','Text','{"case":"blind"}','Fail','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','','Check bad string','select ''Bad string''::user_name','',E'Error: 23514, ERROR:  value for domain user_name violates check constraint "user_name_legal_values"','Text','{"case":"blind"}','Fail','{user_iceberg}',false);select null from test_case_setup('domain','domains','user_name','','Check rds_admin','select ''Bad string''::user_name','',E'Error: 23514, ERROR:  value for domain user_name violates check constraint "user_name_legal_values"','Text','{"case":"blind"}','Fail','{user_iceberg}',false);