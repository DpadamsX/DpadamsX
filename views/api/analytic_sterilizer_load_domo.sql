DROP VIEW IF EXISTS api.analytic_sterilizer_load_domo;CREATE VIEW api.analytic_sterilizer_load_domo AS WITH expanded_data AS (         SELECT hsys.name_                                                                                                 AS "HsysName",            facility.name_                                                                                                 AS "FacilityName",            COALESCE(web_user.name_full, ''::citext)                                                                       AS "UserName",            COALESCE(sterilizer.name_, ''::citext)                                                                         AS "Sterilizer",            analytic_sterilizer_load.status                                                                                AS "Status",            COALESCE(sterilize_method.name_, ''::citext)                                                                   AS "Method",            COALESCE(sterilize_params.name_, ''::citext)                                                                   AS "Params",            (analytic_sterilizer_load.is_iuss)::text                                                                       AS "isIUSS",            analytic_sterilizer_load.trays_count                                                                           AS "NumTrays",            analytic_sterilizer_load.packs_count                                                                           AS "NumPacks",            analytic_sterilizer_load.instruments_count                                                                     AS "NumInst",            analytic_sterilizer_load.status_building_dts                                                                   AS "Built_UTC",            analytic_sterilizer_load.status_building_dts                                                                   AS "BuiltDTS",            analytic_sterilizer_load.status_building_local_dts                                                             AS "Built_Local",            built_date.date_actual                                                                                         AS "Built_Date",            built_date.day_of_week_usa                                                                                     AS "Built_DayOfWeek",            built_date.day_name_abbreviated                                                                                AS "Built_DayName",            built_date.week_of_year_fiscal_name                                                                            AS "Built_FiscalWeek",   --  Week 24 2020            built_date.week_of_year_fiscal                                                                                 AS "Built_FiscalWeekNo", --  2020-24            built_date.month_actual                                                                                        AS "Built_MonthNo",            built_date.month_actual_name_abbreviated                                                                       AS "Built_MonthName",            built_date.month_fiscal                                                                                        AS "Built_FiscalMonthNo",            built_date.month_fiscal_name_abbreviated                                                                       AS "Built_FiscalMonthName",            to_char(built_date.year_actual, 'fm0000')                                                                      AS "Built_Year",            built_date.year_actual                                                                                         AS "Built_YearNo",            built_date.fiscal_year_abbr                                                                                    AS "Built_FiscalYear",            built_date.fiscal_year_abbr::int                                                                               AS "Built_FiscalYearNo",            (date_part('hour'::text, analytic_sterilizer_load.status_building_local_dts))::integer                         AS "Built_HourOfDay",            hour_bin_get_bin((date_part('hour'::text, analytic_sterilizer_load.status_building_local_dts))::integer)       AS "Built_HourBin",            hour_bin_get_bin_label((date_part('hour'::text, analytic_sterilizer_load.status_building_local_dts))::integer) AS "Built_HourBinName",            analytic_sterilizer_load.status_done_dts                                                                       AS "Done_UTC",            analytic_sterilizer_load.status_done_dts                                                                       AS "DoneDTS",            analytic_sterilizer_load.status_done_local_dts                                                                 AS "Done_Local",            analytic_sterilizer_load.status_done_local_dts                                                                 AS "DateTime_Local", -- 13-10-20: Consistent name for filters.            done_date.date_actual                                                                                          AS "Done_Date",            done_date.day_of_week_usa                                                                                      AS "Done_DayOfWeek",            done_date.day_name_abbreviated                                                                                 AS "Done_DayName",            done_date.week_of_year_fiscal_name                                                                             AS "Done_FiscalWeek",   --  Week 24 2020            done_date.week_of_year_fiscal                                                                                  AS "Done_FiscalWeekNo", --  2020-24            done_date.month_actual                                                                                         AS "Done_MonthNo",            done_date.month_actual_name_abbreviated                                                                        AS "Done_MonthName",            done_date.month_fiscal                                                                                         AS "Done_FiscalMonthNo",            done_date.month_fiscal_name_abbreviated                                                                        AS "Done_FiscalMonthName",            to_char(done_date.year_actual, 'fm0000')                                                                       AS "Done_Year",            done_date.year_actual                                                                                          AS "Done_YearNo",            done_date.fiscal_year_abbr                                                                                     AS "Done_FiscalYear",            done_date.fiscal_year_abbr::int                                                                                AS "Done_FiscalYearNo",            (date_part('hour'::text, analytic_sterilizer_load.status_done_local_dts))::integer                             AS "Done_HourOfDay",            hour_bin_get_bin((date_part('hour'::text, analytic_sterilizer_load.status_done_local_dts))::integer)           AS "Done_HourBin",            hour_bin_get_bin_label((date_part('hour'::text, analytic_sterilizer_load.status_done_local_dts))::integer)     AS "Done_HourBinName",            analytic_sterilizer_load.id                                                                                   AS sterilizer_load_id           FROM analytic_sterilizer_load           LEFT JOIN sterilize_method ON analytic_sterilizer_load.sterilize_method_id = sterilize_method.id           LEFT JOIN sterilize_params ON analytic_sterilizer_load.sterilize_params_id = sterilize_params.id           LEFT JOIN sterilizer ON analytic_sterilizer_load.sterilizer_id = sterilizer.id           LEFT JOIN facility ON analytic_sterilizer_load.facility_id = facility.id           LEFT JOIN web_user ON analytic_sterilizer_load.web_user_id = web_user.id           LEFT JOIN hour_bin ON date_part('hour'::text, analytic_sterilizer_load.status_building_local_dts) = (hour_bin.bin_hour)::double precision           LEFT JOIN hsys ON facility.hsys_id = hsys.id       -- JOIN instead of LEFT JOIN to drop rows with invalid facility_id, invalid facility.calendar_id, or an epoch DTS.           JOIN calendar_day_plus built_date             ON (built_date.calendar_id = facility.calendar_id             AND built_date.date_actual = date(analytic_sterilizer_load.status_building_local_dts))       -- JOIN instead of LEFT JOIN to drop rows with invalid facility_id, invalid facility.calendar_id, or an epoch DTS.          JOIN calendar_day_plus done_date            ON (done_date.calendar_id = facility.calendar_id           AND done_date.date_actual = date(analytic_sterilizer_load.status_done_local_dts))         WHERE analytic_sterilizer_load.marked_for_deletion = false        ) SELECT expanded_data."HsysName",        expanded_data."FacilityName",        expanded_data."UserName",        expanded_data."Status",        expanded_data."Sterilizer",        expanded_data."Method",        expanded_data."Params",        expanded_data."isIUSS",        expanded_data."NumTrays",        expanded_data."NumPacks",        expanded_data."NumInst",        expanded_data."Built_UTC",        expanded_data."BuiltDTS",        expanded_data."Built_Local",        expanded_data."Built_Date",        expanded_data."Built_DayOfWeek",        expanded_data."Built_DayName",        expanded_data."Built_FiscalWeek",        expanded_data."Built_FiscalWeekNo",        expanded_data."Built_HourOfDay",        expanded_data."Built_HourBin",        expanded_data."Built_HourBinName",        expanded_data."Done_UTC",        expanded_data."DoneDTS",        expanded_data."Done_Local",        expanded_data."DateTime_Local", -- 13-10-20: Consistent name for filters.        expanded_data."Done_Date",        expanded_data."Done_DayOfWeek",        expanded_data."Done_DayName",        expanded_data."Done_FiscalWeek",        expanded_data."Done_FiscalWeekNo",        expanded_data."Done_HourOfDay",        expanded_data."Done_HourBin",        expanded_data."Done_HourBinName",    ntile(100) OVER (ORDER BY expanded_data."NumInst")  AS "NumInstValuePercentile",    ntile(100) OVER (ORDER BY expanded_data."NumPacks") AS "NumPacksValuePercentile",    ntile(100) OVER (ORDER BY expanded_data."NumTrays") AS "NumTraysValuePercentile",   sterilizer_load_id   FROM expanded_data;ALTER VIEW api.analytic_sterilizer_load_domo    OWNER TO user_change_structure;-------------------------------------------------- Register view------------------------------------------------CALL view_register ('api','analytic_sterilizer_load_domo','[SterilizerLoad] details','PROD Analytic Sterilizer Load PG');