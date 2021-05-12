﻿INSERT INTO ascendco.musc_orscansinout (            category,            clinic_dept_name,            event_,            facility_id,            facility_name,            hsys_id,            hsys_name,            inv_id,            inv_name,            item_id,            item_name,            item_type,            item_type_id,            location_desc,            num_inst,            scan_date,            scan_day_name,            scan_day_of_week,            scan_hour_bin,            scan_hour_of_day,            scan_local,            scan_dts,            scan_id,            scanned_at,            scanned_by,            scanned_desc,            scanned_dts,            scanned_record_id,            scanned_type,            speciality_id,            specialty,            state_,            substate,            timezone)      SELECT              expanded_data."Category",             expanded_data."ClinicDeptName",             expanded_data."Event",             expanded_data."FacilityID",             expanded_data."facilityName",             expanded_data."HsysID",             expanded_data."HsysName",             expanded_data."InvID",             expanded_data."InvName",             expanded_data."ItemID",             expanded_data."ItemName",             expanded_data."ItemType",             expanded_data."ItemTypeID",             expanded_data."locationDesc",             expanded_data."NumInst",             expanded_data."Scan_Date",             expanded_data."Scan_DayName",             expanded_data."Scan_DayOfWeek",             expanded_data."Scan_HourBin",             expanded_data."Scan_HourOfDay",             expanded_data."Scan_Local",             expanded_data."ScanDTS",             expanded_data."scanID",             expanded_data."scannedAt",             expanded_data."scannedBy",             expanded_data."scannedDesc",             expanded_data."scannedDTS",             expanded_data."scannedRecordID",             expanded_data."scannedType",             expanded_data."SpecialityID",             expanded_data."Specialty",             expanded_data."state",             expanded_data."substate",             expanded_data."timezone"        FROM domo_passthrough  CROSS JOIN jsonb_to_recordset(domo_passthrough.data) as expanded_data (             "Category" citext,             "ClinicDeptName" citext,             "Event" citext,             "FacilityID" uuid,             "facilityName" citext,             "HsysID" uuid,             "HsysName" citext,             "InvID" uuid,             "InvName" citext,             "ItemID" uuid,             "ItemName" citext,             "ItemType" citext,             "ItemTypeID" uuid,             "locationDesc" citext,             "NumInst" int4,             "Scan_Date" date,             "Scan_DayName" citext,             "Scan_DayOfWeek" int4,             "Scan_HourBin" int4,             "Scan_HourOfDay" int4,             "Scan_Local" timestamp,             "ScanDTS" timestamp,             "scanID" uuid,             "scannedAt" timestamp,             "scannedBy" citext,             "scannedDesc" citext,             "scannedDTS" timestamp,             "scannedRecordID" uuid,             "scannedType" citext,             "SpecialityID" uuid,             "Specialty" citext,             "state" citext,             "substate" citext,             "timezone" citext)       WHERE dataset_name = 'MUSC_OrScansInOut_PG' AND             view_version = '1'