﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','dba','ddl_event_log_plus','','View column strict check for dba.ddl_event_log_plus','select * from dba.ddl_event_log_plus limit 0;','event_timestamp	age	schema_name	object_class	object_type	object_identity	object_name	command_tag	address_args	address_names	in_extension	trigger_event	id','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','dba','ddl_event_log_plus','','View column orderless check for dba.ddl_event_log_plus','select * from dba.ddl_event_log_plus limit 0;','address_args	address_names	age	command_tag	event_timestamp	id	in_extension	object_class	object_identity	object_name	object_type	schema_name	trigger_event','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);