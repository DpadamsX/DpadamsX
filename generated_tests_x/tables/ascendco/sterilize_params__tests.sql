﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','sterilize_params','','Table column strict check for ascendco.sterilize_params','select * from ascendco.sterilize_params limit 0;','id	marked_for_deletion	data_file_id	hsys_id	sterilize_method_id	name_','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','sterilize_params','','Table column orderless check for ascendco.sterilize_params','select * from ascendco.sterilize_params limit 0;','data_file_id	hsys_id	id	marked_for_deletion	name_	sterilize_method_id','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);