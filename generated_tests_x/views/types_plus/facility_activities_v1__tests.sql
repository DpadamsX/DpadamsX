﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','facility_activities_v1','','View column strict check for types_plus.facility_activities_v1','select * from types_plus.facility_activities_v1 limit 0;','id	facility_id	last_updated_by_data_file_id	created_dts	updated_dts	marked_for_deletion	name_	created_by	updated_by','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','facility_activities_v1','','View column orderless check for types_plus.facility_activities_v1','select * from types_plus.facility_activities_v1 limit 0;','created_by	created_dts	facility_id	id	last_updated_by_data_file_id	marked_for_deletion	name_	updated_by	updated_dts','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);