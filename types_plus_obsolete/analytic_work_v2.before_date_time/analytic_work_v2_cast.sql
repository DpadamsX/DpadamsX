﻿-- Create a casting function to convert analytic_work rows into the compound type format analytic_work_v2.-- If analytic_work changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.analytic_work_to_v2 (analytic_work_in analytic_work)  RETURNS analytic_work_v2AS $BODY$                   SELECT			analytic_work_in.id,			analytic_work_in.key_supplement,			analytic_work_in.hsys_id,			analytic_work_in.facility_id,			analytic_work_in.inv_id,			analytic_work_in.user_id,			analytic_work_in.activity_id,			analytic_work_in.assembly_id,			analytic_work_in.q_event_id,			analytic_work_in.scan_id,			analytic_work_in.scase_id,			analytic_work_in.scase_inv_id,			analytic_work_in.sterilizer_load_id,			analytic_work_in.sterilizer_loadinv_id,			analytic_work_in.start_dts,			analytic_work_in.end_dts,			analytic_work_in.start_local_dts,			analytic_work_in.end_local_dts,			analytic_work_in.duration,			analytic_work_in.missing_inst,			analytic_work_in.num_inst,			analytic_work_in.num_items,			analytic_work_in.points,			analytic_work_in.num_packs,			analytic_work_in.num_trays,			analytic_work_in.activity,			analytic_work_in.description,			analytic_work_in.marked_for_deletion               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.analytic_work_to_v2 (analytic_work_in analytic_work)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert analytic_work rows into the analytic_work_v2 compound type format using the following syntax:-- select analytic_work::analytic_work_v2 from analytic_workDROP CAST IF EXISTS (analytic_work as analytic_work_v2);CREATE CAST (analytic_work as analytic_work_v2) WITH FUNCTION types_plus.analytic_work_to_v2(analytic_work);