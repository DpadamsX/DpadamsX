﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','assembly_prods','','Table column strict check for ascendco.assembly_prods','select * from ascendco.assembly_prods limit 0;','id	data_file_id	assembly_id	item_prod_id	last_updated_by_data_file_id	created_dts	updated_dts	target	found_	repair	backup	actual	con_id	assembly_pos	marked_for_deletion	created_by	updated_by','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('Table','ascendco','assembly_prods','','Table column orderless check for ascendco.assembly_prods','select * from ascendco.assembly_prods limit 0;','actual	assembly_id	assembly_pos	backup	con_id	created_by	created_dts	data_file_id	found_	id	item_prod_id	last_updated_by_data_file_id	marked_for_deletion	repair	target	updated_by	updated_dts','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);