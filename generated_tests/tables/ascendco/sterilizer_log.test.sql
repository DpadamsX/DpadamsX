﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','sterilizer_log','','Table column strict check for ascendco.sterilizer_log','select * from ascendco.sterilizer_log limit 0;','id	log_type	summary_json	log_xml	data_file_id','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','sterilizer_log','','Table column orderless check for ascendco.sterilizer_log','select * from ascendco.sterilizer_log limit 0;','data_file_id	id	log_type	log_xml	summary_json','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);