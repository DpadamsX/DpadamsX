﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','outlier_rule','','Table column strict check for ascendco.outlier_rule','select * from ascendco.outlier_rule limit 0;','id	schema_name	table_name	column_name	threshold	set_to','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','outlier_rule','','Table column orderless check for ascendco.outlier_rule','select * from ascendco.outlier_rule limit 0;','column_name	id	schema_name	set_to	table_name	threshold','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);