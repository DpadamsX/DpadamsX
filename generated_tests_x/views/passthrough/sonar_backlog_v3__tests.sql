﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','passthrough','sonar_backlog_v3','','View column strict check for passthrough.sonar_backlog_v3','select * from passthrough.sonar_backlog_v3 limit 0;','HsysName	FacilityName	BacklogDTS	OverallBacklog	CleanBacklog	DirtyInstBacklog	Backlog_FiscalWeekNo	Backlog_HourBin	Backlog_DayOfWeek	Backlog_MonthNo	OverallInstBacklog	Backlog_HourOfDay	DirtyBacklog	Backlog_YearNo	CleanInstBacklog	Backlog_Date	Backlog_Year	DateTime	Backlog_Local	Backlog_FiscalWeek	DateHour	Backlog_DayName	Backlog_Month','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','passthrough','sonar_backlog_v3','','View column orderless check for passthrough.sonar_backlog_v3','select * from passthrough.sonar_backlog_v3 limit 0;','Backlog_Date	Backlog_DayName	Backlog_DayOfWeek	Backlog_FiscalWeek	Backlog_FiscalWeekNo	Backlog_HourBin	Backlog_HourOfDay	Backlog_Local	Backlog_Month	Backlog_MonthNo	Backlog_Year	Backlog_YearNo	BacklogDTS	CleanBacklog	CleanInstBacklog	DateHour	DateTime	DirtyBacklog	DirtyInstBacklog	FacilityName	HsysName	OverallBacklog	OverallInstBacklog','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);