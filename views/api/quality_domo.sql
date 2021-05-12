DROP VIEW IF EXISTS api.quality_domo;

-- Query addapted from Will on Feb 11, 2021.
CREATE VIEW api.quality_domo AS

SELECT
    q_event.id                                          AS "id",
	q_event.created_dts        						    AS "CreatedDTS",
	q_event.datetime_local        						AS "DateTime_Local",
    COALESCE (q_type.name_,''::citext)                  AS "EventType",
    COALESCE (q_level.name_,''::citext)                 AS "Level",
    COALESCE (q_subtype.name_,''::citext)               AS "TheirSubType",
    COALESCE (q_subtype.name_,''::citext)               AS "AscendcoSubType",
    q_event.status                                      AS "status",
    q_event.status_when_name                            AS "UserName",
    inv.inv_no                                          AS "InvNo",
    item.name_                                          AS "ItemName",
    COALESCE (item_type.name_,''::citext)               AS "ItemType",
    COALESCE (specialty.name_,''::citext)               AS "Specialty",
    COALESCE (facility_department.name_,''::citext)     AS "Department",
    COALESCE (facility.name_, ''::citext)               AS "FacilityName",
    COALESCE (hsys.name_, ''::citext)                   AS "HsysName",

	q_event.datetime_local,
    scan_date.date_actual                               AS "Quality_Date",
    scan_date.day_of_week_usa                           AS "Quality_DayOfWeek",
    scan_date.day_name_abbreviated                      AS "Quality_DayName",
    scan_date.week_of_year_fiscal_name                  AS "Quality_FiscalWeek",   --  Week 24 2020
    scan_date.week_of_year_fiscal                       AS "Quality_FiscalWeekNo", --  2020-24
    scan_date.month_actual                              AS "Quality_MonthNo",
    scan_date.month_actual_name_abbreviated             AS "Quality_MonthName",
    scan_date.month_fiscal                              AS "Quality_FiscalMonthNo",
    scan_date.month_fiscal_name_abbreviated             AS "Quality_FiscalMonthName",
    to_char(scan_date.year_actual, 'fm0000')            AS "Quality_Year",
    scan_date.year_actual                               AS "Quality_YearNo",
    scan_date.fiscal_year_abbr::int                     AS "Quality_FiscalYearNo",

    (date_part('hour'::text, q_event.datetime_local))::integer                           AS "Quality_HourOfDay",
    hour_bin_get_bin((date_part('hour'::text,q_event.datetime_local))::integer)          AS "Quality_HourBin",
    hour_bin_get_bin_label((date_part('hour'::text, q_event.datetime_local))::integer)   AS "Quality_HourBinName"


FROM ascendco.q_event
LEFT JOIN ascendco.q_subtype            ON ascendco.q_event.qsub_type_id         = ascendco.q_subtype.id
LEFT JOIN ascendco.q_level              ON ascendco.q_subtype.qlevel_id          = ascendco.q_level.id
LEFT JOIN ascendco.q_type               ON ascendco.q_subtype.qtype_id           = ascendco.q_type.id
LEFT JOIN ascendco.facility             ON ascendco.q_event.facility_id          = ascendco.facility.id
LEFT JOIN ascendco.hsys                 ON ascendco.facility.hsys_id             = ascendco.hsys.id
LEFT JOIN ascendco.inv                  ON ascendco.q_event.inv_id               = ascendco.inv.id
LEFT JOIN ascendco.item                 ON ascendco.inv.item_id                  = ascendco.item.id
LEFT JOIN ascendco.facility_department  ON ascendco.item.facility_department_id  = ascendco.facility_department.id
LEFT JOIN ascendco.specialty            ON ascendco.item.specialty_id            = ascendco.specialty.id
LEFT JOIN ascendco.item_type            ON ascendco.item.item_type_id            = ascendco.item_type.id

JOIN calendar_day_plus scan_date
           ON (scan_date.calendar_id = facility.calendar_id
         AND scan_date.date_actual = date(ascendco.q_event.datetime_local))

WHERE ascendco.q_event.marked_for_deletion = 'false';

ALTER VIEW api.quality_domo
    OWNER TO user_change_structure;

------------------------------------------------
-- Register view
------------------------------------------------
CALL view_register ('api','quality_domo','quality data for Domo.');
