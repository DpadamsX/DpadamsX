﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','error_code','','Table column strict check for ascendco.error_code','select * from ascendco.error_code limit 0;','errcode	description','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','error_code','','Table column orderless check for ascendco.error_code','select * from ascendco.error_code limit 0;','description	errcode','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);