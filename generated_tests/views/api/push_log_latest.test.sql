﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','api','push_log_latest','','View column strict check for api.push_log_latest','select * from api.push_log_latest limit 0;','id	data_file_id	server_name_	ib_table_name	ib_table_number	records_count	push_dts	age	minutes_old	app_name	app_version	shell_version	sync_version	iam_type	compiled	merged	type_of_4d	version_of_4d	machine_name	platform_description	os_tz_name	dts	push_log_minutes_old','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','api','push_log_latest','','View column orderless check for api.push_log_latest','select * from api.push_log_latest limit 0;','age	app_name	app_version	compiled	data_file_id	dts	iam_type	ib_table_name	ib_table_number	id	machine_name	merged	minutes_old	os_tz_name	platform_description	push_dts	push_log_minutes_old	records_count	server_name_	shell_version	sync_version	type_of_4d	version_of_4d','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);