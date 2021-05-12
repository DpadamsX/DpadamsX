﻿-- Create a casting function to convert productivity_detail rows into the compound type format productivity_detail_v1.-- If productivity_detail changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.productivity_detail_to_v1 (productivity_detail_in productivity_detail)  RETURNS productivity_detail_v1AS $BODY$                   SELECT			productivity_detail_in.id,			productivity_detail_in.source_record_row_counter,			productivity_detail_in.start_time_dts,			productivity_detail_in.source_table_number,			productivity_detail_in.data_file_id,			productivity_detail_in.user_id,			productivity_detail_in.facility_id,			productivity_detail_in.assembly_inst,			productivity_detail_in.assembly_pack,			productivity_detail_in.assembly_tray,			productivity_detail_in.assembly_points,			productivity_detail_in.assembly_seconds_trays,			productivity_detail_in.assembly_seconds_overall,			productivity_detail_in.pause_seconds,			productivity_detail_in.duration_seconds,			productivity_detail_in.placeholder_row,			productivity_detail_in.description,			productivity_detail_in.year_and_month,			productivity_detail_in.start_date,			productivity_detail_in.time_label,			productivity_detail_in.duration,			productivity_detail_in.pause_time,			productivity_detail_in.activity,			productivity_detail_in.user_label               $BODY$LANGUAGE sql;  ALTER FUNCTION types_plus.productivity_detail_to_v1 (productivity_detail_in productivity_detail)	OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert productivity_detail rows into the productivity_detail_v1 compound type format using the following syntax:-- select productivity_detail::productivity_detail_v1 from productivity_detailDROP CAST IF EXISTS (productivity_detail as productivity_detail_v1);CREATE CAST (productivity_detail as productivity_detail_v1) WITH FUNCTION types_plus.productivity_detail_to_v1(productivity_detail);