﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','domo_dataset','','Table column strict check for ascendco.domo_dataset','select * from ascendco.domo_dataset limit 0;','id	dataset_name	rows_count	columns_count	created_at_dts	updated_at_dts	late_threshold_minutes','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','domo_dataset','','Table column orderless check for ascendco.domo_dataset','select * from ascendco.domo_dataset limit 0;','columns_count	created_at_dts	dataset_name	id	late_threshold_minutes	rows_count	updated_at_dts','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);