﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','item_type_v1','','View column strict check for types_plus.item_type_v1','select * from types_plus.item_type_v1 limit 0;','id	marked_for_deletion	name_','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','item_type_v1','','View column orderless check for types_plus.item_type_v1','select * from types_plus.item_type_v1 limit 0;','id	marked_for_deletion	name_','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);