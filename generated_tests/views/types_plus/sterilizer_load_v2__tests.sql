﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','sterilizer_load_v2','','View column strict check for types_plus.sterilizer_load_v2','select * from types_plus.sterilizer_load_v2 limit 0;','id	data_file_id	marked_for_deletion	sterilize_method_id	sterilizer_id	sterilize_params_id	created_dts	load_no	status_building_dts	status_sterilizing_dts	status_cooling_dts	status_done_dts	notes	failed_notes	utcoffset_seconds','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','sterilizer_load_v2','','View column orderless check for types_plus.sterilizer_load_v2','select * from types_plus.sterilizer_load_v2 limit 0;','created_dts	data_file_id	failed_notes	id	load_no	marked_for_deletion	notes	status_building_dts	status_cooling_dts	status_done_dts	status_sterilizing_dts	sterilize_method_id	sterilize_params_id	sterilizer_id	utcoffset_seconds','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);