﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','hsys_v2','','View column strict check for types_plus.hsys_v2','select * from types_plus.hsys_v2 limit 0;','id	marked_for_deletion	name_	sonar_client_version	sonar_server_version	sonar_browser_version','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','hsys_v2','','View column orderless check for types_plus.hsys_v2','select * from types_plus.hsys_v2 limit 0;','id	marked_for_deletion	name_	sonar_browser_version	sonar_client_version	sonar_server_version','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);