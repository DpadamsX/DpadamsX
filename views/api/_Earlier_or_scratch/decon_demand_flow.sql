CREATE OR REPLACE VIEW api.decon_demand_flow AS-- Get only the data needed from analytic_scan.-- Notice that the date WHERE is in here, that helps with the speed.WITHanalytic_scan_data AS (    select GREATEST(1, analytic_scan.num_inst) AS "NumInst",           analytic_scan.tray_or_pack AS "TrayOrPack",           COALESCE(hsys.name_, ''::citext) AS "HsysName",           COALESCE(facility.name_, ''::citext) AS "FacilityName",           analytic_scan.associated_to AS "AssociatedTo",           date(analytic_scan.scan_time_local_dts) AS "ScanTime_Date",           (date_part('dow'::text, analytic_scan.scan_time_local_dts))::integer AS "ScanTime_DayOfWeek",           to_char(analytic_scan.scan_time_local_dts, 'Day'::text) AS "ScanTime_DayName",           (date_part('hour'::text, analytic_scan.scan_time_local_dts))::integer AS "ScanTime_HourOfDay",           hour_bin_get_bin((date_part('hour'::text, analytic_scan.scan_time_local_dts))::integer) AS "ScanTime_HourBin",           hour_bin_get_bin_label((date_part('hour'::text, analytic_scan.scan_time_local_dts))::integer) AS "ScanTime_HourBinName"    from  analytic_scanleft join hsys     ON (analytic_scan.hsys_id = hsys.id)left join facility ON (analytic_scan.facility_id = facility.id)   where analytic_scan.scan_time_local_dts >= (current_date - interval '8 weeks')),-- Get the basic details and counts. These values then have names that can be used-- in the following CTE ("WITH" search)total as (SELECT  "HsysName", "FacilityName", "ScanTime_Date", "ScanTime_DayOfWeek", "ScanTime_DayName", "ScanTime_HourOfDay", "AssociatedTo", SUM("NumInst") as totalflow, COUNT("TrayOrPack") as trayflowFROM  analytic_scan_dataGROUP BY  "HsysName", "FacilityName", "ScanTime_Date", "ScanTime_DayOfWeek", "ScanTime_DayName", "ScanTime_HourOfDay", "AssociatedTo")-- Final results, pull everything together.SELECT  "HsysName", "FacilityName", "ScanTime_Date", "ScanTime_DayOfWeek", "ScanTime_DayName", "ScanTime_HourOfDay", "AssociatedTo", AVG (totalflow) AS "AvgInstFlow", AVG (trayflow)  As "AvgTrayFlow"FROM totalGROUP BY  "HsysName", "FacilityName", "ScanTime_Date", "ScanTime_DayOfWeek", "ScanTime_DayName", "ScanTime_HourOfDay", "AssociatedTo";ALTER VIEW api.decon_demand_flow	OWNER TO user_change_structure;-------------------------------------------------- Register view------------------------------------------------CALL view_register ('api','decon_demand_flow','Average demand by hour for the past eight weeks.','PROD Decon Demand Flow PG');