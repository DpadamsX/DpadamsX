﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','ascendco','focus_plus','','View column strict check for ascendco.focus_plus','select * from ascendco.focus_plus limit 0;','scase_id	hsys_id	hsys_name	facility_id	facility_name	sched_dts	or_name	case_seq	desc_	status	transport_from	surgeon_name	proc_name	when_','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','ascendco','focus_plus','','View column orderless check for ascendco.focus_plus','select * from ascendco.focus_plus limit 0;','case_seq	desc_	facility_id	facility_name	hsys_id	hsys_name	or_name	proc_name	scase_id	sched_dts	status	surgeon_name	transport_from	when_','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);