﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','ascendco','domo_passthrough_plus','','View column strict check for ascendco.domo_passthrough_plus','select * from ascendco.domo_passthrough_plus limit 0;','id	source_id	key_supplement	hsys_name	facility_name	dataset_name	view_version	created_dts	age	minutes_old	from_dts	to_dts	data','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','ascendco','domo_passthrough_plus','','View column orderless check for ascendco.domo_passthrough_plus','select * from ascendco.domo_passthrough_plus limit 0;','age	created_dts	data	dataset_name	facility_name	from_dts	hsys_name	id	key_supplement	minutes_old	source_id	to_dts	view_version','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);