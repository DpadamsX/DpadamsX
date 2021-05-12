﻿------------------------------------------------------------------- Test that the column list has not changed: Strict.-----------------------------------------------------------------select null from test_case_setup('View','api','analytic_sterilizer_loadinv_domo','','View column strict check for api.analytic_sterilizer_loadinv_domo','select * from api.analytic_sterilizer_loadinv_domo limit 0;','AnalyticSterilizerLoadinvID	HsysName	FacilityName	UserName	Specialty	ItemType	ItemName	InvName	InvName_TheirName	NumInst	Sterilizer	Method	Params	isIUSS	Qty	Category	ClinicDeptName	Status	DoneDTS	Done_Local	DateTime_Local	Done_Date	Done_DayOfWeek	Done_DayName	Done_FiscalWeek	Done_FiscalWeekNo	Done_MonthNo	Done_MonthName	Done_FiscalMonthNo	Done_FiscalMonthName	Done_Year	Done_YearNo	Done_FiscalYear	Done_FiscalYearNo	Done_HourOfDay	Done_HourBin	Done_HourBinName	Processing_Seconds	sterilizer_load_id	NumInstPercentile	QtyPercentile','','text','{"case_sensitvity":"sensitive","column_order":"strict"}','Pass','{user_change_structure}',false);------------------------------------------------------------------- Test that the column list has not changed: Orderless.-----------------------------------------------------------------select null from test_case_setup('View','api','analytic_sterilizer_loadinv_domo','','View column orderless check for api.analytic_sterilizer_loadinv_domo','select * from api.analytic_sterilizer_loadinv_domo limit 0;','AnalyticSterilizerLoadinvID	Category	ClinicDeptName	DateTime_Local	Done_Date	Done_DayName	Done_DayOfWeek	Done_FiscalMonthName	Done_FiscalMonthNo	Done_FiscalWeek	Done_FiscalWeekNo	Done_FiscalYear	Done_FiscalYearNo	Done_HourBin	Done_HourBinName	Done_HourOfDay	Done_Local	Done_MonthName	Done_MonthNo	Done_Year	Done_YearNo	DoneDTS	FacilityName	HsysName	InvName	InvName_TheirName	isIUSS	ItemName	ItemType	Method	NumInst	NumInstPercentile	Params	Processing_Seconds	Qty	QtyPercentile	Specialty	Status	Sterilizer	sterilizer_load_id	UserName','','text','{"case_sensitvity":"sensitive","column_order":"orderless"}','Pass','{user_change_structure}',false);