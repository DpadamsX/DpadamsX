-- Note: FacilityName and LocationName come FROM the same value and are identical. We're cloning an existing bug--       AS we don't want to break anything in Domo. The analytic_productivity table does have the facility_location ID,--       if we ever want to change how this view works.-- Note: For some reason, StartDate and Start_Date both exist with the same data. Becasue history.DROP VIEW IF EXISTS api.analytic_productivity_domo;CREATE VIEW api.analytic_productivity_domo ASWITH expanded_data AS(SELECT    hsys.name_                                     AS "HsysName",    facility.name_                                 AS "FacilityName",    facility.name_                                 AS "LocationName",    analytic_productivity.user_name                AS "UserName",    analytic_productivity.inv_name                 AS "InvName",    analytic_productivity.num_inst                 AS "NumInst",    analytic_productivity.assembly_minutes         AS "AssemblyMinute",    analytic_productivity.pause_minutes            AS "PauseMinute",    analytic_productivity.assembly_hour::real      AS "AssemblyHour",    analytic_productivity.pause_hour::real         AS "PauseHour",    specialty.name_                                AS "Specialty",    analytic_productivity.tray_or_pack             AS "TrayOrPack",    item_type.name_                                AS "ItemType",    analytic_productivity.item_name                AS "ItemName",    analytic_productivity.points::integer          AS "Points",    analytic_productivity.points_per_hour::integer AS "PointsPerHour",    analytic_productivity.start_utc AS "Start_UTC",    analytic_productivity.start_local AS "Start_Local",    start_local.date_actual                     AS "Start_Date",    start_local.date_actual                     AS "StartDate",    start_local.day_of_week_usa                 AS "Start_DayOfWeek",    start_local.day_name_abbreviated            AS "Start_DayName",    start_local.week_of_year_fiscal_name        AS "Start_FiscalWeek",   --  Week 24 2020    start_local.week_of_year_fiscal             AS "Start_FiscalWeekNo", --  2020-24    start_local.month_actual                    AS "Start_MonthNo",    start_local.month_actual_name_abbreviated   AS "Start_MonthName",    start_local.month_fiscal                    AS "Start_FiscalMonthNo",    start_local.month_fiscal_name_abbreviated   AS "Start_FiscalMonthName",    to_char(start_local.year_actual, 'fm0000')  AS "Start_Year",    start_local.year_actual                     AS "Start_YearNo",    start_local.fiscal_year_abbr                AS "Start_FiscalYear",    start_local.fiscal_year_abbr::int           AS "Start_FiscalYearNo",    date_part('hour', analytic_productivity.start_local)::integer                         AS "Start_HourOfDay",    hour_bin_get_bin(date_part('hour', analytic_productivity.start_local)::integer)       AS "Start_HourBin",    hour_bin_get_bin_label(date_part('hour', analytic_productivity.start_local)::integer) AS "Start_HourBinName",    analytic_productivity.end_utc               AS "End_UTC",    analytic_productivity.end_local             AS "End_Local",    end_local.date_actual                       AS "End_Date",    end_local.day_of_week_usa                   AS "End_DayOfWeek",    end_local.day_name_abbreviated              AS "End_DayName",    end_local.week_of_year_fiscal_name          AS "End_FiscalWeek",   --  Week 24 2020    end_local.week_of_year_fiscal               AS "End_FiscalWeekNo", --  2020-24    end_local.month_actual                      AS "End_MonthNo",    end_local.month_actual_name_abbreviated     AS "End_MonthName",    end_local.month_fiscal                      AS "End_FiscalMonthNo",    end_local.month_fiscal_name_abbreviated     AS "End_FiscalMonthName",    to_char(end_local.year_actual, 'fm0000')    AS "End_Year",    end_local.year_actual                       AS "End_YearNo",    end_local.fiscal_year_abbr                  AS "End_FiscalYear",    end_local.fiscal_year_abbr::int             AS "End_FiscalYearNo",    date_part('hour', analytic_productivity.end_local)::integer                         AS "End_HourOfDay",    hour_bin_get_bin(date_part('hour', analytic_productivity.end_local)::integer)       AS "End_HourBin",    hour_bin_get_bin_label(date_part('hour', analytic_productivity.end_local)::integer) AS "End_HourBinName"    FROM analytic_productivity    LEFT JOIN hsys                ON (analytic_productivity.hsys_id               = hsys.id)    LEFT JOIN facility            ON (analytic_productivity.facility_id           = facility.id)    LEFT JOIN facility_location   ON (analytic_productivity.facility_location_id  = facility_location.id)    LEFT JOIN specialty           ON (analytic_productivity.specialty_id          = specialty.id)    LEFT JOIN item_type           ON (analytic_productivity.item_type_id          = item_type.id)    LEFT JOIN data_file_info      ON (analytic_productivity.data_file_id          = data_file_info.id)    LEFT JOIN calendar_day_plus start_local           ON (start_local.calendar_id = facility.calendar_id          AND start_local.date_actual = date(analytic_productivity.start_local))    LEFT JOIN calendar_day_plus end_local           ON (end_local.calendar_id = facility.calendar_id          AND end_local.date_actual = date(analytic_productivity.end_local))  ) SELECT *,       ntile(100) over (order by "NumInst") AS "NumInstValuePercentile",       ntile(100) over (order by "AssemblyMinute") AS "AssemblyMinuteValuePercentile",       ntile(100) over (order by "PauseMinute") AS "PauseMinuteValuePercentile",       ntile(100) over (order by "Points") AS "PointsValuePercentile",       ntile(100) over (order by "PointsPerHour") AS "PointsPerHourValuePercentile"   FROM expanded_data  ;ALTER VIEW api.analytic_productivity_domo    OWNER TO user_change_structure;-------------------------------------------------- Register view------------------------------------------------CALL view_register ('api','analytic_productivity_domo','Analytic data, derived largely from [Assembly].','PROD Analytic Productivity PG');