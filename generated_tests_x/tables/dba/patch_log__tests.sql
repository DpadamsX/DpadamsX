﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','dba','patch_log','','Table column strict check for dba.patch_log','select * from dba.patch_log limit 0;','id	patch_dts	server_address	database_name	pg_version	user_name	patch_name	description	patch_hash','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','dba','patch_log','','Table column orderless check for dba.patch_log','select * from dba.patch_log limit 0;','database_name	description	id	patch_dts	patch_hash	patch_name	pg_version	server_address	user_name','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);