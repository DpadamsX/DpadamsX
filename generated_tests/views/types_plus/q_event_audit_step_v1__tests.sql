﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','q_event_audit_step_v1','','View column strict check for types_plus.q_event_audit_step_v1','select * from types_plus.q_event_audit_step_v1 limit 0;','id	qevent_id	qaudit_step_id	last_updated_by_data_file_id	updated_dts	created_dts	sort	marked_for_deletion	is_coached	notes	created_by	updated_by	step	qsub_type_id_event	status','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','types_plus','q_event_audit_step_v1','','View column orderless check for types_plus.q_event_audit_step_v1','select * from types_plus.q_event_audit_step_v1 limit 0;','created_by	created_dts	id	is_coached	last_updated_by_data_file_id	marked_for_deletion	notes	qaudit_step_id	qevent_id	qsub_type_id_event	sort	status	step	updated_by	updated_dts','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);