﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','analytic_sterilizer_loadinv_v2','','View column strict check for types_plus.analytic_sterilizer_loadinv_v2','select * from types_plus.analytic_sterilizer_loadinv_v2 limit 0;','id	data_file_id	marked_for_deletion	facility_id	hsys_id	inv_id	item_id	item_type_id	speciality_id	sterilize_method_id	sterilize_params_id	sterilizer_id	sterilizerload_id	web_user_id	inv_name_provided	is_iuss	num_inst	qty	category	clinic_dept_name	processing_seconds	done_dts	done_local_dts	status','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','analytic_sterilizer_loadinv_v2','','View column orderless check for types_plus.analytic_sterilizer_loadinv_v2','select * from types_plus.analytic_sterilizer_loadinv_v2 limit 0;','category	clinic_dept_name	data_file_id	done_dts	done_local_dts	facility_id	hsys_id	id	inv_id	inv_name_provided	is_iuss	item_id	item_type_id	marked_for_deletion	num_inst	processing_seconds	qty	speciality_id	status	sterilize_method_id	sterilize_params_id	sterilizer_id	sterilizerload_id	web_user_id','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);