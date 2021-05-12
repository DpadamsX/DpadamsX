DROP VIEW IF EXISTS api.analytic_sterilizer_loadinv_domo;CREATE VIEW api.analytic_sterilizer_loadinv_domo ASWITH expanded_data AS(SELECT --   analytic_sterilizer_load.status AS "Status",    hsys.name_                                                                                      AS "HsysName",    facility.name_                                                                                  AS "FacilityName",    web_user.name_full                                                                              AS "UserName",    specialty.name_                                                                                 AS "Specialty",    COALESCE(item_type.name_,'')                                                                    AS "ItemType",    item.name_                                                                                      AS "ItemName",    analytic_sterilizer_loadinv.inv_name_provided                                                   AS "InvName",    inv.their_name                                                                                  AS "InvName_TheirName",    greatest(1,analytic_sterilizer_loadinv.num_inst)                                                AS "NumInst",    (greatest(1,analytic_sterilizer_loadinv.num_inst) * analytic_sterilizer_loadinv.qty)            AS "NumInstExtended", -- Calculate extended count.    sterilizer.name_                                                                                AS "Sterilizer",    sterilize_method.name_                                                                          AS "Method",    sterilize_params.name_                                                                          AS "Params",    analytic_sterilizer_loadinv.is_iuss                                                             AS "isIUSS",    analytic_sterilizer_loadinv.qty                                                                 AS "Qty",    analytic_sterilizer_loadinv.category                                                            AS "Category",    analytic_sterilizer_loadinv.clinic_dept_name                                                    AS "ClinicDeptName",    analytic_sterilizer_loadinv.done_dts                                                            AS "DoneDTS",    analytic_sterilizer_loadinv.done_local_dts                                                      AS "Done_Local",    done_date.date_actual                                                                           AS "Done_Date",    done_date.day_of_week_usa                                                                       AS "Done_DayOfWeek",    done_date.day_name_abbreviated                                                                  AS "Done_DayName",    done_date.week_of_year_fiscal_name                                                              AS "Done_FiscalWeek",   --  Week 24 2020    done_date.week_of_year_fiscal                                                                   AS "Done_FiscalWeekNo", --  2020-24    done_date.month_actual                                                                          AS "Done_MonthNo",    done_date.month_actual_name_abbreviated                                                         AS "Done_MonthName",    done_date.month_fiscal                                                                          AS "Done_FiscalMonthNo",    done_date.month_fiscal_name_abbreviated                                                         AS "Done_FiscalMonthName",    to_char(done_date.year_actual, 'fm0000')                                                        AS "Done_Year",    done_date.year_actual                                                                           AS "Done_YearNo",    done_date.fiscal_year_abbr                                                                      AS "Done_FiscalYear",    done_date.fiscal_year_abbr::int                                                                 AS "Done_FiscalYearNo",    date_part('hour', analytic_sterilizer_loadinv.done_local_dts)::integer                          AS "Done_HourOfDay",    hour_bin_get_bin(date_part('hour', analytic_sterilizer_loadinv.done_local_dts)::INTEGER)        AS "Done_HourBin",    hour_bin_get_bin_label(date_part('hour', analytic_sterilizer_loadinv.done_local_dts)::INTEGER)  AS "Done_HourBinName",    analytic_sterilizer_loadinv.processing_seconds                                                  AS "Processing_Seconds"    FROM analytic_sterilizer_loadinv         JOIN analytic_sterilizer_load ON (analytic_sterilizer_loadinv.sterilizerload_id    = analytic_sterilizer_load.id AND analytic_sterilizer_load.status = 'Released')    LEFT JOIN sterilize_method         ON (analytic_sterilizer_loadinv.sterilize_method_id  = sterilize_method.id)    LEFT JOIN sterilize_params         ON (analytic_sterilizer_loadinv.sterilize_params_id  = sterilize_params.id)    LEFT JOIN sterilizer               ON (analytic_sterilizer_loadinv.sterilizer_id        = sterilizer.id)    LEFT JOIN facility                 ON (analytic_sterilizer_loadinv.facility_id          = facility.id)    LEFT JOIN data_file_info           ON (analytic_sterilizer_loadinv.data_file_id         = data_file_info.id)    LEFT JOIN web_user                 ON (analytic_sterilizer_loadinv.web_user_id          = web_user.id)    LEFT JOIN hsys                     ON (analytic_sterilizer_loadinv.hsys_id              = hsys.id)    LEFT JOIN inv                      ON (analytic_sterilizer_loadinv.inv_id               = inv.id)    LEFT JOIN item                     ON (analytic_sterilizer_loadinv.item_id              = item.id)    LEFT JOIN specialty                ON (analytic_sterilizer_loadinv.speciality_id        = specialty.id)    LEFT JOIN item_type                ON (analytic_sterilizer_loadinv.item_type_id         = item_type.id) /* We dont' always have a related item_type.*/    -- JOIN instead of LEFT JOIN to drop rows with invalid facility_id, invalid facility.calendar_id, or an epoch DTS.   JOIN calendar_day_plus done_date           ON (done_date.calendar_id = facility.calendar_id          AND done_date.date_actual  = date(analytic_sterilizer_loadinv.done_local_dts)) ) SELECT *,       ntile(100) over (order by "NumInst") AS "NumInstPercentile",       ntile(100) over (order by "Qty") AS "QtyPercentile"   FROM expanded_data;ALTER VIEW api.analytic_sterilizer_loadinv_domo    OWNER TO user_change_structure;-------------------------------------------------- Register view------------------------------------------------CALL view_register ('api','analytic_sterilizer_loadinv_domo','Analytic data derived largely from [SterilizerLoad_Inv].','PROD Analytic Load Inventory PG');