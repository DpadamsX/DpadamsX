﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','analytic_sterilizer_load_v1','','View column strict check for types_plus.analytic_sterilizer_load_v1','select * from types_plus.analytic_sterilizer_load_v1 limit 0;','id	marked_for_deletion	data_file_id	sterilize_method_id	sterilize_params_id	sterilizer_id	facility_id	web_user_id	status_building_dts	status_building_local_dts	status_done_dts	status_done_local_dts	status	is_iuss	instruments_count	packs_count	trays_count','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','analytic_sterilizer_load_v1','','View column orderless check for types_plus.analytic_sterilizer_load_v1','select * from types_plus.analytic_sterilizer_load_v1 limit 0;','data_file_id	facility_id	id	instruments_count	is_iuss	marked_for_deletion	packs_count	status	status_building_dts	status_building_local_dts	status_done_dts	status_done_local_dts	sterilize_method_id	sterilize_params_id	sterilizer_id	trays_count	web_user_id','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);