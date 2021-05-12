﻿-- Create a casting function to convert sterilizer_load rows into the compound type format sterilizer_load_v2.-- If sterilizer_load changes, you can update the casting to handle the modification smoothly.CREATE OR REPLACE FUNCTION types_plus.sterilizer_load_to_v2 (sterilizer_load_in sterilizer_load)  RETURNS sterilizer_load_v2AS $BODY$        SELECT			sterilizer_load_in.id,			sterilizer_load_in.data_file_id,			sterilizer_load_in.marked_for_deletion,			sterilizer_load_in.sterilize_method_id,			sterilizer_load_in.sterilizer_id,			sterilizer_load_in.sterilize_params_id,			sterilizer_load_in.created_dts,			sterilizer_load_in.load_no,			sterilizer_load_in.status_building_dts,			sterilizer_load_in.status_sterilizing_dts,			sterilizer_load_in.status_cooling_dts,			sterilizer_load_in.status_done_dts,			sterilizer_load_in.notes,			sterilizer_load_in.failed_notes,			sterilizer_load_in.utcoffset_seconds$BODY$LANGUAGE sql;ALTER FUNCTION types_plus.sterilizer_load_to_v2 (sterilizer_load_in sterilizer_load) OWNER TO user_bender;-- Create/recreate the CAST. Use this to convert sterilizer_load rows into the sterilizer_load_v2 compound type format using the following syntax:-- select sterilizer_load::sterilizer_load_v2 from sterilizer_loadDROP CAST IF EXISTS (sterilizer_load as sterilizer_load_v2);CREATE CAST (sterilizer_load as sterilizer_load_v2) WITH FUNCTION types_plus.sterilizer_load_to_v2(sterilizer_load);